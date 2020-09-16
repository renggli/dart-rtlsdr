import 'dart:ffi';

import 'package:meta/meta.dart';

import 'bindings.dart';

final libraryPaths = [
  // Linux, Android
  'librtlsdr.so',
  // Max, iOS
  'librtlsdr.dylib',
  '/usr/local/lib/librtlsdr.dylib',
  // Windows
  'rtlsdr.dll',
];

DynamicLibrary loadLibrary() {
  for (final path in libraryPaths) {
    try {
      return DynamicLibrary.open(path);
      // ignore: avoid_catching_errors
    } on ArgumentError {
      continue;
    }
  }
  throw UnsupportedError('Unable to load RTL-SDR library.');
}

/// Cached RTL-SDR library bindings.
@visibleForTesting
Bindings cachedBindings;

/// Return the currently loaded RTL-SDR library bindings.
Bindings get bindings => cachedBindings ??= Bindings(loadLibrary());
