library rtlsdr.devices;

import 'package:more/collection.dart';

import 'device.dart';
import 'ffi/library.dart';

/// Returns a list of the devices connected to the machine.
List<Device> getDevices() => 0
    .to(library.getDeviceCount())
    .map((index) => Device(binding, index))
    .toList(growable: false);
