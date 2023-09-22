import 'dart:io';

import 'package:more/more.dart';

// ignore_for_file: lines_longer_than_80_chars
final declarations = [
  'uint32_t rtlsdr_get_device_count(void)',
  'char* rtlsdr_get_device_name(uint32_t index)',
  'int rtlsdr_get_device_usb_strings(uint32_t index, char *manufact, char *product, char *serial)',
  'int rtlsdr_get_index_by_serial(char *serial)',
  'int rtlsdr_open(rtlsdr_dev_t **dev, uint32_t index)',
  'int rtlsdr_close(rtlsdr_dev_t *dev)',
  'int rtlsdr_set_xtal_freq(rtlsdr_dev_t *dev, uint32_t rtl_freq, uint32_t tuner_freq)',
  'int rtlsdr_get_xtal_freq(rtlsdr_dev_t *dev, uint32_t *rtl_freq, uint32_t *tuner_freq)',
  'int rtlsdr_get_usb_strings(rtlsdr_dev_t *dev, char *manufact, char *product, char *serial)',
  'int rtlsdr_write_eeprom(rtlsdr_dev_t *dev, uint8_t *data, uint8_t offset, uint16_t len)',
  'int rtlsdr_read_eeprom(rtlsdr_dev_t *dev, uint8_t *data, uint8_t offset, uint16_t len)',
  'int rtlsdr_set_center_freq(rtlsdr_dev_t *dev, uint32_t freq)',
  'uint32_t rtlsdr_get_center_freq(rtlsdr_dev_t *dev)',
  'int rtlsdr_set_freq_correction(rtlsdr_dev_t *dev, int ppm)',
  'int rtlsdr_get_freq_correction(rtlsdr_dev_t *dev)',
  'int rtlsdr_get_tuner_type(rtlsdr_dev_t *dev)',
  'int rtlsdr_get_tuner_gains(rtlsdr_dev_t *dev, int *gains)',
  'int rtlsdr_set_tuner_gain(rtlsdr_dev_t *dev, int gain)',
  'int rtlsdr_set_tuner_bandwidth(rtlsdr_dev_t *dev, uint32_t bw)',
  'int rtlsdr_get_tuner_gain(rtlsdr_dev_t *dev)',
  'int rtlsdr_set_tuner_if_gain(rtlsdr_dev_t *dev, int stage, int gain)',
  'int rtlsdr_set_tuner_gain_mode(rtlsdr_dev_t *dev, int manual)',
  'int rtlsdr_set_sample_rate(rtlsdr_dev_t *dev, uint32_t rate)',
  'uint32_t rtlsdr_get_sample_rate(rtlsdr_dev_t *dev)',
  'int rtlsdr_set_testmode(rtlsdr_dev_t *dev, int on)',
  'int rtlsdr_set_agc_mode(rtlsdr_dev_t *dev, int on)',
  'int rtlsdr_set_direct_sampling(rtlsdr_dev_t *dev, int on)',
  'int rtlsdr_get_direct_sampling(rtlsdr_dev_t *dev)',
  'int rtlsdr_set_offset_tuning(rtlsdr_dev_t *dev, int on)',
  'int rtlsdr_get_offset_tuning(rtlsdr_dev_t *dev)',
  'int rtlsdr_reset_buffer(rtlsdr_dev_t *dev)',
  'int rtlsdr_read_sync(rtlsdr_dev_t *dev, void *buf, int len, int *n_read)',
  'int rtlsdr_wait_async(rtlsdr_dev_t *dev, rtlsdr_read_async_cb_t cb, void *ctx)',
  'int rtlsdr_read_async(rtlsdr_dev_t *dev, rtlsdr_read_async_cb_t cb, void *ctx, uint32_t buf_num, uint32_t buf_len)',
  'int rtlsdr_cancel_async(rtlsdr_dev_t *dev)',
  'int rtlsdr_set_bias_tee(rtlsdr_dev_t *dev, int on)',
];

final _methodRegExp = RegExp(r'^(.*\s+)rtlsdr_([^(]+)\((.*)\)$');
final _paramRegExp = RegExp(r'(.*?)(\w+)$');

class Method {
  Method(this.declaration) {
    final match = _methodRegExp.matchAsPrefix(declaration)!;
    result = Type(match.group(1)!.trim());
    name = match.group(2)!.trim();
    final args = match.group(3)!.trim();
    if (args == 'void') {
      arguments = [];
    } else {
      arguments = args.split(',').map(Parameter.new).toList();
    }
  }

  final String declaration;
  late Type result;
  late String name;
  late List<Parameter> arguments;

  String get dartName =>
      name.split('_').map((value) => value.toUpperCaseFirstCharacter()).join();

