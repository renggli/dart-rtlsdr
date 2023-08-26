// AUTO-GENERATED CODE: DO NOT EDIT

// ignore_for_file: lines_longer_than_80_chars
import 'dart:ffi';

import 'package:ffi/ffi.dart';

import '../ffi/types.dart';

// uint32_t rtlsdr_get_device_count(void)
typedef NativeGetDeviceCount = Uint32 Function();
typedef DartGetDeviceCount = int Function();

// char* rtlsdr_get_device_name(uint32_t index)
typedef NativeGetDeviceName = Pointer<Utf8> Function(Uint32 index);
typedef DartGetDeviceName = Pointer<Utf8> Function(int index);

// int rtlsdr_get_device_usb_strings(uint32_t index, char *manufact, char *product, char *serial)
typedef NativeGetDeviceUsbStrings = Int Function(Uint32 index,
    Pointer<Utf8> manufact, Pointer<Utf8> product, Pointer<Utf8> serial);
typedef DartGetDeviceUsbStrings = int Function(int index,
    Pointer<Utf8> manufact, Pointer<Utf8> product, Pointer<Utf8> serial);

// int rtlsdr_get_index_by_serial(char *serial)
typedef NativeGetIndexBySerial = Int Function(Pointer<Utf8> serial);
typedef DartGetIndexBySerial = int Function(Pointer<Utf8> serial);

// int rtlsdr_open(rtlsdr_dev_t **dev, uint32_t index)
typedef NativeOpen = Int Function(
    Pointer<Pointer<DeviceHandle>> dev, Uint32 index);
typedef DartOpen = int Function(Pointer<Pointer<DeviceHandle>> dev, int index);

// int rtlsdr_close(rtlsdr_dev_t *dev)
typedef NativeClose = Int Function(Pointer<DeviceHandle> dev);
typedef DartClose = int Function(Pointer<DeviceHandle> dev);

// int rtlsdr_set_xtal_freq(rtlsdr_dev_t *dev, uint32_t rtl_freq, uint32_t tuner_freq)
typedef NativeSetXtalFreq = Int Function(
    Pointer<DeviceHandle> dev, Uint32 rtlFreq, Uint32 tunerFreq);
typedef DartSetXtalFreq = int Function(
    Pointer<DeviceHandle> dev, int rtlFreq, int tunerFreq);

// int rtlsdr_get_xtal_freq(rtlsdr_dev_t *dev, uint32_t *rtl_freq, uint32_t *tuner_freq)
typedef NativeGetXtalFreq = Int Function(Pointer<DeviceHandle> dev,
    Pointer<Uint32> rtlFreq, Pointer<Uint32> tunerFreq);
typedef DartGetXtalFreq = int Function(Pointer<DeviceHandle> dev,
    Pointer<Uint32> rtlFreq, Pointer<Uint32> tunerFreq);

// int rtlsdr_get_usb_strings(rtlsdr_dev_t *dev, char *manufact, char *product, char *serial)
typedef NativeGetUsbStrings = Int Function(Pointer<DeviceHandle> dev,
    Pointer<Utf8> manufact, Pointer<Utf8> product, Pointer<Utf8> serial);
typedef DartGetUsbStrings = int Function(Pointer<DeviceHandle> dev,
    Pointer<Utf8> manufact, Pointer<Utf8> product, Pointer<Utf8> serial);

// int rtlsdr_write_eeprom(rtlsdr_dev_t *dev, uint8_t *data, uint8_t offset, uint16_t len)
typedef NativeWriteEeprom = Int Function(
    Pointer<DeviceHandle> dev, Pointer<Uint8> data, Uint8 offset, Uint16 len);
typedef DartWriteEeprom = int Function(
    Pointer<DeviceHandle> dev, Pointer<Uint8> data, int offset, int len);

// int rtlsdr_read_eeprom(rtlsdr_dev_t *dev, uint8_t *data, uint8_t offset, uint16_t len)
typedef NativeReadEeprom = Int Function(
    Pointer<DeviceHandle> dev, Pointer<Uint8> data, Uint8 offset, Uint16 len);
