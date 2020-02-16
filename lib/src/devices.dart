library rtlsdr.devices;

import 'package:more/collection.dart';

import 'device.dart';
import 'ffi/library.dart';

/// Returns a list of the devices connected to the machine.
List<Device> getDevices() => 0
    .to(bindings.get_device_count())
    .map((index) => Device(bindings, index))
    .toList(growable: false);
