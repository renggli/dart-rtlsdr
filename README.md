[![Pub Package](https://img.shields.io/pub/v/rtlsdr.svg)](https://pub.dev/packages/rtlsdr)
[![Build Status](https://travis-ci.org/renggli/dart-rtlsdr.svg)](https://travis-ci.org/renggli/dart-rtlsdr)
[![GitHub Issues](https://img.shields.io/github/issues/renggli/dart-rtlsdr.svg)](https://github.com/renggli/dart-rtlsdr/issues)
[![GitHub Forks](https://img.shields.io/github/forks/renggli/dart-rtlsdr.svg)](https://github.com/renggli/dart-rtlsdr/network)
[![GitHub Stars](https://img.shields.io/github/stars/renggli/dart-rtlsdr.svg)](https://github.com/renggli/dart-rtlsdr/stargazers)
[![GitHub License](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/renggli/dart-rtlsdr/master/LICENSE)

Dart bindings for Software Defined Radio
======================================== 

This library is open source, stable and well tested. Development happens on [GitHub](https://github.com/renggli/dart-rtlsdr). Feel free to report issues or create a pull-request there. General questions are best asked on [StackOverflow](https://stackoverflow.com/questions/tagged/rtlsdr+dart).

The package is hosted on [dart packages](https://pub.dev/packages/rtlsdr). Up-to-date [class documentation](https://pub.dev/documentation/rtlsdr/) is created with every release.


Installation
------------

Follow the installation instructions on [dart packages](https://pub.dev/packages/rtlsdr#-installing-tab-).

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

License
-------

The MIT License, see [LICENSE](https://raw.githubusercontent.com/renggli/dart-rtlsdr/master/LICENSE).

