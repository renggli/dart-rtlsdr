// AUTO-GENERATED CODE: DO NOT EDIT

import 'dart:ffi';

import 'package:ffi/ffi.dart';

import '../ffi/types.dart';
import 'abstract_bindings.dart';
import 'method_types.dart';

/// External bindings that get resolved initially.
class EagerBindings implements AbstractBindings {
  EagerBindings(DynamicLibrary library)
      : _getDeviceCount =
            library.lookupFunction<NativeGetDeviceCount, DartGetDeviceCount>(
                'rtlsdr_get_device_count'),
        _getDeviceName =
            library.lookupFunction<NativeGetDeviceName, DartGetDeviceName>(
                'rtlsdr_get_device_name'),
        _getDeviceUsbStrings = library.lookupFunction<NativeGetDeviceUsbStrings,
            DartGetDeviceUsbStrings>('rtlsdr_get_device_usb_strings'),
        _getIndexBySerial = library.lookupFunction<NativeGetIndexBySerial,
            DartGetIndexBySerial>('rtlsdr_get_index_by_serial'),
        _open = library.lookupFunction<NativeOpen, DartOpen>('rtlsdr_open'),
        _close = library.lookupFunction<NativeClose, DartClose>('rtlsdr_close'),
        _setXtalFreq =
            library.lookupFunction<NativeSetXtalFreq, DartSetXtalFreq>(
                'rtlsdr_set_xtal_freq'),
        _getXtalFreq =
            library.lookupFunction<NativeGetXtalFreq, DartGetXtalFreq>(
                'rtlsdr_get_xtal_freq'),
        _getUsbStrings =
            library.lookupFunction<NativeGetUsbStrings, DartGetUsbStrings>(
                'rtlsdr_get_usb_strings'),
        _writeEeprom =
            library.lookupFunction<NativeWriteEeprom, DartWriteEeprom>(
                'rtlsdr_write_eeprom'),
        _readEeprom = library.lookupFunction<NativeReadEeprom, DartReadEeprom>(
            'rtlsdr_read_eeprom'),
        _setCenterFreq =
            library.lookupFunction<NativeSetCenterFreq, DartSetCenterFreq>(
                'rtlsdr_set_center_freq'),
        _getCenterFreq =
            library.lookupFunction<NativeGetCenterFreq, DartGetCenterFreq>(
                'rtlsdr_get_center_freq'),
        _setFreqCorrection = library.lookupFunction<NativeSetFreqCorrection,
            DartSetFreqCorrection>('rtlsdr_set_freq_correction'),
        _getFreqCorrection = library.lookupFunction<NativeGetFreqCorrection,
            DartGetFreqCorrection>('rtlsdr_get_freq_correction'),
        _getTunerType =
            library.lookupFunction<NativeGetTunerType, DartGetTunerType>(
                'rtlsdr_get_tuner_type'),
        _getTunerGains =
            library.lookupFunction<NativeGetTunerGains, DartGetTunerGains>(
                'rtlsdr_get_tuner_gains'),
        _setTunerGain =
            library.lookupFunction<NativeSetTunerGain, DartSetTunerGain>(
                'rtlsdr_set_tuner_gain'),
        _setTunerBandwidth = library.lookupFunction<NativeSetTunerBandwidth,
            DartSetTunerBandwidth>('rtlsdr_set_tuner_bandwidth'),
        _getTunerGain =
            library.lookupFunction<NativeGetTunerGain, DartGetTunerGain>(
                'rtlsdr_get_tuner_gain'),
        _setTunerIfGain =
            library.lookupFunction<NativeSetTunerIfGain, DartSetTunerIfGain>(
                'rtlsdr_set_tuner_if_gain'),
        _setTunerGainMode = library.lookupFunction<NativeSetTunerGainMode,
            DartSetTunerGainMode>('rtlsdr_set_tuner_gain_mode'),
        _setSampleRate =
            library.lookupFunction<NativeSetSampleRate, DartSetSampleRate>(
                'rtlsdr_set_sample_rate'),
        _getSampleRate =
            library.lookupFunction<NativeGetSampleRate, DartGetSampleRate>(
                'rtlsdr_get_sample_rate'),
        _setTestmode =
            library.lookupFunction<NativeSetTestmode, DartSetTestmode>(
                'rtlsdr_set_testmode'),
        _setAgcMode = library.lookupFunction<NativeSetAgcMode, DartSetAgcMode>(
            'rtlsdr_set_agc_mode'),
        _setDirectSampling = library.lookupFunction<NativeSetDirectSampling,
            DartSetDirectSampling>('rtlsdr_set_direct_sampling'),
        _getDirectSampling = library.lookupFunction<NativeGetDirectSampling,
            DartGetDirectSampling>('rtlsdr_get_direct_sampling'),
        _setOffsetTuning =
            library.lookupFunction<NativeSetOffsetTuning, DartSetOffsetTuning>(
                'rtlsdr_set_offset_tuning'),
        _getOffsetTuning =
            library.lookupFunction<NativeGetOffsetTuning, DartGetOffsetTuning>(
                'rtlsdr_get_offset_tuning'),
        _resetBuffer =
            library.lookupFunction<NativeResetBuffer, DartResetBuffer>(
                'rtlsdr_reset_buffer'),
        _readSync = library
            .lookupFunction<NativeReadSync, DartReadSync>('rtlsdr_read_sync'),
        _waitAsync = library.lookupFunction<NativeWaitAsync, DartWaitAsync>(
            'rtlsdr_wait_async'),
        _readAsync = library.lookupFunction<NativeReadAsync, DartReadAsync>(
            'rtlsdr_read_async'),
        _cancelAsync =
            library.lookupFunction<NativeCancelAsync, DartCancelAsync>(
                'rtlsdr_cancel_async'),
        _setBiasTee = library.lookupFunction<NativeSetBiasTee, DartSetBiasTee>(
            'rtlsdr_set_bias_tee');

