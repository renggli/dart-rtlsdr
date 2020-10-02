import 'dart:ffi';

final libraryPaths = [
  // Linux, Android
  'librtlsdr.so',
  // Max, iOS
  'librtlsdr.dylib',
  '/usr/lib/librtlsdr.dylib',
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