typedef DartReadEeprom = int Function(
    Pointer<DeviceHandle> dev, Pointer<Uint8> data, int offset, int len);

// int rtlsdr_set_center_freq(rtlsdr_dev_t *dev, uint32_t freq)
typedef NativeSetCenterFreq = Int Function(
    Pointer<DeviceHandle> dev, Uint32 freq);
typedef DartSetCenterFreq = int Function(Pointer<DeviceHandle> dev, int freq);

// uint32_t rtlsdr_get_center_freq(rtlsdr_dev_t *dev)
typedef NativeGetCenterFreq = Uint32 Function(Pointer<DeviceHandle> dev);
typedef DartGetCenterFreq = int Function(Pointer<DeviceHandle> dev);

// int rtlsdr_set_freq_correction(rtlsdr_dev_t *dev, int ppm)
typedef NativeSetFreqCorrection = Int Function(
    Pointer<DeviceHandle> dev, Int ppm);
typedef DartSetFreqCorrection = int Function(
    Pointer<DeviceHandle> dev, int ppm);

// int rtlsdr_get_freq_correction(rtlsdr_dev_t *dev)
typedef NativeGetFreqCorrection = Int Function(Pointer<DeviceHandle> dev);
typedef DartGetFreqCorrection = int Function(Pointer<DeviceHandle> dev);

// int rtlsdr_get_tuner_type(rtlsdr_dev_t *dev)
typedef NativeGetTunerType = Int Function(Pointer<DeviceHandle> dev);
typedef DartGetTunerType = int Function(Pointer<DeviceHandle> dev);

// int rtlsdr_get_tuner_gains(rtlsdr_dev_t *dev, int *gains)
typedef NativeGetTunerGains = Int Function(
    Pointer<DeviceHandle> dev, Pointer<Int> gains);
typedef DartGetTunerGains = int Function(
    Pointer<DeviceHandle> dev, Pointer<Int> gains);

// int rtlsdr_set_tuner_gain(rtlsdr_dev_t *dev, int gain)
typedef NativeSetTunerGain = Int Function(Pointer<DeviceHandle> dev, Int gain);
typedef DartSetTunerGain = int Function(Pointer<DeviceHandle> dev, int gain);

// int rtlsdr_set_tuner_bandwidth(rtlsdr_dev_t *dev, uint32_t bw)
typedef NativeSetTunerBandwidth = Int Function(
    Pointer<DeviceHandle> dev, Uint32 bw);
typedef DartSetTunerBandwidth = int Function(Pointer<DeviceHandle> dev, int bw);

// int rtlsdr_get_tuner_gain(rtlsdr_dev_t *dev)
typedef NativeGetTunerGain = Int Function(Pointer<DeviceHandle> dev);
typedef DartGetTunerGain = int Function(Pointer<DeviceHandle> dev);

// int rtlsdr_set_tuner_if_gain(rtlsdr_dev_t *dev, int stage, int gain)
typedef NativeSetTunerIfGain = Int Function(
    Pointer<DeviceHandle> dev, Int stage, Int gain);
typedef DartSetTunerIfGain = int Function(
    Pointer<DeviceHandle> dev, int stage, int gain);

// int rtlsdr_set_tuner_gain_mode(rtlsdr_dev_t *dev, int manual)
typedef NativeSetTunerGainMode = Int Function(
    Pointer<DeviceHandle> dev, Int manual);
typedef DartSetTunerGainMode = int Function(
    Pointer<DeviceHandle> dev, int manual);

// int rtlsdr_set_sample_rate(rtlsdr_dev_t *dev, uint32_t rate)
typedef NativeSetSampleRate = Int Function(
    Pointer<DeviceHandle> dev, Uint32 rate);
typedef DartSetSampleRate = int Function(Pointer<DeviceHandle> dev, int rate);

