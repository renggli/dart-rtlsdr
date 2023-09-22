[![Pub Package](https://img.shields.io/pub/v/rtlsdr.svg)](https://pub.dev/packages/rtlsdr)
[![Build Status](https://github.com/renggli/dart-rtlsdr/actions/workflows/dart.yml/badge.svg?branch=main)](https://github.com/renggli/dart-rtlsdr/actions/workflows/dart.yml)
[![GitHub Issues](https://img.shields.io/github/issues/renggli/dart-rtlsdr.svg)](https://github.com/renggli/dart-rtlsdr/issues)
[![GitHub Forks](https://img.shields.io/github/forks/renggli/dart-rtlsdr.svg)](https://github.com/renggli/dart-rtlsdr/network)
[![GitHub Stars](https://img.shields.io/github/stars/renggli/dart-rtlsdr.svg)](https://github.com/renggli/dart-rtlsdr/stargazers)
[![GitHub License](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://raw.githubusercontent.com/renggli/dart-rtlsdr/master/LICENSE)

Dart bindings for Software Defined Radio
========================================

This library provides a simple Dart interface to devices supported by the RTL-SDR project. It wraps much of the functionality provided by the [librtlsdr library](https://github.com/librtlsdr/librtlsdr) in a convenient and typesafe way.

This library is open source, stable and well tested. Development happens on [GitHub](https://github.com/renggli/dart-rtlsdr). Feel free to report issues or create a pull-request there. General questions are best asked on [StackOverflow](https://stackoverflow.com/questions/tagged/rtlsdr+dart).

The package is hosted on [dart packages](https://pub.dev/packages/rtlsdr). Up-to-date [class documentation](https://pub.dev/documentation/rtlsdr/) is created with every release.


Installation
------------

First, make sure you have the most recent version of *librtlsdr* installed on your system, either through the [developer](https://github.com/librtlsdr/librtlsdr/releases) or your favorite package manager. Make sure the library is accessible to Dart.

Then follow the installation instructions on [dart packages](https://pub.dev/packages/rtlsdr/install).

```dart
import 'package:rtlsdr/rtlsdr.dart';
```


Tutorial
--------

```dart
import 'package:rtlsdr/rtlsdr.dart';
import 'dart:io';

void main() async {
  // Grab the first RTLSDR device.
  final device = RtlSdr.devices.first;
  // Print its name.
  stdout.writeln(device.name);
  // Open device.
  device.open();
  try {
    // Tune in.
    device.centerFrequency = 105800000;
    device.sampleRate = 2048000;
    // Print some samples from the first chunk.
    final data = await device.stream.first;
    stdout.writeln(data.take(100).join(', '));
  } finally {
    // Close the device at the end.
    device.close();
  }
}
```

# License

I am not a fan of the GNU General Public License, but it looks like that is the only option for code using _librtlsdr_. All the code contained here is thereby licensed by the [GNU General Public License v3](https://raw.githubusercontent.com/renggli/dart-rtlsdr/master/LICENSE).
