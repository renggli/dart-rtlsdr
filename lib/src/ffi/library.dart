import 'dart:ffi';

import 'dart:io';

DynamicLibrary loadLibrary() {
  final files = <String>[
    'librtlsdr.so',
    'librtlsdr.dylib',
    'rtlsdr.dll',
  ];
  final paths = <String>['./'];
  if (Platform.isLinux) {
    final libraryPath = Platform.environment['LD_LIBRARY_PATH'] ?? '';
    paths.addAll(libraryPath.split(':'));
  } else if (Platform.isMacOS) {
    final libraryPath = Platform.environment['DYLD_FALLBACK_LIBRARY_PATH'] ??
        '~/lib:/usr/local/lib:/lib:/usr/lib';
    paths.addAll(libraryPath.split(':'));
  }
  for (final path in paths) {
    try {
      return DynamicLibrary.open(path);
    } on ArgumentError {
      continue;
    }
  }
  throw UnsupportedError('Unable to load RTL-SDR library.');
}
