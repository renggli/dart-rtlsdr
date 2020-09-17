import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:rtlsdr/rtlsdr.dart';
import 'package:rtlsdr/src/ffi/bindings.dart';
import 'package:test/test.dart';

void put(Pointer<Utf8> pointer, String value) {
  final list = pointer.cast<Uint8>().asTypedList(256);
  for (var i = 0; i < value.length; i++) {
    list[i] = value.codeUnitAt(i);
  }
  list[value.length] = 0;
}

void main() {
  tearDown(() => bindings = null);
  group('DeviceInfo', () {
    test('no devices', () {
      bindings = Bindings.forTesting(
        get_device_count: () => 0,
      );
      expect(DeviceInfo.all, isEmpty);
    });
    test('multiple devices', () {
      bindings = Bindings.forTesting(
        get_device_count: () => 3,
      );
      final info = DeviceInfo.all.toList();
      expect(DeviceInfo.all, hasLength(3));
      for (var i = 0; i < info.length; i++) {
        expect(info[i].index, i);
      }
    });
    test('default', () {
      bindings = Bindings.forTesting(
        get_device_name: (index) => Utf8.toUtf8('Name $index'),
      );
      final info = DeviceInfo(0);
      expect(info.index, 0);
      expect(info.name, 'Name 0');
      expect(info.isValid, isTrue);
      expect(info.toString(), 'DeviceInfo{Name 0}');
    });
    test('manufacturer', () {
      bindings = Bindings.forTesting(
        get_device_usb_strings: (index, manufacturer, product, serial) {
          put(manufacturer, 'Manufacturer $index');
          return 0;
        },
      );
      final info = DeviceInfo(0);
      expect(info.manufacturer, 'Manufacturer 0');
    });
    test('product', () {
      bindings = Bindings.forTesting(
        get_device_usb_strings: (index, manufacturer, product, serial) {
          put(product, 'Product $index');
          return 0;
        },
      );
      final info = DeviceInfo(0);
      expect(info.product, 'Product 0');
    });
    test('serial', () {
      bindings = Bindings.forTesting(
        get_device_usb_strings: (index, manufacturer, product, serial) {
          put(serial, 'Serial $index');
          return 0;
        },
      );
      final info = DeviceInfo(0);
      expect(info.serial, 'Serial 0');
    });
    test('valid', () {
      bindings = Bindings.forTesting(
        get_device_name: (index) => Utf8.toUtf8(''),
      );
      final info = DeviceInfo(0);
      expect(info.isValid, isFalse);
    });
  });
  group('Device', () {
    test('fromInfo', () {
      bindings = Bindings.forTesting(
        open: (dev, index) {
          expect(index, 1);
          return 0;
        },
      );
      final device = DeviceInfo(1).open();
      expect(device.info.index, 1);
      expect(device.isClosed, isFalse);
    });
    test('fromIndex', () {
      bindings = Bindings.forTesting(
        open: (dev, index) {
          expect(index, 2);
          return 0;
        },
      );
      final device = Device.fromIndex(2);
      expect(device.info.index, 2);
      expect(device.isClosed, isFalse);
    });
    test('fromSerial', () {
      bindings = Bindings.forTesting(
        get_index_by_serial: (serial) {
          expect(Utf8.fromUtf8(serial), 'Serial');
          return 3;
        },
        open: (dev, index) {
          expect(index, 3);
          return 0;
        },
      );
      final device = Device.fromSerial('Serial');
      expect(device.info.index, 3);
      expect(device.isClosed, isFalse);
    });
  });
}
