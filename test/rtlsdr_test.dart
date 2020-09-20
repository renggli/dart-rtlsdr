import 'dart:ffi';

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
      expect(device.toString(), 'RtlSdr{Name 0}');
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
      );
      final device = RtlSdr(42);
      device.open();
      expect(device.isClosed, isFalse);
    });
    test('failing to open', () {
      bindings = Bindings.forTesting(
        open: (dev, index) => -4,
      );
      final device = RtlSdr();
      expect(
          () => device.open(),
          throwsA(isRtlSdrException.having((error) => error.message, 'message',
              'Unable to open device 0.')));
      expect(device.isClosed, isTrue);
    });
  });
}
