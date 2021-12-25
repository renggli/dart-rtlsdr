import 'dart:ffi';
import 'dart:typed_data';

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

final isRtlSdrException = isA<RtlSdrException>();

void main() {
  tearDown(() => bindings = TestBindings());
  group('constructors', () {
    test('no devices', () {
      bindings = TestBindings(
        getDeviceCount: () => 0,
      );
      expect(RtlSdr.devices, isEmpty);
    });
    test('multiple devices', () {
      bindings = TestBindings(
        getDeviceCount: () => 3,
      );
      final devices = RtlSdr.devices.toList();
      expect(devices, hasLength(3));
      for (var i = 0; i < devices.length; i++) {
        expect(devices[i].index, i);
      }
    });
    test('from serial', () {
      bindings = TestBindings(
        getIndexBySerial: (serial) {
          expect(serial.toDartString(), 'Serial');
          return 3;
        },
      );
      final device = RtlSdr.fromSerial('Serial');
      expect(device.index, 3);
    });
  });
  group('informational', () {
    test('name', () {
      bindings = TestBindings(
        getDeviceName: (index) => 'Name $index'.toNativeUtf8(),
      );
      final device = RtlSdr();
      expect(device.index, 0);
      expect(device.name, 'Name 0');
      expect(device.isValid, isTrue);
      expect(device.toString(), 'RtlSdr{0, Name 0}');
    });
    test('manufacturer', () {
      bindings = TestBindings(
        getDeviceUsbStrings: (index, manufacturer, product, serial) {
          put(manufacturer, 'Manufacturer $index');
          expect(product, nullptr);
          expect(serial, nullptr);
          return 0;
        },
      );
      final device = RtlSdr(1);
      expect(device.manufacturer, 'Manufacturer 1');
    });
    test('product', () {
      bindings = TestBindings(
        getDeviceUsbStrings: (index, manufacturer, product, serial) {
          expect(manufacturer, nullptr);
          put(product, 'Product $index');
          expect(serial, nullptr);
          return 0;
        },
      );
      final device = RtlSdr(2);
      expect(device.product, 'Product 2');
    });
    test('serial', () {
      bindings = TestBindings(
        getDeviceUsbStrings: (index, manufacturer, product, serial) {
          expect(manufacturer, nullptr);
          expect(product, nullptr);
          put(serial, 'Serial $index');
          return 0;
        },
      );
      final device = RtlSdr(3);
      expect(device.serial, 'Serial 3');
    });
    test('valid', () {
      bindings = TestBindings(
        getDeviceName: (index) => ''.toNativeUtf8(),
      );
      final device = RtlSdr(4);
      expect(device.isValid, isFalse);
    });
  });
  group('opening and closing', () {
    test('initially closed', () {
      bindings = TestBindings();
      final device = RtlSdr();
      expect(device.isClosed, isTrue);
    });
    test('successful open', () {
      bindings = TestBindings(
        open: (dev, index) {
          expect(index, 42);
          return 0;
        },
        getDeviceName: (index) => 'Mock Device'.toNativeUtf8(),
      );
      final device = RtlSdr(42);
      device.open();
      expect(device.isClosed, isFalse);
    });
    test('failing to open', () {
      bindings = TestBindings(
        open: (dev, index) => -4,
        getDeviceName: (index) => 'Mock Device'.toNativeUtf8(),
      );
      final device = RtlSdr();
      expect(
          device.open,
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
        [-81, 123, -63, 145],
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
