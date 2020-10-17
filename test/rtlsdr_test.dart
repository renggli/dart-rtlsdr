import 'dart:ffi';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';
import 'package:rtlsdr/rtlsdr.dart';
import 'package:rtlsdr/src/ffi/bindings.dart';
import 'package:rtlsdr/src/utils/errors.dart';
import 'package:test/test.dart';

void put(Pointer<Utf8> pointer, String value) {
  final list = pointer.cast<Uint8>().asTypedList(256);
  for (var i = 0; i < value.length; i++) {
    list[i] = value.codeUnitAt(i);
  }
  list[value.length] = 0;
}

final isRtlSdrException = isA<RtlSdrException>();

void main() {
  tearDown(() => bindings = null);
  group('constructors', () {
    test('no devices', () {
      bindings = Bindings.forTesting(
        get_device_count: () => 0,
      );
      expect(RtlSdr.devices, isEmpty);
    });
    test('multiple devices', () {
      bindings = Bindings.forTesting(
        get_device_count: () => 3,
      );
      final devices = RtlSdr.devices.toList();
      expect(devices, hasLength(3));
      for (var i = 0; i < devices.length; i++) {
        expect(devices[i].index, i);
      }
    });
    test('from serial', () {
      bindings = Bindings.forTesting(
        get_index_by_serial: (serial) {
          expect(Utf8.fromUtf8(serial), 'Serial');
          return 3;
        },
      );
      final device = RtlSdr.fromSerial('Serial');
      expect(device.index, 3);
    });
  });
  group('informational', () {
    test('name', () {
      bindings = Bindings.forTesting(
        get_device_name: (index) => Utf8.toUtf8('Name $index'),
      );
      final device = RtlSdr();
      expect(device.index, 0);
      expect(device.name, 'Name 0');
      expect(device.isValid, isTrue);
      expect(device.toString(), 'RtlSdr{0, Name 0}');
    });
    test('manufacturer', () {
      bindings = Bindings.forTesting(
        get_device_usb_strings: (index, manufacturer, product, serial) {
          put(manufacturer, 'Manufacturer $index');
          return 0;
        },
      );
      final device = RtlSdr(1);
      expect(device.manufacturer, 'Manufacturer 1');
    });
    test('product', () {
      bindings = Bindings.forTesting(
        get_device_usb_strings: (index, manufacturer, product, serial) {
          put(product, 'Product $index');
          return 0;
        },
      );
      final device = RtlSdr(2);
      expect(device.product, 'Product 2');
    });
    test('serial', () {
      bindings = Bindings.forTesting(
        get_device_usb_strings: (index, manufacturer, product, serial) {
          put(serial, 'Serial $index');
          return 0;
        },
      );
      final device = RtlSdr(3);
      expect(device.serial, 'Serial 3');
    });
    test('valid', () {
      bindings = Bindings.forTesting(
        get_device_name: (index) => Utf8.toUtf8(''),
      );
      final device = RtlSdr(4);
      expect(device.isValid, isFalse);
    });
  });
  group('opening and closing', () {
    test('initially closed', () {
      bindings = Bindings.forTesting();
      final device = RtlSdr();
      expect(device.isClosed, isTrue);
    });
    test('successful open', () {
      bindings = Bindings.forTesting(
        open: (dev, index) {
          expect(index, 42);
          return 0;
        },
        get_device_name: (index) => Utf8.toUtf8('Mock Device'),
      );
      final device = RtlSdr(42);
      device.open();
      expect(device.isClosed, isFalse);
    });
    test('failing to open', () {
      bindings = Bindings.forTesting(
        open: (dev, index) => -4,
        get_device_name: (index) => Utf8.toUtf8('Mokc Device'),
      );
      final device = RtlSdr();
      expect(
          () => device.open(),
          throwsA(isRtlSdrException.having((error) => error.message, 'message',
              'Unable to open device 0.')));
      expect(device.isClosed, isTrue);
    });
  });
  group('transforming', () {
    test('toAmplitude', () async {
      final input = Uint8List.fromList([121, 158, 44, 158, 69, 7, 194, 231]);
      final output = await Stream.fromIterable([input]).toAmplitude().first;
      expect(output, [973, 7903, 17943, 15135]);
    });
    test('toComponentI', () async {
      final input = Uint8List.fromList([0, 1, 2, 3, 4, 5, 6, 7]);
      final output = await Stream.fromIterable([input]).toComponentI().first;
      expect(output, [0, 2, 4, 6]);
    });
    test('toComponentQ', () async {
      final input = Uint8List.fromList([0, 1, 2, 3, 4, 5, 6, 7]);
      final output = await Stream.fromIterable([input]).toComponentQ().first;
      expect(output, [1, 3, 5, 7]);
    });
    test('toDiff', () async {
      final input1 = Int16List.fromList([-81, 42, -21, 124]);
      final input2 = Int16List.fromList([66, 102, -88, -93]);
      final output =
          await Stream.fromIterable([input1, input2]).toDiff().toList();
      expect(output, [
        [123, -63, 145],
        [-58, 36, -190, -5]
      ]);
    });
    test('toPhase', () async {
      final input = Uint8List.fromList([42, 11, 75, 111, 54, 5, 45, 252]);
      final output = await Stream.fromIterable([input]).toPhase().first;
      expect(output, [-2873, -3699, -2753, 2811]);
    });
  });
}
