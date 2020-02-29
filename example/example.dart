import 'dart:ffi';
import 'dart:math';

import 'package:ffi/ffi.dart';
import 'package:rtlsdr/rtlsdr.dart';
import 'package:more/iterable.dart';
import 'package:rtlsdr/src/ffi/signatures.dart';

const bufferLength = 16 * 16384;

int index = 0;
DeviceOpen open;

void onData(Pointer<Uint8> buf, int len, Pointer ctx) {
  print('${index++}. $buf $len $ctx');

  final list = buf.asTypedList(len);
//  for (var i = 0; i < list.length; i += 2) {
//    final a = list[i] - 127, b = list[i + 1] - 127;
//    final r = sqrt(a * a + b * b);
//    final p = atan2(a, b) * 180 / pi;
//    print('${a.toString()}\t'
//        '${b.toString()}\t'
//        '${r.toStringAsFixed(3)}\t'
//        '${p.toStringAsFixed(3)}');
//  }

  if (index == 10) {
    open.bindings.cancel_async(open.handle);
  }
}

void main() {
  getDevices().forEach((device) {
    print('Device: ${device}');

    final deviceStrings = device.deviceStrings;
    print('Manufacturer: ${deviceStrings.manufacturerName}');
    print('Product: ${deviceStrings.productName}');
    print('Serial: ${deviceStrings.serialNumber}');

    open = device.open();
    try {
      open.centerFrequency = 105800000;
      open.sampleRate = 2048000;
      print('Center Frequency: ${open.centerFrequency}Hz');
      print('Sample Rate: ${open.sampleRate}Hz');

      open.resetBuffer();
      if (open.bindings.read_async(
              open.handle,
              Pointer.fromFunction<rtlsdr_read_async_cb_t>(onData),
              nullptr,
              0,
              0) !=
          0) {
        print('Unable to read async.');
      }

//      Pointer<IntPtr> size = allocate<IntPtr>();
//      size.value = 0;
//      Pointer<Uint8> buffer = allocate<Uint8>(count: bufferLength);
//      try {
//        while (true) {
//          final error =
//              open.bindings.read_sync(open.handle, buffer, bufferLength, size);
//          if (error < 0) {
//            throw StateError('Unable to read device: $error');
//          }
//          final list = buffer.asTypedList(size.value);
//          for (var i = 0; i < list.length; i += 2) {
//            final a = list[i] - 127, b = list[i + 1] - 127;
//            final r = sqrt(a * a + b * b);
//            final p = atan2(a, b) * 180 / pi;
//            print('${a.toString()}\t'
//                '${b.toString()}\t'
//                '${r.toStringAsFixed(3)}\t'
//                '${p.toStringAsFixed(3)}');
//          }
//        }
//      } finally {
//        free(buffer);
//        free(size);
//      }
    } finally {
      open.close();
    }
  });
}