// uint32_t rtlsdr_get_sample_rate(rtlsdr_dev_t *dev)
typedef NativeGetSampleRate = Uint32 Function(Pointer<DeviceHandle> dev);
typedef DartGetSampleRate = int Function(Pointer<DeviceHandle> dev);

// int rtlsdr_set_testmode(rtlsdr_dev_t *dev, int on)
typedef NativeSetTestmode = Int Function(Pointer<DeviceHandle> dev, Int on);
typedef DartSetTestmode = int Function(Pointer<DeviceHandle> dev, int on);

// int rtlsdr_set_agc_mode(rtlsdr_dev_t *dev, int on)
typedef NativeSetAgcMode = Int Function(Pointer<DeviceHandle> dev, Int on);
typedef DartSetAgcMode = int Function(Pointer<DeviceHandle> dev, int on);

// int rtlsdr_set_direct_sampling(rtlsdr_dev_t *dev, int on)
typedef NativeSetDirectSampling = Int Function(
    Pointer<DeviceHandle> dev, Int on);
typedef DartSetDirectSampling = int Function(Pointer<DeviceHandle> dev, int on);

// int rtlsdr_get_direct_sampling(rtlsdr_dev_t *dev)
typedef NativeGetDirectSampling = Int Function(Pointer<DeviceHandle> dev);
typedef DartGetDirectSampling = int Function(Pointer<DeviceHandle> dev);

// int rtlsdr_set_offset_tuning(rtlsdr_dev_t *dev, int on)
typedef NativeSetOffsetTuning = Int Function(Pointer<DeviceHandle> dev, Int on);
typedef DartSetOffsetTuning = int Function(Pointer<DeviceHandle> dev, int on);

// int rtlsdr_get_offset_tuning(rtlsdr_dev_t *dev)
typedef NativeGetOffsetTuning = Int Function(Pointer<DeviceHandle> dev);
typedef DartGetOffsetTuning = int Function(Pointer<DeviceHandle> dev);

// int rtlsdr_reset_buffer(rtlsdr_dev_t *dev)
typedef NativeResetBuffer = Int Function(Pointer<DeviceHandle> dev);
typedef DartResetBuffer = int Function(Pointer<DeviceHandle> dev);

// int rtlsdr_read_sync(rtlsdr_dev_t *dev, void *buf, int len, int *n_read)
typedef NativeReadSync = Int Function(
    Pointer<DeviceHandle> dev, Pointer<Void> buf, Int len, Pointer<Int> nRead);
typedef DartReadSync = int Function(
    Pointer<DeviceHandle> dev, Pointer<Void> buf, int len, Pointer<Int> nRead);

// int rtlsdr_wait_async(rtlsdr_dev_t *dev, rtlsdr_read_async_cb_t cb, void *ctx)
typedef NativeWaitAsync = Int Function(
    Pointer<DeviceHandle> dev, Pointer cb, Pointer<Void> ctx);
typedef DartWaitAsync = int Function(
    Pointer<DeviceHandle> dev, Pointer cb, Pointer<Void> ctx);

// int rtlsdr_read_async(rtlsdr_dev_t *dev, rtlsdr_read_async_cb_t cb, void *ctx, uint32_t buf_num, uint32_t buf_len)
typedef NativeReadAsync = Int Function(Pointer<DeviceHandle> dev, Pointer cb,
    Pointer<Void> ctx, Uint32 bufNum, Uint32 bufLen);
typedef DartReadAsync = int Function(Pointer<DeviceHandle> dev, Pointer cb,
    Pointer<Void> ctx, int bufNum, int bufLen);

// int rtlsdr_cancel_async(rtlsdr_dev_t *dev)
typedef NativeCancelAsync = Int Function(Pointer<DeviceHandle> dev);
typedef DartCancelAsync = int Function(Pointer<DeviceHandle> dev);

// int rtlsdr_set_bias_tee(rtlsdr_dev_t *dev, int on)
typedef NativeSetBiasTee = Int Function(Pointer<DeviceHandle> dev, Int on);
typedef DartSetBiasTee = int Function(Pointer<DeviceHandle> dev, int on);
