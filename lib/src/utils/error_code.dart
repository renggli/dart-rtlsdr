enum ErrorCode {
  io(-1, 'LIBUSB_ERROR_IO', 'Input/output error'),
  invalidParam(-2, 'LIBUSB_ERROR_INVALID_PARAM', 'Invalid parameter'),
  access(-3, 'LIBUSB_ERROR_ACCESS', 'Access denied (insufficient permissions)'),
  noDevice(
    -4,
    'LIBUSB_ERROR_NO_DEVICE',
    'No such device (it may have been disconnected)',
  ),
  notFound(-5, 'LIBUSB_ERROR_NOT_FOUND', 'Entity not found'),
  busy(-6, 'LIBUSB_ERROR_BUSY', 'Resource busy'),
  timeout(-7, 'LIBUSB_ERROR_TIMEOUT', 'Operation timed out'),
  overflow(-8, 'LIBUSB_ERROR_OVERFLOW', 'Overflow'),
  pipe(-9, 'LIBUSB_ERROR_PIPE', 'Pipe error'),
  interrupted(
    -10,
    'LIBUSB_ERROR_INTERRUPTED',
    'System call interrupted (perhaps due to signal)',
  ),
  noMemory(-11, 'LIBUSB_ERROR_NO_MEM', 'Insufficient memory'),
  notSupported(
    -12,
    'LIBUSB_ERROR_NOT_SUPPORTED',
    'Operation not supported or unimplemented on this platform',
  ),
  other(-99, 'LIBUSB_ERROR_OTHER', 'Other error');

  const ErrorCode(this.code, this.id, this.message);

  final int code;
  final String id;
  final String message;
}
