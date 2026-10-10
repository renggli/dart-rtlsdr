import 'package:checks/checks.dart';
import 'package:rtlsdr/rtlsdr.dart';
import 'package:rtlsdr/src/utils/error_code.dart';

/// Extension on [Subject] of [RtlSdrException] providing domain-specific checks.
extension RtlSdrExceptionChecks on Subject<RtlSdrException> {
  /// Extracts the exception message.
  Subject<String> get message => has((e) => e.message, 'message');

  /// Extracts the error code.
  Subject<ErrorCode?> get errorCode => has((e) => e.errorCode, 'errorCode');
}

/// Extension on [Subject] of [RtlSdr] providing domain-specific checks.
extension RtlSdrChecks on Subject<RtlSdr> {
  /// Extracts the device index.
  Subject<int> get index => has((d) => d.index, 'index');

  /// Extracts the device name.
  Subject<String> get name => has((d) => d.name, 'name');

  /// Extracts whether the device is valid.
  Subject<bool> get isValid => has((d) => d.isValid, 'isValid');

  /// Extracts whether the device is closed.
  Subject<bool> get isClosed => has((d) => d.isClosed, 'isClosed');

  /// Extracts the device manufacturer string.
  Subject<String> get manufacturer =>
      has((d) => d.manufacturer, 'manufacturer');

  /// Extracts the device product string.
  Subject<String> get product => has((d) => d.product, 'product');

  /// Extracts the device serial string.
  Subject<String> get serial => has((d) => d.serial, 'serial');
}
