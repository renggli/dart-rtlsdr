// AUTO-GENERATED CODE: DO NOT EDIT

import 'dart:ffi';

import 'package:ffi/ffi.dart';

import '../ffi/types.dart';
import 'abstract_bindings.dart';
import 'method_types.dart';

/// External bindings that get resolved with the first call.
class LazyBindings implements AbstractBindings {
  LazyBindings(this._library);

  final DynamicLibrary _library;

  @override
  int getDeviceCount() => (_getDeviceCount ??= _library
      .lookupFunction<NativeGetDeviceCount, DartGetDeviceCount>(
        'rtlsdr_get_device_count',
      ))();
  DartGetDeviceCount? _getDeviceCount;

  @override
  Pointer<Utf8> getDeviceName(int index) => (_getDeviceName ??= _library
      .lookupFunction<NativeGetDeviceName, DartGetDeviceName>(
        'rtlsdr_get_device_name',
      ))(index);
  DartGetDeviceName? _getDeviceName;

  @override
  int getDeviceUsbStrings(
    int index,
    Pointer<Utf8> manufact,
    Pointer<Utf8> product,
    Pointer<Utf8> serial,
  ) => (_getDeviceUsbStrings ??= _library
      .lookupFunction<NativeGetDeviceUsbStrings, DartGetDeviceUsbStrings>(
        'rtlsdr_get_device_usb_strings',
      ))(index, manufact, product, serial);
  DartGetDeviceUsbStrings? _getDeviceUsbStrings;

  @override
  int getIndexBySerial(Pointer<Utf8> serial) => (_getIndexBySerial ??= _library
      .lookupFunction<NativeGetIndexBySerial, DartGetIndexBySerial>(
        'rtlsdr_get_index_by_serial',
      ))(serial);
  DartGetIndexBySerial? _getIndexBySerial;

  @override
  int open(Pointer<Pointer<DeviceHandle>> dev, int index) => (_open ??= _library
      .lookupFunction<NativeOpen, DartOpen>('rtlsdr_open'))(dev, index);
  DartOpen? _open;

  @override
  int close(Pointer<DeviceHandle> dev) => (_close ??= _library
      .lookupFunction<NativeClose, DartClose>('rtlsdr_close'))(dev);
  DartClose? _close;

  @override
  int setXtalFreq(Pointer<DeviceHandle> dev, int rtlFreq, int tunerFreq) =>
      (_setXtalFreq ??= _library
          .lookupFunction<NativeSetXtalFreq, DartSetXtalFreq>(
            'rtlsdr_set_xtal_freq',
          ))(dev, rtlFreq, tunerFreq);
  DartSetXtalFreq? _setXtalFreq;

  @override
  int getXtalFreq(
    Pointer<DeviceHandle> dev,
    Pointer<Uint32> rtlFreq,
    Pointer<Uint32> tunerFreq,
  ) => (_getXtalFreq ??= _library
      .lookupFunction<NativeGetXtalFreq, DartGetXtalFreq>(
        'rtlsdr_get_xtal_freq',
      ))(dev, rtlFreq, tunerFreq);
  DartGetXtalFreq? _getXtalFreq;

  @override
  int getUsbStrings(
    Pointer<DeviceHandle> dev,
    Pointer<Utf8> manufact,
    Pointer<Utf8> product,
    Pointer<Utf8> serial,
  ) => (_getUsbStrings ??= _library
      .lookupFunction<NativeGetUsbStrings, DartGetUsbStrings>(
        'rtlsdr_get_usb_strings',
      ))(dev, manufact, product, serial);
  DartGetUsbStrings? _getUsbStrings;

  @override
  int writeEeprom(
    Pointer<DeviceHandle> dev,
    Pointer<Uint8> data,
    int offset,
    int len,
  ) => (_writeEeprom ??= _library
      .lookupFunction<NativeWriteEeprom, DartWriteEeprom>(
        'rtlsdr_write_eeprom',
      ))(dev, data, offset, len);
  DartWriteEeprom? _writeEeprom;

  @override
  int readEeprom(
    Pointer<DeviceHandle> dev,
    Pointer<Uint8> data,
    int offset,
    int len,
  ) => (_readEeprom ??= _library
      .lookupFunction<NativeReadEeprom, DartReadEeprom>(
        'rtlsdr_read_eeprom',
      ))(dev, data, offset, len);
  DartReadEeprom? _readEeprom;

