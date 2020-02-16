library rtlsdr.ffi.signatures;

import 'dart:ffi';

import 'package:ffi/ffi.dart';

import 'types.dart';

// uint32_t rtlsdr_get_device_count(void);
typedef rtlsdr_get_device_count = Uint32 Function();

// char* rtlsdr_get_device_name(uint32_t index);
typedef rtlsdr_get_device_name = Pointer<Utf8> Function(Uint32 index);

// int rtlsdr_get_device_usb_strings(uint32_t index, char *manufact, char *product, char *serial);
typedef rtlsdr_get_device_usb_strings = IntPtr Function(Uint32 index,
    Pointer<Utf8> manufact, Pointer<Utf8> product, Pointer<Utf8> serial);

// int rtlsdr_get_index_by_serial(const char *serial);
typedef rtlsdr_get_index_by_serial = IntPtr Function(Pointer<Utf8> serial);

// int rtlsdr_open(rtlsdr_dev_t **dev, uint32_t index);
typedef rtlsdr_open = IntPtr Function(
    Pointer<Pointer<DeviceHandle>> dev, Uint32 index);

// int rtlsdr_close(rtlsdr_dev_t *dev);
typedef rtlsdr_close = IntPtr Function(Pointer<DeviceHandle> dev);

// int rtlsdr_set_xtal_freq(rtlsdr_dev_t *dev, uint32_t rtl_freq, uint32_t tuner_freq);
typedef rtlsdr_set_xtal_freq = IntPtr Function(
    Pointer<DeviceHandle> dev, Uint32 rtl_freq, Uint32 tuner_freq);

// int rtlsdr_get_xtal_freq(rtlsdr_dev_t *dev, uint32_t *rtl_freq, uint32_t *tuner_freq);
typedef rtlsdr_get_xtal_freq = IntPtr Function(Pointer<DeviceHandle> dev,
    Pointer<Uint32> rtl_freq, Pointer<Uint32> tuner_freq);

// int rtlsdr_get_usb_strings(rtlsdr_dev_t *dev, char *manufact, char *product, char *serial);
typedef rtlsdr_get_usb_strings = IntPtr Function(Pointer<DeviceHandle> dev,
    Pointer<Utf8> manufact, Pointer<Utf8> product, Pointer<Utf8> serial);

// int rtlsdr_write_eeprom(rtlsdr_dev_t *dev, uint8_t *data, uint8_t offset, uint16_t len);
typedef rtlsdr_write_eeprom = IntPtr Function(
    Pointer<DeviceHandle> dev, Pointer<Uint8> data, Uint8 offset, Uint16 len);

// int rtlsdr_read_eeprom(rtlsdr_dev_t *dev, uint8_t *data, uint8_t offset, uint16_t len);
typedef rtlsdr_read_eeprom = IntPtr Function(
    Pointer<DeviceHandle> dev, Pointer<Uint8> data, Uint8 offset, Uint16 len);

// int rtlsdr_set_center_freq(rtlsdr_dev_t *dev, uint32_t freq);
typedef rtlsdr_set_center_freq = IntPtr Function(
    Pointer<DeviceHandle> dev, Uint32 freq);

// uint32_t rtlsdr_get_center_freq(rtlsdr_dev_t *dev);
typedef rtlsdr_get_center_freq = Uint32 Function(Pointer<DeviceHandle> dev);

// int rtlsdr_set_freq_correction(rtlsdr_dev_t *dev, int ppm);
typedef rtlsdr_set_freq_correction = IntPtr Function(
    Pointer<DeviceHandle> dev, IntPtr ppm);

// int rtlsdr_get_freq_correction(rtlsdr_dev_t *dev);
typedef rtlsdr_get_freq_correction = IntPtr Function(Pointer<DeviceHandle> dev);

// enum rtlsdr_tuner rtlsdr_get_tuner_type(rtlsdr_dev_t *dev);
typedef rtlsdr_get_tuner_type = IntPtr Function(Pointer<DeviceHandle> dev);

// int rtlsdr_get_tuner_gains(rtlsdr_dev_t *dev, int *gains);
typedef rtlsdr_get_tuner_gains = IntPtr Function(
    Pointer<DeviceHandle> dev, Pointer<IntPtr> gains);

// int rtlsdr_set_tuner_gain(rtlsdr_dev_t *dev, int gain);
typedef rtlsdr_set_tuner_gain = IntPtr Function(
    Pointer<DeviceHandle> dev, IntPtr gain);

