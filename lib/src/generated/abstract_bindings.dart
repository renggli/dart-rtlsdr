import 'dart:ffi';
import 'package:ffi/ffi.dart';

import '../ffi/types.dart';

/// Abstract base class for the external bindings.
abstract class AbstractBindings {
  int getDeviceCount();

  Pointer<Utf8> getDeviceName(int index);

  int getDeviceUsbStrings(int index, Pointer<Utf8> manufact,
      Pointer<Utf8> product, Pointer<Utf8> serial);

  int getIndexBySerial(Pointer<Utf8> serial);

  int open(Pointer<Pointer<DeviceHandle>> dev, int index);

  int close(Pointer<DeviceHandle> dev);

  int setXtalFreq(Pointer<DeviceHandle> dev, int rtlFreq, int tunerFreq);

  int getXtalFreq(Pointer<DeviceHandle> dev, Pointer<Uint32> rtlFreq,
      Pointer<Uint32> tunerFreq);

  int getUsbStrings(Pointer<DeviceHandle> dev, Pointer<Utf8> manufact,
      Pointer<Utf8> product, Pointer<Utf8> serial);

  int writeEeprom(
      Pointer<DeviceHandle> dev, Pointer<Uint8> data, int offset, int len);

  int readEeprom(
      Pointer<DeviceHandle> dev, Pointer<Uint8> data, int offset, int len);

  int setCenterFreq(Pointer<DeviceHandle> dev, int freq);

  int setCenterFreq64(Pointer<DeviceHandle> dev, int freq);

  int setHarmonicRx(Pointer<DeviceHandle> dev, int harmonic);

  int isTunerPLLLocked(Pointer<DeviceHandle> dev);

  int getCenterFreq(Pointer<DeviceHandle> dev);

  int getCenterFreq64(Pointer<DeviceHandle> dev);

  int setFreqCorrection(Pointer<DeviceHandle> dev, int ppm);

  int getFreqCorrection(Pointer<DeviceHandle> dev);

  int getTunerType(Pointer<DeviceHandle> dev);

  int getTunerGains(Pointer<DeviceHandle> dev, Pointer<IntPtr> gains);

  int setTunerGain(Pointer<DeviceHandle> dev, int gain);

  int setAndGetTunerBandwidth(Pointer<DeviceHandle> dev, int bw,
      Pointer<Uint32> appliedBw, int applyBw);

  int setTunerBandwidth(Pointer<DeviceHandle> dev, int bw);

  int setTunerBandCenter(Pointer<DeviceHandle> dev, int ifBandCenterFreq);

  int setTunerSideband(Pointer<DeviceHandle> dev, int sideband);

  int getTunerGain(Pointer<DeviceHandle> dev);

  int setTunerGainExt(
      Pointer<DeviceHandle> dev, int lnaGain, int mixerGain, int vgaGain);

  int setTunerIfGain(Pointer<DeviceHandle> dev, int stage, int gain);

  int setTunerGainMode(Pointer<DeviceHandle> dev, int manual);

  int setTunerIfMode(Pointer<DeviceHandle> dev, int ifMode);

  int setSampleRate(Pointer<DeviceHandle> dev, int rate);

  int getSampleRate(Pointer<DeviceHandle> dev);

  int setTestmode(Pointer<DeviceHandle> dev, int on);

  int setAgcMode(Pointer<DeviceHandle> dev, int on);

  int setDirectSampling(Pointer<DeviceHandle> dev, int on);

  int getDirectSampling(Pointer<DeviceHandle> dev);

  int setDsMode(Pointer<DeviceHandle> dev, int mode, int freqThreshold);

  int setOffsetTuning(Pointer<DeviceHandle> dev, int on);

  int getOffsetTuning(Pointer<DeviceHandle> dev);

  int setDithering(Pointer<DeviceHandle> dev, int dither);

  int resetBuffer(Pointer<DeviceHandle> dev);

  int readSync(Pointer<DeviceHandle> dev, Pointer<Uint8> buf, int len,
      Pointer<IntPtr> nRead);

  int waitAsync(Pointer<DeviceHandle> dev, Pointer cb, Pointer<Uint8> ctx);

  int readAsync(Pointer<DeviceHandle> dev, Pointer cb, Pointer<Uint8> ctx,
      int bufNum, int bufLen);

  int cancelAsync(Pointer<DeviceHandle> dev);

  int irQuery(Pointer<DeviceHandle> dev, Pointer<Uint8> buf, int bufLen);

  int setBiasTee(Pointer<DeviceHandle> dev, int on);

  int setBiasTeeGpio(Pointer<DeviceHandle> dev, int gpio, int on);

  Pointer<Utf8> getVerId();

  int getVersion();
}