  @override
  int getDeviceCount() => _getDeviceCount();
  final DartGetDeviceCount _getDeviceCount;

  @override
  Pointer<Utf8> getDeviceName(int index) => _getDeviceName(index);
  final DartGetDeviceName _getDeviceName;

  @override
  int getDeviceUsbStrings(int index, Pointer<Utf8> manufact,
          Pointer<Utf8> product, Pointer<Utf8> serial) =>
      _getDeviceUsbStrings(index, manufact, product, serial);
  final DartGetDeviceUsbStrings _getDeviceUsbStrings;

  @override
  int getIndexBySerial(Pointer<Utf8> serial) => _getIndexBySerial(serial);
  final DartGetIndexBySerial _getIndexBySerial;

  @override
  int open(Pointer<Pointer<DeviceHandle>> dev, int index) => _open(dev, index);
  final DartOpen _open;

  @override
  int close(Pointer<DeviceHandle> dev) => _close(dev);
  final DartClose _close;

  @override
  int setXtalFreq(Pointer<DeviceHandle> dev, int rtlFreq, int tunerFreq) =>
      _setXtalFreq(dev, rtlFreq, tunerFreq);
  final DartSetXtalFreq _setXtalFreq;

  @override
  int getXtalFreq(Pointer<DeviceHandle> dev, Pointer<Uint32> rtlFreq,
          Pointer<Uint32> tunerFreq) =>
      _getXtalFreq(dev, rtlFreq, tunerFreq);
  final DartGetXtalFreq _getXtalFreq;

  @override
  int getUsbStrings(Pointer<DeviceHandle> dev, Pointer<Utf8> manufact,
          Pointer<Utf8> product, Pointer<Utf8> serial) =>
      _getUsbStrings(dev, manufact, product, serial);
  final DartGetUsbStrings _getUsbStrings;

  @override
  int writeEeprom(Pointer<DeviceHandle> dev, Pointer<Uint8> data, int offset,
          int len) =>
      _writeEeprom(dev, data, offset, len);
  final DartWriteEeprom _writeEeprom;

  @override
  int readEeprom(Pointer<DeviceHandle> dev, Pointer<Uint8> data, int offset,
          int len) =>
      _readEeprom(dev, data, offset, len);
  final DartReadEeprom _readEeprom;

  @override
  int setCenterFreq(Pointer<DeviceHandle> dev, int freq) =>
      _setCenterFreq(dev, freq);
  final DartSetCenterFreq _setCenterFreq;

  @override
  int getCenterFreq(Pointer<DeviceHandle> dev) => _getCenterFreq(dev);
  final DartGetCenterFreq _getCenterFreq;

