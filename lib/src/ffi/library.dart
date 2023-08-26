import 'dart:ffi';
import 'dart:io';

/// Paths to search the library in.
final Set<String> libraryPaths = _defaultLibraryPaths();

Set<String> _defaultLibraryPaths() {
  final result = <String>{''};
  if (Platform.isWindows) {
    // No clue where too look.
  } else if (Platform.isMacOS || Platform.isIOS) {
    result.addAll(
        ['~/lib', '/usr/local/lib', '/lib', '/usr/lib', '/opt/homebrew/lib']);
    final libraryPath = Platform.environment['DYLD_LIBRARY_PATH'] ?? '';
    result.addAll(libraryPath.split(':'));
    final fallbackLibraryPath =
        Platform.environment['DYLD_FALLBACK_LIBRARY_PATH'] ?? '';
    result.addAll(fallbackLibraryPath.split(':'));
  } else {
    final libraryPath = Platform.environment['LD_LIBRARY_PATH'] ?? '';
    result.addAll(libraryPath.split(':'));
  }
  return result;
}

/// Library names to search for.
final Set<String> libraryNames = _defaultLibraryNames();

Set<String> _defaultLibraryNames() {
  final result = <String>{};
  if (Platform.isWindows) {
    result.add('rtlsdr.dll');
  } else if (Platform.isMacOS || Platform.isIOS) {
    result.add('librtlsdr.dylib');
  } else {
    result.add('librtlsdr.so');
  }
  return result;
}

/// Tries to load the library from the provided paths.
DynamicLibrary loadLibrary() {
  for (final path in libraryPaths) {
    for (final name in libraryNames) {
      final fullName =
          path.isEmpty ? name : '$path${Platform.pathSeparator}$name';
      try {
        return DynamicLibrary.open(fullName);
      } on ArgumentError {
        continue;
      }
    }
  }
  throw UnsupportedError('Unable to load RTL-SDR library.');
}