  @override
  int setCenterFreq(Pointer<DeviceHandle> dev, int freq) => (_setCenterFreq ??=
      _library.lookupFunction<NativeSetCenterFreq, DartSetCenterFreq>(
        'rtlsdr_set_center_freq',
      ))(dev, freq);
  DartSetCenterFreq? _setCenterFreq;

  @override
  int getCenterFreq(Pointer<DeviceHandle> dev) => (_getCenterFreq ??= _library
      .lookupFunction<NativeGetCenterFreq, DartGetCenterFreq>(
        'rtlsdr_get_center_freq',
      ))(dev);
  DartGetCenterFreq? _getCenterFreq;

  @override
  int setFreqCorrection(Pointer<DeviceHandle> dev, int ppm) =>
      (_setFreqCorrection ??= _library
          .lookupFunction<NativeSetFreqCorrection, DartSetFreqCorrection>(
            'rtlsdr_set_freq_correction',
          ))(dev, ppm);
  DartSetFreqCorrection? _setFreqCorrection;

  @override
  int getFreqCorrection(Pointer<DeviceHandle> dev) => (_getFreqCorrection ??=
      _library.lookupFunction<NativeGetFreqCorrection, DartGetFreqCorrection>(
        'rtlsdr_get_freq_correction',
      ))(dev);
  DartGetFreqCorrection? _getFreqCorrection;

  @override
  int getTunerType(Pointer<DeviceHandle> dev) => (_getTunerType ??= _library
      .lookupFunction<NativeGetTunerType, DartGetTunerType>(
        'rtlsdr_get_tuner_type',
      ))(dev);
  DartGetTunerType? _getTunerType;

  @override
  int getTunerGains(Pointer<DeviceHandle> dev, Pointer<Int> gains) =>
      (_getTunerGains ??= _library
          .lookupFunction<NativeGetTunerGains, DartGetTunerGains>(
            'rtlsdr_get_tuner_gains',
          ))(dev, gains);
  DartGetTunerGains? _getTunerGains;

  @override
  int setTunerGain(Pointer<DeviceHandle> dev, int gain) => (_setTunerGain ??=
      _library.lookupFunction<NativeSetTunerGain, DartSetTunerGain>(
        'rtlsdr_set_tuner_gain',
      ))(dev, gain);
  DartSetTunerGain? _setTunerGain;

  @override
  int setTunerBandwidth(Pointer<DeviceHandle> dev, int bw) =>
      (_setTunerBandwidth ??= _library
          .lookupFunction<NativeSetTunerBandwidth, DartSetTunerBandwidth>(
            'rtlsdr_set_tuner_bandwidth',
          ))(dev, bw);
  DartSetTunerBandwidth? _setTunerBandwidth;

  @override
  int getTunerGain(Pointer<DeviceHandle> dev) => (_getTunerGain ??= _library
      .lookupFunction<NativeGetTunerGain, DartGetTunerGain>(
        'rtlsdr_get_tuner_gain',
      ))(dev);
  DartGetTunerGain? _getTunerGain;

  @override
  int setTunerIfGain(Pointer<DeviceHandle> dev, int stage, int gain) =>
      (_setTunerIfGain ??= _library
          .lookupFunction<NativeSetTunerIfGain, DartSetTunerIfGain>(
            'rtlsdr_set_tuner_if_gain',
          ))(dev, stage, gain);
  DartSetTunerIfGain? _setTunerIfGain;

  @override
  int setTunerGainMode(Pointer<DeviceHandle> dev, int manual) =>
      (_setTunerGainMode ??= _library
          .lookupFunction<NativeSetTunerGainMode, DartSetTunerGainMode>(
            'rtlsdr_set_tuner_gain_mode',
          ))(dev, manual);
  DartSetTunerGainMode? _setTunerGainMode;

  @override
  int setSampleRate(Pointer<DeviceHandle> dev, int rate) => (_setSampleRate ??=
      _library.lookupFunction<NativeSetSampleRate, DartSetSampleRate>(
        'rtlsdr_set_sample_rate',
      ))(dev, rate);
  DartSetSampleRate? _setSampleRate;

