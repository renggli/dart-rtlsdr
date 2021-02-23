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

  late DartGetDeviceCount _getDeviceCount;
  late DartGetDeviceName _getDeviceName;
  late DartGetDeviceUsbStrings _getDeviceUsbStrings;
  late DartGetIndexBySerial _getIndexBySerial;
  late DartOpen _open;
  late DartClose _close;
  late DartSetXtalFreq _setXtalFreq;
  late DartGetXtalFreq _getXtalFreq;
  late DartGetUsbStrings _getUsbStrings;
  late DartWriteEeprom _writeEeprom;
  late DartReadEeprom _readEeprom;
  late DartSetCenterFreq _setCenterFreq;
  late DartSetCenterFreq64 _setCenterFreq64;
  late DartSetHarmonicRx _setHarmonicRx;
  late DartIsTunerPLLLocked _isTunerPLLLocked;
  late DartGetCenterFreq _getCenterFreq;
  late DartGetCenterFreq64 _getCenterFreq64;
  late DartSetFreqCorrection _setFreqCorrection;
  late DartGetFreqCorrection _getFreqCorrection;
  late DartGetTunerType _getTunerType;
  late DartGetTunerGains _getTunerGains;
  late DartSetTunerGain _setTunerGain;
  late DartSetAndGetTunerBandwidth _setAndGetTunerBandwidth;
  late DartSetTunerBandwidth _setTunerBandwidth;
  late DartSetTunerBandCenter _setTunerBandCenter;
  late DartSetTunerSideband _setTunerSideband;
  late DartGetTunerGain _getTunerGain;
  late DartSetTunerGainExt _setTunerGainExt;
  late DartSetTunerIfGain _setTunerIfGain;
  late DartSetTunerGainMode _setTunerGainMode;
  late DartSetTunerIfMode _setTunerIfMode;
  late DartSetSampleRate _setSampleRate;
  late DartGetSampleRate _getSampleRate;
  late DartSetTestmode _setTestmode;
  late DartSetAgcMode _setAgcMode;
  late DartSetDirectSampling _setDirectSampling;
  late DartGetDirectSampling _getDirectSampling;
  late DartSetDsMode _setDsMode;
  late DartSetOffsetTuning _setOffsetTuning;
  late DartGetOffsetTuning _getOffsetTuning;
  late DartSetDithering _setDithering;
  late DartResetBuffer _resetBuffer;
  late DartReadSync _readSync;
  late DartWaitAsync _waitAsync;
  late DartReadAsync _readAsync;
  late DartCancelAsync _cancelAsync;
  late DartIrQuery _irQuery;
  late DartSetBiasTee _setBiasTee;
  late DartSetBiasTeeGpio _setBiasTeeGpio;
  late DartGetVerId _getVerId;
  late DartGetVersion _getVersion;

  @override
  int getDeviceCount() => _getDeviceCount();

  @override
  Pointer<Utf8> getDeviceName(int index) => _getDeviceName(index);

  @override
  int getDeviceUsbStrings(int index, Pointer<Utf8> manufact,
          Pointer<Utf8> product, Pointer<Utf8> serial) =>
      _getDeviceUsbStrings(index, manufact, product, serial);

  @override
  int getIndexBySerial(Pointer<Utf8> serial) => _getIndexBySerial(serial);

  @override
  int open(Pointer<Pointer<DeviceHandle>> dev, int index) => _open(dev, index);

  @override
  int close(Pointer<DeviceHandle> dev) => _close(dev);

  @override
  int setXtalFreq(Pointer<DeviceHandle> dev, int rtlFreq, int tunerFreq) =>
      _setXtalFreq(dev, rtlFreq, tunerFreq);

  @override
  int getXtalFreq(Pointer<DeviceHandle> dev, Pointer<Uint32> rtlFreq,
          Pointer<Uint32> tunerFreq) =>
      _getXtalFreq(dev, rtlFreq, tunerFreq);

  @override
  int getUsbStrings(Pointer<DeviceHandle> dev, Pointer<Utf8> manufact,
          Pointer<Utf8> product, Pointer<Utf8> serial) =>
      _getUsbStrings(dev, manufact, product, serial);

  @override
  int writeEeprom(Pointer<DeviceHandle> dev, Pointer<Uint8> data, int offset,
          int len) =>
      _writeEeprom(dev, data, offset, len);

  @override
  int readEeprom(Pointer<DeviceHandle> dev, Pointer<Uint8> data, int offset,
          int len) =>
      _readEeprom(dev, data, offset, len);

  @override
  int setCenterFreq(Pointer<DeviceHandle> dev, int freq) =>
      _setCenterFreq(dev, freq);

  @override
  int setCenterFreq64(Pointer<DeviceHandle> dev, int freq) =>
      _setCenterFreq64(dev, freq);

  @override
  int setHarmonicRx(Pointer<DeviceHandle> dev, int harmonic) =>
      _setHarmonicRx(dev, harmonic);

  @override
  int isTunerPLLLocked(Pointer<DeviceHandle> dev) => _isTunerPLLLocked(dev);

  @override
  int getCenterFreq(Pointer<DeviceHandle> dev) => _getCenterFreq(dev);

  @override
  int getCenterFreq64(Pointer<DeviceHandle> dev) => _getCenterFreq64(dev);

  @override
  int setFreqCorrection(Pointer<DeviceHandle> dev, int ppm) =>
      _setFreqCorrection(dev, ppm);

  @override
  int getFreqCorrection(Pointer<DeviceHandle> dev) => _getFreqCorrection(dev);

  @override
  int getTunerType(Pointer<DeviceHandle> dev) => _getTunerType(dev);

  @override
  int getTunerGains(Pointer<DeviceHandle> dev, Pointer<IntPtr> gains) =>
      _getTunerGains(dev, gains);

  @override
  int setTunerGain(Pointer<DeviceHandle> dev, int gain) =>
      _setTunerGain(dev, gain);

  @override
  int setAndGetTunerBandwidth(Pointer<DeviceHandle> dev, int bw,
          Pointer<Uint32> appliedBw, int applyBw) =>
      _setAndGetTunerBandwidth(dev, bw, appliedBw, applyBw);

  @override
  int setTunerBandwidth(Pointer<DeviceHandle> dev, int bw) =>
      _setTunerBandwidth(dev, bw);

  @override
  int setTunerBandCenter(Pointer<DeviceHandle> dev, int ifBandCenterFreq) =>
      _setTunerBandCenter(dev, ifBandCenterFreq);

  @override
  int setTunerSideband(Pointer<DeviceHandle> dev, int sideband) =>
      _setTunerSideband(dev, sideband);

  @override
  int getTunerGain(Pointer<DeviceHandle> dev) => _getTunerGain(dev);

  @override
  int setTunerGainExt(
          Pointer<DeviceHandle> dev, int lnaGain, int mixerGain, int vgaGain) =>
      _setTunerGainExt(dev, lnaGain, mixerGain, vgaGain);

  @override
  int setTunerIfGain(Pointer<DeviceHandle> dev, int stage, int gain) =>
      _setTunerIfGain(dev, stage, gain);

  @override
  int setTunerGainMode(Pointer<DeviceHandle> dev, int manual) =>
      _setTunerGainMode(dev, manual);

  @override
  int setTunerIfMode(Pointer<DeviceHandle> dev, int ifMode) =>
      _setTunerIfMode(dev, ifMode);

  @override
  int setSampleRate(Pointer<DeviceHandle> dev, int rate) =>
      _setSampleRate(dev, rate);

  @override
  int getSampleRate(Pointer<DeviceHandle> dev) => _getSampleRate(dev);

  @override
  int setTestmode(Pointer<DeviceHandle> dev, int on) => _setTestmode(dev, on);

  @override
  int setAgcMode(Pointer<DeviceHandle> dev, int on) => _setAgcMode(dev, on);

  @override
  int setDirectSampling(Pointer<DeviceHandle> dev, int on) =>
      _setDirectSampling(dev, on);

  @override
  int getDirectSampling(Pointer<DeviceHandle> dev) => _getDirectSampling(dev);

  @override
  int setDsMode(Pointer<DeviceHandle> dev, int mode, int freqThreshold) =>
      _setDsMode(dev, mode, freqThreshold);

  @override
  int setOffsetTuning(Pointer<DeviceHandle> dev, int on) =>
      _setOffsetTuning(dev, on);

  @override
  int getOffsetTuning(Pointer<DeviceHandle> dev) => _getOffsetTuning(dev);

  @override
  int setDithering(Pointer<DeviceHandle> dev, int dither) =>
      _setDithering(dev, dither);

  @override
  int resetBuffer(Pointer<DeviceHandle> dev) => _resetBuffer(dev);

  @override
  int readSync(Pointer<DeviceHandle> dev, Pointer<Uint8> buf, int len,
          Pointer<IntPtr> nRead) =>
      _readSync(dev, buf, len, nRead);

  @override
  int waitAsync(Pointer<DeviceHandle> dev, Pointer cb, Pointer<Uint8> ctx) =>
      _waitAsync(dev, cb, ctx);

  @override
  int readAsync(Pointer<DeviceHandle> dev, Pointer cb, Pointer<Uint8> ctx,
          int bufNum, int bufLen) =>
      _readAsync(dev, cb, ctx, bufNum, bufLen);

  @override
  int cancelAsync(Pointer<DeviceHandle> dev) => _cancelAsync(dev);

  @override
  int irQuery(Pointer<DeviceHandle> dev, Pointer<Uint8> buf, int bufLen) =>
      _irQuery(dev, buf, bufLen);

  @override
  int setBiasTee(Pointer<DeviceHandle> dev, int on) => _setBiasTee(dev, on);

  @override
  int setBiasTeeGpio(Pointer<DeviceHandle> dev, int gpio, int on) =>
      _setBiasTeeGpio(dev, gpio, on);

  @override
  Pointer<Utf8> getVerId() => _getVerId();

  @override
  int getVersion() => _getVersion();
}
