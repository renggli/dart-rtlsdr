// AUTO-GENERATED CODE: DO NOT EDIT

import 'dart:ffi';

import 'package:ffi/ffi.dart';

import '../ffi/types.dart';
import 'abstract_bindings.dart';
import 'method_types.dart';

/// External bindings for testing.
class TestBindings implements AbstractBindings {
  TestBindings({
    DartGetDeviceCount? getDeviceCount,
    DartGetDeviceName? getDeviceName,
    DartGetDeviceUsbStrings? getDeviceUsbStrings,
    DartGetIndexBySerial? getIndexBySerial,
    DartOpen? open,
    DartClose? close,
    DartSetXtalFreq? setXtalFreq,
    DartGetXtalFreq? getXtalFreq,
    DartGetUsbStrings? getUsbStrings,
    DartWriteEeprom? writeEeprom,
    DartReadEeprom? readEeprom,
    DartSetCenterFreq? setCenterFreq,
    DartSetCenterFreq64? setCenterFreq64,
    DartSetHarmonicRx? setHarmonicRx,
    DartIsTunerPLLLocked? isTunerPLLLocked,
    DartGetCenterFreq? getCenterFreq,
    DartGetCenterFreq64? getCenterFreq64,
    DartSetFreqCorrection? setFreqCorrection,
    DartGetFreqCorrection? getFreqCorrection,
    DartGetTunerType? getTunerType,
    DartGetTunerGains? getTunerGains,
    DartSetTunerGain? setTunerGain,
    DartSetAndGetTunerBandwidth? setAndGetTunerBandwidth,
    DartSetTunerBandwidth? setTunerBandwidth,
    DartSetTunerBandCenter? setTunerBandCenter,
    DartSetTunerSideband? setTunerSideband,
    DartGetTunerGain? getTunerGain,
    DartSetTunerGainExt? setTunerGainExt,
    DartSetTunerIfGain? setTunerIfGain,
    DartSetTunerGainMode? setTunerGainMode,
    DartSetTunerIfMode? setTunerIfMode,
    DartSetSampleRate? setSampleRate,
    DartGetSampleRate? getSampleRate,
    DartSetTestmode? setTestmode,
    DartSetAgcMode? setAgcMode,
    DartSetDirectSampling? setDirectSampling,
    DartGetDirectSampling? getDirectSampling,
    DartSetDsMode? setDsMode,
    DartSetOffsetTuning? setOffsetTuning,
    DartGetOffsetTuning? getOffsetTuning,
    DartSetDithering? setDithering,
    DartResetBuffer? resetBuffer,
    DartReadSync? readSync,
    DartWaitAsync? waitAsync,
    DartReadAsync? readAsync,
    DartCancelAsync? cancelAsync,
    DartIrQuery? irQuery,
    DartSetBiasTee? setBiasTee,
    DartSetBiasTeeGpio? setBiasTeeGpio,
    DartGetVerId? getVerId,
    DartGetVersion? getVersion,
  }) {
    _getDeviceCount =
        getDeviceCount ?? (() => throw UnimplementedError('getDeviceCount'));
    _getDeviceName =
        getDeviceName ?? ((index) => throw UnimplementedError('getDeviceName'));
    _getDeviceUsbStrings = getDeviceUsbStrings ??
        ((index, manufact, product, serial) =>
            throw UnimplementedError('getDeviceUsbStrings'));
    _getIndexBySerial = getIndexBySerial ??
        ((serial) => throw UnimplementedError('getIndexBySerial'));
    _open = open ?? ((dev, index) => throw UnimplementedError('open'));
    _close = close ?? ((dev) => throw UnimplementedError('close'));
    _setXtalFreq = setXtalFreq ??
        ((dev, rtlFreq, tunerFreq) => throw UnimplementedError('setXtalFreq'));
    _getXtalFreq = getXtalFreq ??
        ((dev, rtlFreq, tunerFreq) => throw UnimplementedError('getXtalFreq'));
    _getUsbStrings = getUsbStrings ??
        ((dev, manufact, product, serial) =>
            throw UnimplementedError('getUsbStrings'));
    _writeEeprom = writeEeprom ??
        ((dev, data, offset, len) => throw UnimplementedError('writeEeprom'));
    _readEeprom = readEeprom ??
        ((dev, data, offset, len) => throw UnimplementedError('readEeprom'));
    _setCenterFreq = setCenterFreq ??
        ((dev, freq) => throw UnimplementedError('setCenterFreq'));
    _setCenterFreq64 = setCenterFreq64 ??
        ((dev, freq) => throw UnimplementedError('setCenterFreq64'));
    _setHarmonicRx = setHarmonicRx ??
        ((dev, harmonic) => throw UnimplementedError('setHarmonicRx'));
    _isTunerPLLLocked = isTunerPLLLocked ??
        ((dev) => throw UnimplementedError('isTunerPLLLocked'));
    _getCenterFreq =
        getCenterFreq ?? ((dev) => throw UnimplementedError('getCenterFreq'));
    _getCenterFreq64 = getCenterFreq64 ??
        ((dev) => throw UnimplementedError('getCenterFreq64'));
    _setFreqCorrection = setFreqCorrection ??
        ((dev, ppm) => throw UnimplementedError('setFreqCorrection'));
    _getFreqCorrection = getFreqCorrection ??
        ((dev) => throw UnimplementedError('getFreqCorrection'));
    _getTunerType =
        getTunerType ?? ((dev) => throw UnimplementedError('getTunerType'));
    _getTunerGains = getTunerGains ??
        ((dev, gains) => throw UnimplementedError('getTunerGains'));
    _setTunerGain = setTunerGain ??
        ((dev, gain) => throw UnimplementedError('setTunerGain'));
    _setAndGetTunerBandwidth = setAndGetTunerBandwidth ??
        ((dev, bw, appliedBw, applyBw) =>
            throw UnimplementedError('setAndGetTunerBandwidth'));
    _setTunerBandwidth = setTunerBandwidth ??
        ((dev, bw) => throw UnimplementedError('setTunerBandwidth'));
    _setTunerBandCenter = setTunerBandCenter ??
        ((dev, ifBandCenterFreq) =>
            throw UnimplementedError('setTunerBandCenter'));
    _setTunerSideband = setTunerSideband ??
        ((dev, sideband) => throw UnimplementedError('setTunerSideband'));
    _getTunerGain =
        getTunerGain ?? ((dev) => throw UnimplementedError('getTunerGain'));
    _setTunerGainExt = setTunerGainExt ??
        ((dev, lnaGain, mixerGain, vgaGain) =>
            throw UnimplementedError('setTunerGainExt'));
    _setTunerIfGain = setTunerIfGain ??
        ((dev, stage, gain) => throw UnimplementedError('setTunerIfGain'));
    _setTunerGainMode = setTunerGainMode ??
        ((dev, manual) => throw UnimplementedError('setTunerGainMode'));
    _setTunerIfMode = setTunerIfMode ??
        ((dev, ifMode) => throw UnimplementedError('setTunerIfMode'));
    _setSampleRate = setSampleRate ??
        ((dev, rate) => throw UnimplementedError('setSampleRate'));
    _getSampleRate =
        getSampleRate ?? ((dev) => throw UnimplementedError('getSampleRate'));
    _setTestmode =
        setTestmode ?? ((dev, on) => throw UnimplementedError('setTestmode'));
    _setAgcMode =
        setAgcMode ?? ((dev, on) => throw UnimplementedError('setAgcMode'));
    _setDirectSampling = setDirectSampling ??
        ((dev, on) => throw UnimplementedError('setDirectSampling'));
    _getDirectSampling = getDirectSampling ??
        ((dev) => throw UnimplementedError('getDirectSampling'));
    _setDsMode = setDsMode ??
        ((dev, mode, freqThreshold) => throw UnimplementedError('setDsMode'));
    _setOffsetTuning = setOffsetTuning ??
        ((dev, on) => throw UnimplementedError('setOffsetTuning'));
    _getOffsetTuning = getOffsetTuning ??
        ((dev) => throw UnimplementedError('getOffsetTuning'));
    _setDithering = setDithering ??
        ((dev, dither) => throw UnimplementedError('setDithering'));
    _resetBuffer =
        resetBuffer ?? ((dev) => throw UnimplementedError('resetBuffer'));
    _readSync = readSync ??
        ((dev, buf, len, nRead) => throw UnimplementedError('readSync'));
    _waitAsync =
        waitAsync ?? ((dev, cb, ctx) => throw UnimplementedError('waitAsync'));
    _readAsync = readAsync ??
        ((dev, cb, ctx, bufNum, bufLen) =>
            throw UnimplementedError('readAsync'));
    _cancelAsync =
        cancelAsync ?? ((dev) => throw UnimplementedError('cancelAsync'));
    _irQuery =
        irQuery ?? ((dev, buf, bufLen) => throw UnimplementedError('irQuery'));
    _setBiasTee =
        setBiasTee ?? ((dev, on) => throw UnimplementedError('setBiasTee'));
    _setBiasTeeGpio = setBiasTeeGpio ??
        ((dev, gpio, on) => throw UnimplementedError('setBiasTeeGpio'));
    _getVerId = getVerId ?? (() => throw UnimplementedError('getVerId'));
    _getVersion = getVersion ?? (() => throw UnimplementedError('getVersion'));
  }