  @override
  int getSampleRate(Pointer<DeviceHandle> dev) => (_getSampleRate ??= _library
      .lookupFunction<NativeGetSampleRate, DartGetSampleRate>(
        'rtlsdr_get_sample_rate',
      ))(dev);
  DartGetSampleRate? _getSampleRate;

  @override
  int setTestmode(Pointer<DeviceHandle> dev, int on) => (_setTestmode ??=
      _library.lookupFunction<NativeSetTestmode, DartSetTestmode>(
        'rtlsdr_set_testmode',
      ))(dev, on);
  DartSetTestmode? _setTestmode;

  @override
  int setAgcMode(Pointer<DeviceHandle> dev, int on) => (_setAgcMode ??= _library
      .lookupFunction<NativeSetAgcMode, DartSetAgcMode>(
        'rtlsdr_set_agc_mode',
      ))(dev, on);
  DartSetAgcMode? _setAgcMode;

  @override
  int setDirectSampling(Pointer<DeviceHandle> dev, int on) =>
      (_setDirectSampling ??= _library
          .lookupFunction<NativeSetDirectSampling, DartSetDirectSampling>(
            'rtlsdr_set_direct_sampling',
          ))(dev, on);
  DartSetDirectSampling? _setDirectSampling;

  @override
  int getDirectSampling(Pointer<DeviceHandle> dev) => (_getDirectSampling ??=
      _library.lookupFunction<NativeGetDirectSampling, DartGetDirectSampling>(
        'rtlsdr_get_direct_sampling',
      ))(dev);
  DartGetDirectSampling? _getDirectSampling;

  @override
  int setOffsetTuning(Pointer<DeviceHandle> dev, int on) =>
      (_setOffsetTuning ??= _library
          .lookupFunction<NativeSetOffsetTuning, DartSetOffsetTuning>(
            'rtlsdr_set_offset_tuning',
          ))(dev, on);
  DartSetOffsetTuning? _setOffsetTuning;

  @override
  int getOffsetTuning(Pointer<DeviceHandle> dev) => (_getOffsetTuning ??=
      _library.lookupFunction<NativeGetOffsetTuning, DartGetOffsetTuning>(
        'rtlsdr_get_offset_tuning',
      ))(dev);
  DartGetOffsetTuning? _getOffsetTuning;

  @override
  int resetBuffer(Pointer<DeviceHandle> dev) => (_resetBuffer ??= _library
      .lookupFunction<NativeResetBuffer, DartResetBuffer>(
        'rtlsdr_reset_buffer',
      ))(dev);
  DartResetBuffer? _resetBuffer;

  @override
  int readSync(
    Pointer<DeviceHandle> dev,
    Pointer<Void> buf,
    int len,
    Pointer<Int> nRead,
  ) => (_readSync ??= _library.lookupFunction<NativeReadSync, DartReadSync>(
    'rtlsdr_read_sync',
  ))(dev, buf, len, nRead);
  DartReadSync? _readSync;

  @override
  int waitAsync(Pointer<DeviceHandle> dev, Pointer cb, Pointer<Void> ctx) =>
      (_waitAsync ??= _library.lookupFunction<NativeWaitAsync, DartWaitAsync>(
        'rtlsdr_wait_async',
      ))(dev, cb, ctx);
  DartWaitAsync? _waitAsync;

  @override
  int readAsync(
    Pointer<DeviceHandle> dev,
    Pointer cb,
    Pointer<Void> ctx,
    int bufNum,
    int bufLen,
  ) => (_readAsync ??= _library.lookupFunction<NativeReadAsync, DartReadAsync>(
    'rtlsdr_read_async',
  ))(dev, cb, ctx, bufNum, bufLen);
  DartReadAsync? _readAsync;

  @override
  int cancelAsync(Pointer<DeviceHandle> dev) => (_cancelAsync ??= _library
      .lookupFunction<NativeCancelAsync, DartCancelAsync>(
        'rtlsdr_cancel_async',
      ))(dev);
  DartCancelAsync? _cancelAsync;

  @override
  int setBiasTee(Pointer<DeviceHandle> dev, int on) => (_setBiasTee ??= _library
      .lookupFunction<NativeSetBiasTee, DartSetBiasTee>(
        'rtlsdr_set_bias_tee',
      ))(dev, on);
  DartSetBiasTee? _setBiasTee;
}
