library rtlsdr.device_open;

import 'dart:ffi';

import 'device.dart';
import 'ffi/bindings.dart';
import 'ffi/types.dart';

class DeviceOpen extends Device {
  DeviceOpen(Bindings bindings, int index, this.handle)
      : super(bindings, index);

  final Pointer<DeviceHandle> handle;

  @override
  // TODO: implement manufacturerName
  String get manufacturerName => throw UnimplementedError();

  @override
  // TODO: implement productName
  String get productName => throw UnimplementedError();

  @override
  // TODO: implement serialNumber
  String get serialNumber => throw UnimplementedError();
}