  @override
  int getDeviceCount() => _getDeviceCount();
  late DartGetDeviceCount _getDeviceCount;

  @override
  Pointer<Utf8> getDeviceName(int index) => _getDeviceName(index);
  late DartGetDeviceName _getDeviceName;

  @override
  int getDeviceUsbStrings(int index, Pointer<Utf8> manufact,
          Pointer<Utf8> product, Pointer<Utf8> serial) =>
      _getDeviceUsbStrings(index, manufact, product, serial);
  late DartGetDeviceUsbStrings _getDeviceUsbStrings;

  @override
  int getIndexBySerial(Pointer<Utf8> serial) => _getIndexBySerial(serial);
  late DartGetIndexBySerial _getIndexBySerial;

  @override
  int open(Pointer<Pointer<DeviceHandle>> dev, int index) => _open(dev, index);
  late DartOpen _open;

  @override
  int close(Pointer<DeviceHandle> dev) => _close(dev);
  late DartClose _close;

  @override
  int setXtalFreq(Pointer<DeviceHandle> dev, int rtlFreq, int tunerFreq) =>
      _setXtalFreq(dev, rtlFreq, tunerFreq);
  late DartSetXtalFreq _setXtalFreq;

  @override
  int getXtalFreq(Pointer<DeviceHandle> dev, Pointer<Uint32> rtlFreq,
          Pointer<Uint32> tunerFreq) =>
      _getXtalFreq(dev, rtlFreq, tunerFreq);
  late DartGetXtalFreq _getXtalFreq;

