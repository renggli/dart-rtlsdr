import '../rtlsdr.dart';

const Map<int, String> errorIds = {
  -1: 'LIBUSB_ERROR_IO',
  -2: 'LIBUSB_ERROR_INVALID_PARAM',
  -3: 'LIBUSB_ERROR_ACCESS',
  -4: 'LIBUSB_ERROR_NO_DEVICE',
  -5: 'LIBUSB_ERROR_NOT_FOUND',
  -6: 'LIBUSB_ERROR_BUSY',
  -7: 'LIBUSB_ERROR_TIMEOUT',
  -8: 'LIBUSB_ERROR_OVERFLOW',
  -9: 'LIBUSB_ERROR_PIPE',
  -10: 'LIBUSB_ERROR_INTERRUPTED',
  -11: 'LIBUSB_ERROR_NO_MEM',
  -12: 'LIBUSB_ERROR_NOT_SUPPORTED',
  -99: 'LIBUSB_ERROR_OTHER',
};

const Map<int, String> errorMessages = {
  -1: 'Input/output error',
  -2: 'Invalid parameter',
  -3: 'Access denied (insufficient permissions)',
  -4: 'No such device (it may have been disconnected)',
  -5: 'Entity not found',
  -6: 'Resource busy',
  -7: 'Operation timed out',
  -8: 'Overflow',
  -9: 'Pipe error',
  -10: 'System call interrupted (perhaps due to signal)',
  -11: 'Insufficient memory',
  -12: 'Operation not supported or unimplemented on this platform',
  -99: 'Other error',
};

class RtlSdrException implements Exception {
  /// Throws an [RtlSdrException], if the given [device] is not open.
  static void checkOpen(RtlSdr device) {
    if (device.isClosed) {
      throw RtlSdrException(0, '$device is closed.');
    }
  }

  static void checkError(int code, String message) {
    if (code < 0) {
      throw RtlSdrException(code, message);
    }
  }

  RtlSdrException(this.code, this.message);

  final int code;

  final String message;

  String get errorId => errorIds[code];

  String get errorMessage => errorMessages[code];

  @override
  String toString() {
    final buffer = StringBuffer('DeviceException');
    if (errorId != null && errorMessage != null) {
      buffer.write('<$errorId, $errorMessage>');
    } else {
      buffer.write('$code');
    }
    buffer.write(': $message');
    return buffer.toString();
  }
}
