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
        _setCenterFreq64 =
            library.lookupFunction<NativeSetCenterFreq64, DartSetCenterFreq64>(
                'rtlsdr_set_center_freq64'),
        _setHarmonicRx =
            library.lookupFunction<NativeSetHarmonicRx, DartSetHarmonicRx>(
                'rtlsdr_set_harmonic_rx'),
        _isTunerPLLLocked = library.lookupFunction<NativeIsTunerPLLLocked,
            DartIsTunerPLLLocked>('rtlsdr_is_tuner_PLL_locked'),
        _getCenterFreq =
            library.lookupFunction<NativeGetCenterFreq, DartGetCenterFreq>(
                'rtlsdr_get_center_freq'),
        _getCenterFreq64 =
            library.lookupFunction<NativeGetCenterFreq64, DartGetCenterFreq64>(
                'rtlsdr_get_center_freq64'),
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
        _setAndGetTunerBandwidth = library.lookupFunction<
            NativeSetAndGetTunerBandwidth,
            DartSetAndGetTunerBandwidth>('rtlsdr_set_and_get_tuner_bandwidth'),
        _setTunerBandwidth = library.lookupFunction<NativeSetTunerBandwidth,
            DartSetTunerBandwidth>('rtlsdr_set_tuner_bandwidth'),
        _setTunerBandCenter = library.lookupFunction<NativeSetTunerBandCenter,
            DartSetTunerBandCenter>('rtlsdr_set_tuner_band_center'),
        _setTunerSideband = library.lookupFunction<NativeSetTunerSideband,
            DartSetTunerSideband>('rtlsdr_set_tuner_sideband'),
        _getTunerGain =
            library.lookupFunction<NativeGetTunerGain, DartGetTunerGain>(
                'rtlsdr_get_tuner_gain'),
        _setTunerGainExt =
            library.lookupFunction<NativeSetTunerGainExt, DartSetTunerGainExt>(
                'rtlsdr_set_tuner_gain_ext'),
        _setTunerIfGain =
            library.lookupFunction<NativeSetTunerIfGain, DartSetTunerIfGain>(
                'rtlsdr_set_tuner_if_gain'),
        _setTunerGainMode = library.lookupFunction<NativeSetTunerGainMode,
            DartSetTunerGainMode>('rtlsdr_set_tuner_gain_mode'),
        _setTunerIfMode =
            library.lookupFunction<NativeSetTunerIfMode, DartSetTunerIfMode>(
                'rtlsdr_set_tuner_if_mode'),
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
        _setDsMode = library.lookupFunction<NativeSetDsMode, DartSetDsMode>(
            'rtlsdr_set_ds_mode'),
        _setOffsetTuning =
            library.lookupFunction<NativeSetOffsetTuning, DartSetOffsetTuning>(
                'rtlsdr_set_offset_tuning'),
        _getOffsetTuning =
            library.lookupFunction<NativeGetOffsetTuning, DartGetOffsetTuning>(
                'rtlsdr_get_offset_tuning'),
        _setDithering =
            library.lookupFunction<NativeSetDithering, DartSetDithering>(
                'rtlsdr_set_dithering'),
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
        _irQuery = library
            .lookupFunction<NativeIrQuery, DartIrQuery>('rtlsdr_ir_query'),
        _setBiasTee = library.lookupFunction<NativeSetBiasTee, DartSetBiasTee>(
            'rtlsdr_set_bias_tee'),
        _setBiasTeeGpio =
            library.lookupFunction<NativeSetBiasTeeGpio, DartSetBiasTeeGpio>(
                'rtlsdr_set_bias_tee_gpio'),
        _getVerId = library
            .lookupFunction<NativeGetVerId, DartGetVerId>('rtlsdr_get_ver_id'),
        _getVersion = library.lookupFunction<NativeGetVersion, DartGetVersion>(
            'rtlsdr_get_version');

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
  int setCenterFreq64(Pointer<DeviceHandle> dev, int freq) =>
      _setCenterFreq64(dev, freq);
  final DartSetCenterFreq64 _setCenterFreq64;

  @override
  int setHarmonicRx(Pointer<DeviceHandle> dev, int harmonic) =>
      _setHarmonicRx(dev, harmonic);
  final DartSetHarmonicRx _setHarmonicRx;

  @override
  int isTunerPLLLocked(Pointer<DeviceHandle> dev) => _isTunerPLLLocked(dev);
  final DartIsTunerPLLLocked _isTunerPLLLocked;

  @override
  int getCenterFreq(Pointer<DeviceHandle> dev) => _getCenterFreq(dev);
  final DartGetCenterFreq _getCenterFreq;

  @override
  int getCenterFreq64(Pointer<DeviceHandle> dev) => _getCenterFreq64(dev);
  final DartGetCenterFreq64 _getCenterFreq64;

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
  int setAndGetTunerBandwidth(Pointer<DeviceHandle> dev, int bw,
          Pointer<Uint32> appliedBw, int applyBw) =>
      _setAndGetTunerBandwidth(dev, bw, appliedBw, applyBw);
  final DartSetAndGetTunerBandwidth _setAndGetTunerBandwidth;

  @override
  int setTunerBandwidth(Pointer<DeviceHandle> dev, int bw) =>
      _setTunerBandwidth(dev, bw);
  final DartSetTunerBandwidth _setTunerBandwidth;

  @override
  int setTunerBandCenter(Pointer<DeviceHandle> dev, int ifBandCenterFreq) =>
      _setTunerBandCenter(dev, ifBandCenterFreq);
  final DartSetTunerBandCenter _setTunerBandCenter;

  @override
  int setTunerSideband(Pointer<DeviceHandle> dev, int sideband) =>
      _setTunerSideband(dev, sideband);
  final DartSetTunerSideband _setTunerSideband;

  @override
  int getTunerGain(Pointer<DeviceHandle> dev) => _getTunerGain(dev);
  final DartGetTunerGain _getTunerGain;

  @override
  int setTunerGainExt(
          Pointer<DeviceHandle> dev, int lnaGain, int mixerGain, int vgaGain) =>
      _setTunerGainExt(dev, lnaGain, mixerGain, vgaGain);
  final DartSetTunerGainExt _setTunerGainExt;

  @override
  int setTunerIfGain(Pointer<DeviceHandle> dev, int stage, int gain) =>
      _setTunerIfGain(dev, stage, gain);
  final DartSetTunerIfGain _setTunerIfGain;

  @override
  int setTunerGainMode(Pointer<DeviceHandle> dev, int manual) =>
      _setTunerGainMode(dev, manual);
  final DartSetTunerGainMode _setTunerGainMode;

  @override
  int setTunerIfMode(Pointer<DeviceHandle> dev, int ifMode) =>
      _setTunerIfMode(dev, ifMode);
  final DartSetTunerIfMode _setTunerIfMode;

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
  int setDsMode(Pointer<DeviceHandle> dev, int mode, int freqThreshold) =>
      _setDsMode(dev, mode, freqThreshold);
  final DartSetDsMode _setDsMode;

  @override
  int setOffsetTuning(Pointer<DeviceHandle> dev, int on) =>
      _setOffsetTuning(dev, on);
  final DartSetOffsetTuning _setOffsetTuning;

  @override
  int getOffsetTuning(Pointer<DeviceHandle> dev) => _getOffsetTuning(dev);
  final DartGetOffsetTuning _getOffsetTuning;

  @override
  int setDithering(Pointer<DeviceHandle> dev, int dither) =>
      _setDithering(dev, dither);
  final DartSetDithering _setDithering;

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
  int irQuery(Pointer<DeviceHandle> dev, Pointer<Uint8> buf, int bufLen) =>
      _irQuery(dev, buf, bufLen);
  final DartIrQuery _irQuery;

  @override
  int setBiasTee(Pointer<DeviceHandle> dev, int on) => _setBiasTee(dev, on);
  final DartSetBiasTee _setBiasTee;

  @override
  int setBiasTeeGpio(Pointer<DeviceHandle> dev, int gpio, int on) =>
      _setBiasTeeGpio(dev, gpio, on);
  final DartSetBiasTeeGpio _setBiasTeeGpio;

  @override
  Pointer<Utf8> getVerId() => _getVerId();
  final DartGetVerId _getVerId;

  @override
  int getVersion() => _getVersion();
  final DartGetVersion _getVersion;
}