  String get dartMethodName => dartName.toLowerCaseFirstCharacter();

  String get dartTypeName => 'Dart$dartName';

  String get dartArguments =>
      arguments.map((arg) => '${arg.type.dartType} ${arg.name}').join(', ');

  String get dartMethodDeclaration =>
      '${result.dartType} $dartMethodName($dartArguments)';

  String get nativeTypeName => 'Native$dartName';

  String get nativeName => 'rtlsdr_$name';

  String get nativeArguments =>
      arguments.map((arg) => '${arg.type.nativeType} ${arg.name}').join(', ');

  String lookupFunction(String library) => '$library.lookupFunction'
      '<$nativeTypeName, $dartTypeName>(\'$nativeName\')';

  String get argumentNames => arguments.map((arg) => arg.name).join(', ');
}

class Parameter {
  Parameter(this.declaration) {
    final match = _paramRegExp.matchAsPrefix(declaration)!;
    type = Type(match.group(1)!.trim());
    name = match
        .group(2)!
        .trim()
        .split('_')
        .map((value) => value.toUpperCaseFirstCharacter())
        .join()
        .toLowerCaseFirstCharacter();
  }

  final String declaration;
  late Type type;
  late String name;
}

class Type {
  Type(String declaration)
      : declaration = const CharMatcher.whitespace().removeFrom(declaration);

  final String declaration;
  late String nativeType = _getNativeType(declaration);
  late String dartType = _getDartType(declaration);

  static String _getNativeType(String type) {
    switch (type) {
      case 'char':
        return 'Utf8';
      case 'int':
        return 'Int';
      case 'size_t':
        return 'Size';
      case 'int8_t':
        return 'Int8';
      case 'int16_t':
        return 'Int16';
      case 'int32_t':
        return 'Int32';
      case 'int64_t':
        return 'Int64';
      case 'uint8_t':
        return 'Uint8';
      case 'uint16_t':
        return 'Uint16';
      case 'uint32_t':
        return 'Uint32';
      case 'uint64_t':
        return 'Uint64';
      case 'void*':
        return 'Pointer<Void>';
      case 'rtlsdr_dev_t':
        return 'DeviceHandle';
      case 'rtlsdr_read_async_cb_t':
        return 'Pointer';
    }
    if (type.endsWith('*')) {
      return 'Pointer<${_getNativeType(type.removeSuffix('*'))}>';
    }
    throw UnsupportedError('Unknown native type: $type');
  }

  static String _getDartType(String type) {
    switch (type) {
      case 'char':
        return 'Utf8';
      case 'int':
      case 'int8_t':
      case 'int16_t':
      case 'int32_t':
      case 'int64_t':
      case 'uint8_t':
      case 'uint16_t':
      case 'uint32_t':
      case 'uint64_t':
      case 'size_t':
        return 'int';
      case 'void*':
        return 'Pointer<Void>';
      case 'rtlsdr_dev_t':
        return 'DeviceHandle';
      case 'rtlsdr_read_async_cb_t':
        return 'Pointer';
    }
    if (type.endsWith('*')) {
      return 'Pointer<${_getNativeType(type.removeSuffix('*'))}>';
    }
    throw UnsupportedError('Unknown Dart type: $type');
  }
}

/// Pretty prints and cleans up a Dart file.
Future<void> format(File file) async =>
    Process.run('dart', ['format', '--fix', file.absolute.path]);

void generateWarning(StringSink out) {
  out.writeln('// AUTO-GENERATED CODE: DO NOT EDIT');
  out.writeln();
}

Future<void> generateMethodTypes(List<Method> methods) async {
  final file = File('lib/src/generated/method_types.dart');
  final out = file.openWrite();
  generateWarning(out);
  out.writeln('// ignore_for_file: lines_longer_than_80_chars');
  out.writeln("import 'dart:ffi';");
  out.writeln();
  out.writeln("import 'package:ffi/ffi.dart';");
  out.writeln();
  out.writeln("import '../ffi/types.dart';");
  out.writeln();
  for (final method in methods) {
    out.writeln('// ${method.declaration}');
    out.writeln('typedef ${method.nativeTypeName} = '
        '${method.result.nativeType} Function(${method.nativeArguments});');
    out.writeln('typedef ${method.dartTypeName} = '
        '${method.result.dartType} Function(${method.dartArguments});');
    out.writeln();
  }
  await out.close();
  await format(file);
}

Future<void> generateAbstractBindings(List<Method> methods) async {
  final file = File('lib/src/generated/abstract_bindings.dart');
  final out = file.openWrite();
  generateWarning(out);
  out.writeln("import 'dart:ffi';");
  out.writeln();
  out.writeln("import 'package:ffi/ffi.dart';");
  out.writeln();
  out.writeln("import '../ffi/types.dart';");
  out.writeln();
  out.writeln('/// Abstract base class for the external bindings.');
  out.writeln('abstract class AbstractBindings {');
  for (final method in methods) {
    out.writeln('${method.dartMethodDeclaration};');
    out.writeln();
  }
  out.writeln('}');
  await out.close();
  await format(file);
}