  @override
  int getUsbStrings(Pointer<DeviceHandle> dev, Pointer<Utf8> manufact,
          Pointer<Utf8> product, Pointer<Utf8> serial) =>
      _getUsbStrings(dev, manufact, product, serial);
  late DartGetUsbStrings _getUsbStrings;

  @override
  int writeEeprom(Pointer<DeviceHandle> dev, Pointer<Uint8> data, int offset,
          int len) =>
      _writeEeprom(dev, data, offset, len);
  late DartWriteEeprom _writeEeprom;

  @override
  int readEeprom(Pointer<DeviceHandle> dev, Pointer<Uint8> data, int offset,
          int len) =>
      _readEeprom(dev, data, offset, len);
  late DartReadEeprom _readEeprom;

  @override
  int setCenterFreq(Pointer<DeviceHandle> dev, int freq) =>
      _setCenterFreq(dev, freq);
  late DartSetCenterFreq _setCenterFreq;

  @override
  int setCenterFreq64(Pointer<DeviceHandle> dev, int freq) =>
      _setCenterFreq64(dev, freq);
  late DartSetCenterFreq64 _setCenterFreq64;

  @override
  int setHarmonicRx(Pointer<DeviceHandle> dev, int harmonic) =>
      _setHarmonicRx(dev, harmonic);
  late DartSetHarmonicRx _setHarmonicRx;

