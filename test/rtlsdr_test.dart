import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:rtlsdr/rtlsdr.dart';
import 'package:rtlsdr/src/ffi/bindings.dart';
import 'package:rtlsdr/src/ffi/library.dart';
import 'package:test/test.dart';

void put(Pointer<Utf8> pointer, String value) {
  final list = pointer.cast<Uint8>().asTypedList(256);
  for (var i = 0; i < value.length; i++) {
    list[i] = value.codeUnitAt(i);
  }
  list[value.length] = 0;
}

void main() {
  tearDown(() => cachedBindings = null);
  test('no devices', () {
    cachedBindings = Bindings.forTesting(
      get_device_count: () => 0,
    );
    expect(getDevices(), isEmpty);
  });
  test('one device', () {
    cachedBindings = Bindings.forTesting(
      get_device_count: () => 1,
    );
    expect(getDevices(), [isA<Device>()]);
  });
  test('device name', () {
    cachedBindings = Bindings.forTesting(
      get_device_count: () => 1,
      get_device_name: (index) => Utf8.toUtf8('Device $index'),
    );
    final device = getDevices()[0];
    expect(device.bindings, same(cachedBindings));
    expect(device.index, 0);
    expect(device.name, 'Device 0');
    expect(device.toString(), 'Device 0');
  });
  test('device strings', () {
    cachedBindings = Bindings.forTesting(
        get_device_count: () => 1,
        get_device_usb_strings: (index, manufact, product, serial) {
          put(manufact, 'Manufacturer $index');
          put(product, 'Product $index');
          put(serial, 'Serial number $index');
          return 0;
        });
    final strings = getDevices()[0].deviceStrings;
    expect(strings.manufacturerName, 'Manufacturer 0');
    expect(strings.productName, 'Product 0');
    expect(strings.serialNumber, 'Serial number 0');
  });
}