  @override
  int setFreqCorrection(Pointer<DeviceHandle> dev, int ppm) =>
      _setFreqCorrection(dev, ppm);
  final DartSetFreqCorrection _setFreqCorrection;

  @override
  int getFreqCorrection(Pointer<DeviceHandle> dev) => _getFreqCorrection(dev);
  final DartGetFreqCorrection _getFreqCorrection;

  @override
  int getTunerType(Pointer<DeviceHandle> dev) => _getTunerType(dev);
  final DartGetTunerType _getTunerType;

  @override
  int getTunerGains(Pointer<DeviceHandle> dev, Pointer<Int> gains) =>
      _getTunerGains(dev, gains);
  final DartGetTunerGains _getTunerGains;

  @override
  int setTunerGain(Pointer<DeviceHandle> dev, int gain) =>
      _setTunerGain(dev, gain);
  final DartSetTunerGain _setTunerGain;

  @override
  int setTunerBandwidth(Pointer<DeviceHandle> dev, int bw) =>
      _setTunerBandwidth(dev, bw);
  final DartSetTunerBandwidth _setTunerBandwidth;

  @override
  int getTunerGain(Pointer<DeviceHandle> dev) => _getTunerGain(dev);
  final DartGetTunerGain _getTunerGain;

  @override
  int setTunerIfGain(Pointer<DeviceHandle> dev, int stage, int gain) =>
      _setTunerIfGain(dev, stage, gain);
  final DartSetTunerIfGain _setTunerIfGain;

  @override
  int setTunerGainMode(Pointer<DeviceHandle> dev, int manual) =>
      _setTunerGainMode(dev, manual);
  final DartSetTunerGainMode _setTunerGainMode;

  @override
  int setSampleRate(Pointer<DeviceHandle> dev, int rate) =>
      _setSampleRate(dev, rate);
  final DartSetSampleRate _setSampleRate;

  @override
  int getSampleRate(Pointer<DeviceHandle> dev) => _getSampleRate(dev);
  final DartGetSampleRate _getSampleRate;

  @override
  int setTestmode(Pointer<DeviceHandle> dev, int on) => _setTestmode(dev, on);
  final DartSetTestmode _setTestmode;

  @override
  int setAgcMode(Pointer<DeviceHandle> dev, int on) => _setAgcMode(dev, on);
  final DartSetAgcMode _setAgcMode;

  @override
  int setDirectSampling(Pointer<DeviceHandle> dev, int on) =>
      _setDirectSampling(dev, on);
  final DartSetDirectSampling _setDirectSampling;

  @override
  int getDirectSampling(Pointer<DeviceHandle> dev) => _getDirectSampling(dev);
  final DartGetDirectSampling _getDirectSampling;

  @override
  int setOffsetTuning(Pointer<DeviceHandle> dev, int on) =>
      _setOffsetTuning(dev, on);
  final DartSetOffsetTuning _setOffsetTuning;

  @override
  int getOffsetTuning(Pointer<DeviceHandle> dev) => _getOffsetTuning(dev);
  final DartGetOffsetTuning _getOffsetTuning;

  @override
  int resetBuffer(Pointer<DeviceHandle> dev) => _resetBuffer(dev);
  final DartResetBuffer _resetBuffer;

  @override
  int readSync(Pointer<DeviceHandle> dev, Pointer<Void> buf, int len,
          Pointer<Int> nRead) =>
      _readSync(dev, buf, len, nRead);
  final DartReadSync _readSync;

  @override
  int waitAsync(Pointer<DeviceHandle> dev, Pointer cb, Pointer<Void> ctx) =>
      _waitAsync(dev, cb, ctx);
  final DartWaitAsync _waitAsync;

  @override
  int readAsync(Pointer<DeviceHandle> dev, Pointer cb, Pointer<Void> ctx,
          int bufNum, int bufLen) =>
      _readAsync(dev, cb, ctx, bufNum, bufLen);
  final DartReadAsync _readAsync;

  @override
  int cancelAsync(Pointer<DeviceHandle> dev) => _cancelAsync(dev);
  final DartCancelAsync _cancelAsync;

  @override
  int setBiasTee(Pointer<DeviceHandle> dev, int on) => _setBiasTee(dev, on);
  final DartSetBiasTee _setBiasTee;
}