  @override
  int isTunerPLLLocked(Pointer<DeviceHandle> dev) => _isTunerPLLLocked(dev);
  late DartIsTunerPLLLocked _isTunerPLLLocked;

  @override
  int getCenterFreq(Pointer<DeviceHandle> dev) => _getCenterFreq(dev);
  late DartGetCenterFreq _getCenterFreq;

  @override
  int getCenterFreq64(Pointer<DeviceHandle> dev) => _getCenterFreq64(dev);
  late DartGetCenterFreq64 _getCenterFreq64;

  @override
  int setFreqCorrection(Pointer<DeviceHandle> dev, int ppm) =>
      _setFreqCorrection(dev, ppm);
  late DartSetFreqCorrection _setFreqCorrection;

  @override
  int getFreqCorrection(Pointer<DeviceHandle> dev) => _getFreqCorrection(dev);
  late DartGetFreqCorrection _getFreqCorrection;

  @override
  int getTunerType(Pointer<DeviceHandle> dev) => _getTunerType(dev);
  late DartGetTunerType _getTunerType;

  @override
  int getTunerGains(Pointer<DeviceHandle> dev, Pointer<Int> gains) =>
      _getTunerGains(dev, gains);
  late DartGetTunerGains _getTunerGains;

  @override
  int setTunerGain(Pointer<DeviceHandle> dev, int gain) =>
      _setTunerGain(dev, gain);
  late DartSetTunerGain _setTunerGain;

  @override
  int setAndGetTunerBandwidth(Pointer<DeviceHandle> dev, int bw,
          Pointer<Uint32> appliedBw, int applyBw) =>
      _setAndGetTunerBandwidth(dev, bw, appliedBw, applyBw);
  late DartSetAndGetTunerBandwidth _setAndGetTunerBandwidth;

  @override
  int setTunerBandwidth(Pointer<DeviceHandle> dev, int bw) =>
      _setTunerBandwidth(dev, bw);
  late DartSetTunerBandwidth _setTunerBandwidth;

  @override
  int setTunerBandCenter(Pointer<DeviceHandle> dev, int ifBandCenterFreq) =>
      _setTunerBandCenter(dev, ifBandCenterFreq);
  late DartSetTunerBandCenter _setTunerBandCenter;

  @override
  int setTunerSideband(Pointer<DeviceHandle> dev, int sideband) =>
      _setTunerSideband(dev, sideband);
  late DartSetTunerSideband _setTunerSideband;

  @override
  int getTunerGain(Pointer<DeviceHandle> dev) => _getTunerGain(dev);
  late DartGetTunerGain _getTunerGain;

  @override
  int setTunerGainExt(
          Pointer<DeviceHandle> dev, int lnaGain, int mixerGain, int vgaGain) =>
      _setTunerGainExt(dev, lnaGain, mixerGain, vgaGain);
  late DartSetTunerGainExt _setTunerGainExt;

  @override
  int setTunerIfGain(Pointer<DeviceHandle> dev, int stage, int gain) =>
      _setTunerIfGain(dev, stage, gain);
  late DartSetTunerIfGain _setTunerIfGain;

  @override
  int setTunerGainMode(Pointer<DeviceHandle> dev, int manual) =>
      _setTunerGainMode(dev, manual);
  late DartSetTunerGainMode _setTunerGainMode;

