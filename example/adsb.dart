import 'dart:io';
import 'dart:typed_data';

import 'package:rtlsdr/rtlsdr.dart';

const adsbRate = 2000000;
const adsbFreq = 1090000000;
const shortOutput = true;
const verboseOutput = true;
const preambleLen = 16;
const longFrame = 112;
const shortFrame = 56;
const quality = 10;
const allowedErrors = 5;
const messageGo = 253;
const overwrite = 254;
const badSample = 255;

final Uint16List squares = precomputeSquares();
final Uint8List adsbFrame = Uint8List(14);

Uint16List precomputeSquares() {
  final result = Uint16List(256);
  for (var i = 0; i < 256; i++) {
    final value = i - 127;
    result[i] = value * value;
  }
  return result;
}

Uint16List toMagnitudes(Uint8List buffer) {
  final result = Uint16List.view(buffer.buffer);
  for (var i = 0, j = 0; i < result.length; i++, j += 2) {
    result[i] = squares[buffer[j]] + squares[buffer[j + 1]];
  }
  return result;
}

/// Returns `true` if a preamble starts at [offset].
bool preamble(Uint16List buffer, int offset) {
  var low = 0;
  var high = 65535;
  for (var i = 0; i < preambleLen; i++) {
    switch (i) {
      case 0:
      case 2:
      case 7:
      case 9:
        //high = min16(high, buf[i+i2]);
        high = buffer[offset + i];
        break;
      default:
        //low  = max16(low,  buf[i+i2]);
        low = buffer[offset + i];
        break;
    }
    if (high <= low) {
      return false;
    }
  }
  return true;
}

// Takes 4 consecutive real samples, return 0 or 1, BADSAMPLE on error
int singleManchester(int a, int b, int c, int d) {
  final bitp = a > b;
  final bit = c > d;

  if (quality == 0) {
    return bit ? 1 : 0;
  }

  if (quality == 5) {
    if (bit && bitp && b > c) {
      return badSample;
    }
    if (!bit && !bitp && b < c) {
      return badSample;
    }
    return bit ? 1 : 0;
  }

  if (quality == 10) {
    if (bit && bitp && c > b) {
      return 1;
    }
    if (bit && !bitp && d < b) {
      return 1;
    }
    if (!bit && bitp && d > b) {
      return 0;
    }
    if (!bit && !bitp && c < b) {
      return 0;
    }
    return badSample;
  }

  if (bit && bitp && c > b && d < a) {
    return 1;
  }
  if (bit && !bitp && c > a && d < b) {
    return 1;
  }
  if (!bit && bitp && c < a && d > b) {
    return 0;
  }
  if (!bit && !bitp && c < b && d > a) {
    return 0;
  }
  return badSample;
}

void manchester(Uint16List buffer) {
  /* a and b hold old values to verify local manchester */
  var a = 0, b = 0;
  var bit = 0;
  var i = 0, i2 = 0, errors = 0;
  final maxi = buffer.length - 1;

  while (i < maxi) {
    /* find preamble */
    for (; i < (buffer.length - preambleLen); i++) {
      if (!preamble(buffer, i)) {
        continue;
      }
      a = buffer[i];
      b = buffer[i + 1];
      for (i2 = 0; i2 < preambleLen; i2++) {
        buffer[i + i2] = messageGo;
      }
      i += preambleLen;
      break;
    }
    i2 = i;
    errors = 0;
    /* mark bits until encoding breaks */
    for (; i < maxi; i += 2, i2++) {
      bit = singleManchester(a, b, buffer[i], buffer[i + 1]);
      a = buffer[i];
      b = buffer[i + 1];
      if (bit == badSample) {
        errors++;
        if (errors > allowedErrors) {
          buffer[i2] = badSample;
          break;
        } else {
          bit = a > b ? 1 : 0;
          /* these don't have to match the bit */
          a = 0;
          b = 65535;
        }
      }
      buffer[i] = buffer[i + 1] = overwrite;
      buffer[i2] = bit;
    }
  }
}

void messages(Uint16List buffer) {
  // todo, allow wrap across buffers
  for (var i = 0; i < buffer.length; i++) {
    if (buffer[i] > 1) {
      continue;
    }
    var frameLen = longFrame;
    var datai = 0;
    adsbFrame.fillRange(0, adsbFrame.length, 0);
    for (;
        // ignore: invariant_booleans
        i < buffer.length && buffer[i] <= 1 && datai < frameLen;
        i++, datai++) {
      if (buffer[i] != 0) {
        final index = datai ~/ 8;
        final shift = 7 - (datai % 8);
        adsbFrame[index] |= 1 << shift;
      }
      if (datai == 7) {
        if (adsbFrame[0] == 0) {
          break;
        }
        if (adsbFrame[0] & 0x80 != 0) {
          frameLen = longFrame;
        } else {
          frameLen = shortFrame;
        }
      }
    }
    if (datai < frameLen - 1) {
      continue;
    }
    display(adsbFrame, frameLen);
  }
}

void display(Uint8List buffer, int len) {
  if (!shortOutput && len <= shortFrame) {
    return;
  }
  final df = (buffer[0] >> 3) & 0x1f; // Downlink Format
  if (quality == 0 && !(df == 11 || df == 17 || df == 18 || df == 19)) {
    return;
  }
  stdout.write('*');
  for (var i = 0; i < ((len + 7) ~/ 8); i++) {
    stdout.write(buffer[i].toRadixString(16).padLeft(2, '0'));
  }
  stdout.writeln(';');
  if (!verboseOutput) {
    return;
  }
  final ca = buffer[0] & 0x07; // Capability
  stdout.writeln('DF=$df CA=$ca');
  final icaoAddress =
      buffer[1] << 16 | buffer[2] << 8 | buffer[3]; // ICAO aircraft address
  stdout
      .writeln('ICAO Address=${icaoAddress.toRadixString(16).padLeft(6, '0')}');
  if (len <= shortFrame) {
    return;
  }
  final pi = buffer[11] << 16 | buffer[12] << 8 | buffer[13]; // Data
  stdout.writeln('PI=${pi.toRadixString(16).padLeft(6, '0')}');
  final tc = (buffer[4] >> 3) & 0x1f; // Type code
  final ta = buffer[4] & 0x07;
  stdout.writeln('Type Code=$tc S.Type/Ant.=$ta');
  stdout.writeln('--------------');
}

Future<void> main() async {
  final device = RtlSdr()..open();
  try {
    device.centerFrequency = adsbFreq;
    device.sampleRate = adsbRate;
    await device.stream.forEach((data) {
      final buffer = toMagnitudes(data);
      manchester(buffer);
      messages(buffer);
    });
  } finally {
    device.close();
  }
}
