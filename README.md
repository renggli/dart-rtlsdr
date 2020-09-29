[![Pub Package](https://img.shields.io/pub/v/rtlsdr.svg)](https://pub.dev/packages/rtlsdr)
[![Build Status](https://travis-ci.org/renggli/dart-rtlsdr.svg)](https://travis-ci.org/renggli/dart-rtlsdr)
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

Then follow the installation instructions on [dart packages](https://pub.dev/packages/rtlsdr#-installing-tab-).

```dart
import 'package:rtlsdr/rtlsdr.dart';
```


Tutorial
--------

```dart
import 'package:rtlsdr/rtlsdr.dart';

void main() {
  // Grab the first RTLSDR device and print its name.
  final device = getDevices()[0];
  print(device.name);

  // Open device and tune-in.
  final open = device.open();
  try {
    open.centerFrequency = 105800000;
    open.sampleRate = 2048000;

    // Read some data.
    open.resetBuffer();
    open.readAsync((data) {
      print('${data.sublist(0, 100).join(', ')} ...');
      return false; // continue?
    });
  } finally {
    // Close the device at the end.
    open.close();
  }
}
```

# License

I am not a fan of the GNU General Public License, but it looks like that is the only option for code using _librtlsdr_. All the code contained here is thereby licensed by the [GNU General Public License v3](https://raw.githubusercontent.com/renggli/dart-rtlsdr/master/LICENSE).
