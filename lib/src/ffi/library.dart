import 'dart:ffi';

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
    } on ArgumentError {
      continue;
    }
  }
  throw UnsupportedError('Unable to load librtlsdr.');
}

Bindings cachedBindings;

Bindings get bindings => cachedBindings ??= Bindings(loadLibrary());
