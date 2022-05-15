import '../rtlsdr.dart';
import 'error_code.dart';

class RtlSdrException implements Exception {
  RtlSdrException(this.message, [this.errorCode]);

  final String message;
  final ErrorCode? errorCode;

  /// Throws an [RtlSdrException], if the given [device] is not open.
  static void checkOpen(RtlSdr device) {
    if (device.isClosed) {
      throw RtlSdrException('$device is closed');
    }
  }

  /// Throws an [RtlSdrException], if the given [code] is negative.
  static void checkError(int code, String message) {
    if (code < 0) {
      for (final errorCode in ErrorCode.values) {
        if (errorCode.code == code) {
          throw RtlSdrException(message, errorCode);
        }
      }
      throw RtlSdrException(message);
    }
  }

  @override
  String toString() {
    final buffer = StringBuffer('RtlSdrException');
    if (errorCode != null) {
      buffer.write('<${errorCode!.id}, ${errorCode!.message}>');
    }
    buffer.write(': $message');
    return buffer.toString();
  }
}