  @override
  int setTunerIfMode(Pointer<DeviceHandle> dev, int ifMode) =>
      _setTunerIfMode(dev, ifMode);
  late DartSetTunerIfMode _setTunerIfMode;

  @override
  int setSampleRate(Pointer<DeviceHandle> dev, int rate) =>
      _setSampleRate(dev, rate);
  late DartSetSampleRate _setSampleRate;

  @override
  int getSampleRate(Pointer<DeviceHandle> dev) => _getSampleRate(dev);
  late DartGetSampleRate _getSampleRate;

  @override
  int setTestmode(Pointer<DeviceHandle> dev, int on) => _setTestmode(dev, on);
  late DartSetTestmode _setTestmode;

  @override
  int setAgcMode(Pointer<DeviceHandle> dev, int on) => _setAgcMode(dev, on);
  late DartSetAgcMode _setAgcMode;

  @override
  int setDirectSampling(Pointer<DeviceHandle> dev, int on) =>
      _setDirectSampling(dev, on);
  late DartSetDirectSampling _setDirectSampling;

  @override
  int getDirectSampling(Pointer<DeviceHandle> dev) => _getDirectSampling(dev);
  late DartGetDirectSampling _getDirectSampling;

  @override
  int setDsMode(Pointer<DeviceHandle> dev, int mode, int freqThreshold) =>
      _setDsMode(dev, mode, freqThreshold);
  late DartSetDsMode _setDsMode;

  @override
  int setOffsetTuning(Pointer<DeviceHandle> dev, int on) =>
      _setOffsetTuning(dev, on);
  late DartSetOffsetTuning _setOffsetTuning;

  @override
  int getOffsetTuning(Pointer<DeviceHandle> dev) => _getOffsetTuning(dev);
  late DartGetOffsetTuning _getOffsetTuning;

  @override
  int setDithering(Pointer<DeviceHandle> dev, int dither) =>
      _setDithering(dev, dither);
  late DartSetDithering _setDithering;

  @override
  int resetBuffer(Pointer<DeviceHandle> dev) => _resetBuffer(dev);
  late DartResetBuffer _resetBuffer;

  @override
  int readSync(Pointer<DeviceHandle> dev, Pointer<Void> buf, int len,
          Pointer<Int> nRead) =>
      _readSync(dev, buf, len, nRead);
  late DartReadSync _readSync;

  @override
  int waitAsync(Pointer<DeviceHandle> dev, Pointer cb, Pointer<Void> ctx) =>
      _waitAsync(dev, cb, ctx);
  late DartWaitAsync _waitAsync;

  @override
  int readAsync(Pointer<DeviceHandle> dev, Pointer cb, Pointer<Void> ctx,
          int bufNum, int bufLen) =>
      _readAsync(dev, cb, ctx, bufNum, bufLen);
  late DartReadAsync _readAsync;

  @override
  int cancelAsync(Pointer<DeviceHandle> dev) => _cancelAsync(dev);
  late DartCancelAsync _cancelAsync;

  @override
  int irQuery(Pointer<DeviceHandle> dev, Pointer<Uint8> buf, int bufLen) =>
      _irQuery(dev, buf, bufLen);
  late DartIrQuery _irQuery;

  @override
  int setBiasTee(Pointer<DeviceHandle> dev, int on) => _setBiasTee(dev, on);
  late DartSetBiasTee _setBiasTee;

  @override
  int setBiasTeeGpio(Pointer<DeviceHandle> dev, int gpio, int on) =>
      _setBiasTeeGpio(dev, gpio, on);
  late DartSetBiasTeeGpio _setBiasTeeGpio;

  @override
  Pointer<Utf8> getVerId() => _getVerId();
  late DartGetVerId _getVerId;

  @override
  int getVersion() => _getVersion();
  late DartGetVersion _getVersion;
}