// int rtlsdr_set_tuner_bandwidth(rtlsdr_dev_t *dev, uint32_t bw);
typedef rtlsdr_set_tuner_bandwidth = IntPtr Function(
    Pointer<DeviceHandle> dev, Uint32 bw);

// int rtlsdr_get_tuner_gain(rtlsdr_dev_t *dev);
typedef rtlsdr_get_tuner_gain = IntPtr Function(Pointer<DeviceHandle> dev);

// int rtlsdr_set_tuner_if_gain(rtlsdr_dev_t *dev, int stage, int gain);
typedef rtlsdr_set_tuner_if_gain = IntPtr Function(
    Pointer<DeviceHandle> dev, IntPtr stage, IntPtr gain);

// int rtlsdr_set_tuner_gain_mode(rtlsdr_dev_t *dev, int manual);
typedef rtlsdr_set_tuner_gain_mode = IntPtr Function(
    Pointer<DeviceHandle> dev, IntPtr manual);

// int rtlsdr_set_sample_rate(rtlsdr_dev_t *dev, uint32_t rate);
typedef rtlsdr_set_sample_rate = IntPtr Function(
    Pointer<DeviceHandle> dev, Uint32 rate);

// uint32_t rtlsdr_get_sample_rate(rtlsdr_dev_t *dev);
typedef rtlsdr_get_sample_rate = Uint32 Function(Pointer<DeviceHandle> dev);

// int rtlsdr_set_testmode(rtlsdr_dev_t *dev, int on);
typedef rtlsdr_set_testmode = IntPtr Function(
    Pointer<DeviceHandle> dev, IntPtr on);

// int rtlsdr_set_agc_mode(rtlsdr_dev_t *dev, int on);
typedef rtlsdr_set_agc_mode = IntPtr Function(
    Pointer<DeviceHandle> dev, IntPtr on);

// int rtlsdr_set_direct_sampling(rtlsdr_dev_t *dev, int on);
typedef rtlsdr_set_direct_sampling = IntPtr Function(
    Pointer<DeviceHandle> dev, IntPtr on);

// int rtlsdr_get_direct_sampling(rtlsdr_dev_t *dev);
typedef rtlsdr_get_direct_sampling = IntPtr Function(Pointer<DeviceHandle> dev);

// int rtlsdr_set_offset_tuning(rtlsdr_dev_t *dev, int on);
typedef rtlsdr_set_offset_tuning = IntPtr Function(
    Pointer<DeviceHandle> dev, IntPtr on);

// int rtlsdr_get_offset_tuning(rtlsdr_dev_t *dev);
typedef rtlsdr_get_offset_tuning = IntPtr Function(Pointer<DeviceHandle> dev);

// int rtlsdr_reset_buffer(rtlsdr_dev_t *dev);
typedef rtlsdr_reset_buffer = IntPtr Function(Pointer<DeviceHandle> dev);

// int rtlsdr_read_sync(rtlsdr_dev_t *dev, void *buf, int len, int *n_read);
typedef rtlsdr_read_sync = IntPtr Function(Pointer<DeviceHandle> dev,
    Pointer<Uint8> buf, IntPtr len, Pointer<IntPtr> n_read);

// void(*rtlsdr_read_async_cb_t)(unsigned char *buf, uint32_t len, void *ctx);
typedef rtlsdr_read_async_cb_t = Void Function(
    Pointer<Utf8> buf, Uint32 len, Pointer<Void> ctx);

// int rtlsdr_read_async(rtlsdr_dev_t *dev, rtlsdr_read_async_cb_t cb, void *ctx, uint32_t buf_num, uint32_t buf_len);
typedef rtlsdr_read_async = IntPtr Function(
    Pointer<DeviceHandle> dev,
    NativeFunction<rtlsdr_read_async_cb_t> cb,
    Pointer<Void> ctx,
    Uint32 buf_num,
    Uint32 buf_len);

// int rtlsdr_cancel_async(rtlsdr_dev_t *dev);
typedef rtlsdr_cancel_async = IntPtr Function(Pointer<DeviceHandle> dev);

// int rtlsdr_set_bias_tee(rtlsdr_dev_t *dev, int on);
typedef rtlsdr_set_bias_tee = IntPtr Function(
    Pointer<DeviceHandle> dev, IntPtr on);

// int rtlsdr_set_bias_tee_gpio(rtlsdr_dev_t *dev, int gpio, int on);
typedef rtlsdr_set_bias_tee_gpio = IntPtr Function(
    Pointer<DeviceHandle> dev, IntPtr gpio, IntPtr on);
