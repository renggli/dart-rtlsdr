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
    DartGetCenterFreq? getCenterFreq,
    DartSetFreqCorrection? setFreqCorrection,
    DartGetFreqCorrection? getFreqCorrection,
    DartGetTunerType? getTunerType,
    DartGetTunerGains? getTunerGains,
    DartSetTunerGain? setTunerGain,
    DartSetTunerBandwidth? setTunerBandwidth,
    DartGetTunerGain? getTunerGain,
    DartSetTunerIfGain? setTunerIfGain,
    DartSetTunerGainMode? setTunerGainMode,
    DartSetSampleRate? setSampleRate,
    DartGetSampleRate? getSampleRate,
    DartSetTestmode? setTestmode,
    DartSetAgcMode? setAgcMode,
    DartSetDirectSampling? setDirectSampling,
    DartGetDirectSampling? getDirectSampling,
    DartSetOffsetTuning? setOffsetTuning,
    DartGetOffsetTuning? getOffsetTuning,
    DartResetBuffer? resetBuffer,
    DartReadSync? readSync,
    DartWaitAsync? waitAsync,
    DartReadAsync? readAsync,
    DartCancelAsync? cancelAsync,
    DartSetBiasTee? setBiasTee,
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
    _getCenterFreq =
        getCenterFreq ?? ((dev) => throw UnimplementedError('getCenterFreq'));
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
    _setTunerBandwidth = setTunerBandwidth ??
        ((dev, bw) => throw UnimplementedError('setTunerBandwidth'));
    _getTunerGain =
        getTunerGain ?? ((dev) => throw UnimplementedError('getTunerGain'));
    _setTunerIfGain = setTunerIfGain ??
        ((dev, stage, gain) => throw UnimplementedError('setTunerIfGain'));
    _setTunerGainMode = setTunerGainMode ??
        ((dev, manual) => throw UnimplementedError('setTunerGainMode'));
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
    _setOffsetTuning = setOffsetTuning ??
        ((dev, on) => throw UnimplementedError('setOffsetTuning'));
    _getOffsetTuning = getOffsetTuning ??
        ((dev) => throw UnimplementedError('getOffsetTuning'));
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
    _setBiasTee =
        setBiasTee ?? ((dev, on) => throw UnimplementedError('setBiasTee'));
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
  int getCenterFreq(Pointer<DeviceHandle> dev) => _getCenterFreq(dev);
  late DartGetCenterFreq _getCenterFreq;

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
  int setTunerBandwidth(Pointer<DeviceHandle> dev, int bw) =>
      _setTunerBandwidth(dev, bw);
  late DartSetTunerBandwidth _setTunerBandwidth;

  @override
  int getTunerGain(Pointer<DeviceHandle> dev) => _getTunerGain(dev);
  late DartGetTunerGain _getTunerGain;

  @override
  int setTunerIfGain(Pointer<DeviceHandle> dev, int stage, int gain) =>
      _setTunerIfGain(dev, stage, gain);
  late DartSetTunerIfGain _setTunerIfGain;

  @override
  int setTunerGainMode(Pointer<DeviceHandle> dev, int manual) =>
      _setTunerGainMode(dev, manual);
  late DartSetTunerGainMode _setTunerGainMode;

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
  int setOffsetTuning(Pointer<DeviceHandle> dev, int on) =>
      _setOffsetTuning(dev, on);
  late DartSetOffsetTuning _setOffsetTuning;

  @override
  int getOffsetTuning(Pointer<DeviceHandle> dev) => _getOffsetTuning(dev);
  late DartGetOffsetTuning _getOffsetTuning;

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
  int setBiasTee(Pointer<DeviceHandle> dev, int on) => _setBiasTee(dev, on);
  late DartSetBiasTee _setBiasTee;
}