Future<void> generateLazyBindings(List<Method> methods) async {
  final file = File('lib/src/generated/lazy_bindings.dart');
  final out = file.openWrite();
  generateWarning(out);
  out.writeln("import 'dart:ffi';");
  out.writeln();
  out.writeln("import 'package:ffi/ffi.dart';");
  out.writeln();
  out.writeln("import '../ffi/types.dart';");
  out.writeln("import 'abstract_bindings.dart';");
  out.writeln("import 'method_types.dart';");
  out.writeln();
  out.writeln('/// External bindings that get resolved with the first call.');
  out.writeln('class LazyBindings implements AbstractBindings {');
  out.writeln('LazyBindings(this._library);');
  out.writeln();
  out.writeln('final DynamicLibrary _library;');
  out.writeln();
  for (final method in methods) {
    out.writeln('@override');
    out.writeln('${method.dartMethodDeclaration} =>');
    out.writeln('(_${method.dartMethodName} ??= '
        '${method.lookupFunction('_library')})(${method.argumentNames});');
    out.writeln('${method.dartTypeName}? _${method.dartMethodName};');
    out.writeln();
  }
  out.writeln('}');
  await out.close();
  await format(file);
}

Future<void> generateEagerBindings(List<Method> methods) async {
  final file = File('lib/src/generated/eager_bindings.dart');
  final out = file.openWrite();
  generateWarning(out);
  out.writeln("import 'dart:ffi';");
  out.writeln();
  out.writeln("import 'package:ffi/ffi.dart';");
  out.writeln();
  out.writeln("import '../ffi/types.dart';");
  out.writeln("import 'abstract_bindings.dart';");
  out.writeln("import 'method_types.dart';");
  out.writeln();
  out.writeln('/// External bindings that get resolved initially.');
  out.writeln('class EagerBindings implements AbstractBindings {');
  out.writeln('EagerBindings(DynamicLibrary library) : ');
  out.writeln(methods
      .map((method) => '_${method.dartMethodName} = '
          '${method.lookupFunction('library')}')
      .join(',\n'));
  out.writeln(';');
  out.writeln();
  for (final method in methods) {
    out.writeln('@override');
    out.writeln('${method.dartMethodDeclaration} =>');
    out.writeln('_${method.dartMethodName}(${method.argumentNames});');
    out.writeln('final ${method.dartTypeName} _${method.dartMethodName};');
    out.writeln();
  }
  out.writeln('}');
  await out.close();
  await format(file);
}

Future<void> generateTestBindings(List<Method> methods) async {
  final file = File('lib/src/generated/test_bindings.dart');
  final out = file.openWrite();
  generateWarning(out);
  out.writeln("import 'dart:ffi';");
  out.writeln();
  out.writeln("import 'package:ffi/ffi.dart';");
  out.writeln();
  out.writeln("import '../ffi/types.dart';");
  out.writeln("import 'abstract_bindings.dart';");
  out.writeln("import 'method_types.dart';");
  out.writeln();
  out.writeln('/// External bindings for testing.');
  out.writeln('class TestBindings implements AbstractBindings {');
  out.writeln('TestBindings({');
  for (final method in methods) {
    out.writeln('${method.dartTypeName}? ${method.dartMethodName},');
  }
  out.writeln('}) {');
  for (final method in methods) {
    out.writeln('_${method.dartMethodName} = ${method.dartMethodName} '
        '?? ((${method.argumentNames}) => throw UnimplementedError(\'${method.dartMethodName}\'));');
  }
  out.writeln('}');
  out.writeln();
  for (final method in methods) {
    out.writeln('@override');
    out.writeln('${method.dartMethodDeclaration} =>');
    out.writeln('_${method.dartMethodName}(${method.argumentNames});');
    out.writeln('late ${method.dartTypeName} _${method.dartMethodName};');
    out.writeln();
  }
  out.writeln('}');
  await out.close();
  await format(file);
}

Future<void> main() async {
  final methods = declarations.map((declaration) {
    try {
      return Method(declaration);
      // ignore: avoid_catching_errors
    } on Error catch (error) {
      throw ArgumentError.value(declaration, 'declaration', error.toString());
    }
  }).toList(growable: false);
  await generateMethodTypes(methods);
  await generateAbstractBindings(methods);
  await generateLazyBindings(methods);
  await generateEagerBindings(methods);
  await generateTestBindings(methods);
}
