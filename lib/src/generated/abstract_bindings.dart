// AUTO-GENERATED CODE: DO NOT EDIT

import 'dart:ffi';

import 'package:ffi/ffi.dart';

import '../ffi/types.dart';

/// Abstract base class for the external bindings.
abstract class AbstractBindings {
  int getDeviceCount();

  Pointer<Utf8> getDeviceName(int index);

  int getDeviceUsbStrings(
    int index,
    Pointer<Utf8> manufact,
    Pointer<Utf8> product,
    Pointer<Utf8> serial,
  );

  int getIndexBySerial(Pointer<Utf8> serial);

  int open(Pointer<Pointer<DeviceHandle>> dev, int index);

  int close(Pointer<DeviceHandle> dev);

  int setXtalFreq(Pointer<DeviceHandle> dev, int rtlFreq, int tunerFreq);

  int getXtalFreq(
    Pointer<DeviceHandle> dev,
    Pointer<Uint32> rtlFreq,
    Pointer<Uint32> tunerFreq,
  );

  int getUsbStrings(
    Pointer<DeviceHandle> dev,
    Pointer<Utf8> manufact,
    Pointer<Utf8> product,
    Pointer<Utf8> serial,
  );

  int writeEeprom(
    Pointer<DeviceHandle> dev,
    Pointer<Uint8> data,
    int offset,
    int len,
  );

  int readEeprom(
    Pointer<DeviceHandle> dev,
    Pointer<Uint8> data,
    int offset,
    int len,
  );

  int setCenterFreq(Pointer<DeviceHandle> dev, int freq);

  int getCenterFreq(Pointer<DeviceHandle> dev);

  int setFreqCorrection(Pointer<DeviceHandle> dev, int ppm);

  int getFreqCorrection(Pointer<DeviceHandle> dev);

  int getTunerType(Pointer<DeviceHandle> dev);

  int getTunerGains(Pointer<DeviceHandle> dev, Pointer<Int> gains);

  int setTunerGain(Pointer<DeviceHandle> dev, int gain);

  int setTunerBandwidth(Pointer<DeviceHandle> dev, int bw);

  int getTunerGain(Pointer<DeviceHandle> dev);

  int setTunerIfGain(Pointer<DeviceHandle> dev, int stage, int gain);

  int setTunerGainMode(Pointer<DeviceHandle> dev, int manual);

  int setSampleRate(Pointer<DeviceHandle> dev, int rate);

  int getSampleRate(Pointer<DeviceHandle> dev);

  int setTestmode(Pointer<DeviceHandle> dev, int on);

  int setAgcMode(Pointer<DeviceHandle> dev, int on);

  int setDirectSampling(Pointer<DeviceHandle> dev, int on);

  int getDirectSampling(Pointer<DeviceHandle> dev);

  int setOffsetTuning(Pointer<DeviceHandle> dev, int on);

  int getOffsetTuning(Pointer<DeviceHandle> dev);

  int resetBuffer(Pointer<DeviceHandle> dev);

  int readSync(
    Pointer<DeviceHandle> dev,
    Pointer<Void> buf,
    int len,
    Pointer<Int> nRead,
  );

  int waitAsync(Pointer<DeviceHandle> dev, Pointer cb, Pointer<Void> ctx);

  int readAsync(
    Pointer<DeviceHandle> dev,
    Pointer cb,
    Pointer<Void> ctx,
    int bufNum,
    int bufLen,
  );

  int cancelAsync(Pointer<DeviceHandle> dev);

  int setBiasTee(Pointer<DeviceHandle> dev, int on);
}
