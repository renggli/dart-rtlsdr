library rtlsdr.ffi.bindings;

import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:rtlsdr/src/ffi/types.dart';

import 'signatures.dart';

class Bindings {
  final DynamicLibrary rtlsdr;

  final int Function() get_device_count;

  final Pointer<Utf8> Function(int index) get_device_name;

  /**
   * Get USB device strings.
   *
   * NOTE: The string arguments must provide space for up to 256 bytes.
   *
   * \param index the device index
   * \param manufact manufacturer name, may be NULL
   * \param product product name, may be NULL
   * \param serial serial number, may be NULL
   * \return 0 on success
   */
  final int Function(int index, Pointer<Utf8> manufact, Pointer<Utf8> product,
      Pointer<Utf8> serial) get_device_usb_strings;

  /**
   * Get device index by USB serial string descriptor.
   *
   * \param serial serial string of the device
   * \return device index of first device where the name matched
   * \return -1 if name is NULL
   * \return -2 if no devices were found at all
   * \return -3 if devices were found, but none with matching name
   */
  final int Function(Pointer<Utf8> serial) get_index_by_serial;

  final int Function(Pointer<Pointer<DeviceHandle>> dev, int index) open;

  final int Function(Pointer<DeviceHandle> dev) close;

  /* configuration functions */

  /**
   * Set crystal oscillator frequencies used for the RTL2832 and the tuner IC.
   *
   * Usually both ICs use the same clock. Changing the clock may make sense if
   * you are applying an external clock to the tuner or to compensate the
   * frequency (and samplerate) error caused by the original (cheap) crystal.
   *
   * NOTE: Call this function only if you fully understand the implications.
   *
   * \param dev the device handle given by rtlsdr_open()
   * \param rtl_freq frequency value used to clock the RTL2832 in Hz
   * \param tuner_freq frequency value used to clock the tuner IC in Hz
   * \return 0 on success
   */
  final int Function(Pointer<DeviceHandle> dev, int rtl_freq, int tuner_freq)
      set_xtal_freq;

  /**
   * Get crystal oscillator frequencies used for the RTL2832 and the tuner IC.
   *
   * Usually both ICs use the same clock.
   *
   * \param dev the device handle given by rtlsdr_open()
   * \param rtl_freq frequency value used to clock the RTL2832 in Hz
   * \param tuner_freq frequency value used to clock the tuner IC in Hz
   * \return 0 on success
   */
  final int Function(Pointer<DeviceHandle> dev, Pointer<Uint32> rtl_freq,
      Pointer<Uint32> tuner_freq) get_xtal_freq;

  /**
   * Get USB device strings.
   *
   * NOTE: The string arguments must provide space for up to 256 bytes.
   *
   * \param dev the device handle given by rtlsdr_open()
   * \param manufact manufacturer name, may be NULL
   * \param product product name, may be NULL
   * \param serial serial number, may be NULL
   * \return 0 on success
   */
  final int Function(Pointer<DeviceHandle> dev, Pointer<Utf8> manufact,
      Pointer<Utf8> product, Pointer<Utf8> serial) get_usb_strings;

  /**
   * Write the device EEPROM
   *
   * \param dev the device handle given by rtlsdr_open()
   * \param data buffer of data to be written
   * \param offset address where the data should be written
   * \param len length of the data
   * \return 0 on success
   * \return -1 if device handle is invalid
   * \return -2 if EEPROM size is exceeded
   * \return -3 if no EEPROM was found
   */
  final int Function(
          Pointer<DeviceHandle> dev, Pointer<Uint8> data, int offset, int len)
      write_eeprom;

  /**
   * Read the device EEPROM
   *
   * \param dev the device handle given by rtlsdr_open()
   * \param data buffer where the data should be written
   * \param offset address where the data should be read from
   * \param len length of the data
   * \return 0 on success
   * \return -1 if device handle is invalid
   * \return -2 if EEPROM size is exceeded
   * \return -3 if no EEPROM was found
   */
  final int Function(
          Pointer<DeviceHandle> dev, Pointer<Uint8> data, int offset, int len)
      read_eeprom;

  final int Function(Pointer<DeviceHandle> dev, int freq) set_center_freq;

  /**
   * Get actual frequency the device is tuned to.
   *
   * \param dev the device handle given by rtlsdr_open()
   * \return 0 on error, frequency in Hz otherwise
   */
  final int Function(Pointer<DeviceHandle> dev) get_center_freq;

  /**
   * Set the frequency correction value for the device.
   *
   * \param dev the device handle given by rtlsdr_open()
   * \param ppm correction value in parts per million (ppm)
   * \return 0 on success
   */
  final int Function(Pointer<DeviceHandle> dev, int ppm) set_freq_correction;

  /**
   * Get actual frequency correction value of the device.
   *
   * \param dev the device handle given by rtlsdr_open()
   * \return correction value in parts per million (ppm)
   */
  final int Function(Pointer<DeviceHandle> dev) get_freq_correction;

  /**
   * Get the tuner type.
   *
   * \param dev the device handle given by rtlsdr_open()
   * \return RTLSDR_TUNER_UNKNOWN on error, tuner type otherwise
   */
  final int Function(Pointer<DeviceHandle> dev) get_tuner_type;

  /**
   * Get a list of gains supported by the tuner.
   *
   * NOTE: The gains argument must be preallocated by the caller. If NULL is
   * being given instead, the number of available gain values will be returned.
   *
   * \param dev the device handle given by rtlsdr_open()
   * \param gains array of gain values. In tenths of a dB, 115 means 11.5 dB.
   * \return <= 0 on error, number of available (returned) gain values otherwise
   */
  final int Function(Pointer<DeviceHandle> dev, Pointer<IntPtr> gains)
      get_tuner_gains;

  /**
   * Set the gain for the device.
   * Manual gain mode must be enabled for this to work.
   *
   * Valid gain values (in tenths of a dB) for the E4000 tuner:
   * -10, 15, 40, 65, 90, 115, 140, 165, 190,
   * 215, 240, 290, 340, 420, 430, 450, 470, 490
   *
   * Valid gain values may be queried with \ref rtlsdr_get_tuner_gains function.
   *
   * \param dev the device handle given by rtlsdr_open()
   * \param gain in tenths of a dB, 115 means 11.5 dB.
   * \return 0 on success
   */
  final int Function(Pointer<DeviceHandle> dev, int gain) set_tuner_gain;

  /**
   * Set the bandwidth for the device.
   *
   * \param dev the device handle given by rtlsdr_open()
   * \param bw bandwidth in Hz. Zero means automatic BW selection.
   * \return 0 on success
   */
  final int Function(Pointer<DeviceHandle> dev, int bw) set_tuner_bandwidth;

  /**
   * Get actual gain the device is configured to.
   *
   * \param dev the device handle given by rtlsdr_open()
   * \return 0 on error, gain in tenths of a dB, 115 means 11.5 dB.
   */
  final int Function(Pointer<DeviceHandle> dev) get_tuner_gain;

  /**
   * Set the intermediate frequency gain for the device.
   *
   * \param dev the device handle given by rtlsdr_open()
   * \param stage intermediate frequency gain stage number (1 to 6 for E4000)
   * \param gain in tenths of a dB, -30 means -3.0 dB.
   * \return 0 on success
   */
  final int Function(Pointer<DeviceHandle> dev, int stage, int gain)
      set_tuner_if_gain;

  /**
   * Set the gain mode (automatic/manual) for the device.
   * Manual gain mode must be enabled for the gain setter function to work.
   *
   * \param dev the device handle given by rtlsdr_open()
   * \param manual gain mode, 1 means manual gain mode shall be enabled.
   * \return 0 on success
   */
  final int Function(Pointer<DeviceHandle> dev, int manual) set_tuner_gain_mode;

  final int Function(Pointer<DeviceHandle> dev, int rate) set_sample_rate;

  /**
   * Get actual sample rate the device is configured to.
   *
   * \param dev the device handle given by rtlsdr_open()
   * \return 0 on error, sample rate in Hz otherwise
   */
  final int Function(Pointer<DeviceHandle> dev) get_sample_rate;

  /**
   * Enable test mode that returns an 8 bit counter instead of the samples.
   * The counter is generated inside the RTL2832.
   *
   * \param dev the device handle given by rtlsdr_open()
   * \param test mode, 1 means enabled, 0 disabled
   * \return 0 on success
   */
  final int Function(Pointer<DeviceHandle> dev, int on) set_testmode;

  /**
   * Enable or disable the internal digital AGC of the RTL2832.
   *
   * \param dev the device handle given by rtlsdr_open()
   * \param digital AGC mode, 1 means enabled, 0 disabled
   * \return 0 on success
   */
  final int Function(Pointer<DeviceHandle> dev, int on) set_agc_mode;

  /**
   * Enable or disable the direct sampling mode. When enabled, the IF mode
   * of the RTL2832 is activated, and rtlsdr_set_center_freq() will control
   * the IF-frequency of the DDC, which can be used to tune from 0 to 28.8 MHz
   * (xtal frequency of the RTL2832).
   *
   * \param dev the device handle given by rtlsdr_open()
   * \param on 0 means disabled, 1 I-ADC input enabled, 2 Q-ADC input enabled
   * \return 0 on success
   */
  final int Function(Pointer<DeviceHandle> dev, int on) set_direct_sampling;

  /**
   * Get state of the direct sampling mode
   *
   * \param dev the device handle given by rtlsdr_open()
   * \return -1 on error, 0 means disabled, 1 I-ADC input enabled
   *      2 Q-ADC input enabled
   */
  final int Function(Pointer<DeviceHandle> dev) get_direct_sampling;

  /**
   * Enable or disable offset tuning for zero-IF tuners, which allows to avoid
   * problems caused by the DC offset of the ADCs and 1/f noise.
   *
   * \param dev the device handle given by rtlsdr_open()
   * \param on 0 means disabled, 1 enabled
   * \return 0 on success
   */
  final int Function(Pointer<DeviceHandle> dev, int on) set_offset_tuning;

  /**
   * Get state of the offset tuning mode
   *
   * \param dev the device handle given by rtlsdr_open()
   * \return -1 on error, 0 means disabled, 1 enabled
   */
  final int Function(Pointer<DeviceHandle> dev) get_offset_tuning;

  /* streaming functions */

  final int Function(Pointer<DeviceHandle> dev) reset_buffer;

  final int Function(Pointer<DeviceHandle> dev, Pointer<Uint8> buf, int len,
      Pointer<IntPtr> n_read) read_sync;

  /**
   * Read samples from the device asynchronously. This function will block until
   * it is being canceled using rtlsdr_cancel_async()
   *
   * \param dev the device handle given by rtlsdr_open()
   * \param cb callback function to return received samples
   * \param ctx user specific context to pass via the callback function
   * \param buf_num optional buffer count, buf_num * buf_len = overall buffer size
   *      set to 0 for default buffer count (32)
   * \param buf_len optional buffer length, must be multiple of 512,
   *      set to 0 for default buffer length (16 * 32 * 512)
   * \return 0 on success
   */
  final int Function(
      Pointer<DeviceHandle> dev,
      void Function(Pointer<Utf8> buf, int len, Pointer<Void> ctx) cb,
      Pointer<Void> ctx,
      int buf_num,
      int buf_len) read_async;

  /**
   * Cancel all pending asynchronous operations on the device.
   *
   * \param dev the device handle given by rtlsdr_open()
   * \return 0 on success
   */
  final int Function(Pointer<DeviceHandle> dev) cancel_async;

  /**
   * Enable or disable the bias tee on GPIO PIN 0.
   *
   * \param dev the device handle given by rtlsdr_open()
   * \param on  1 for Bias T on. 0 for Bias T off.
   * \return -1 if device is not initialized. 0 otherwise.
   */
  final int Function(Pointer<DeviceHandle> dev, int on) set_bias_tee;

  Bindings(this.rtlsdr)
      : get_device_count = rtlsdr
            .lookup<NativeFunction<rtlsdr_get_device_count>>(
                'rtlsdr_get_device_count')
            .asFunction(),
        get_device_name = rtlsdr
            .lookup<NativeFunction<rtlsdr_get_device_name>>(
                'rtlsdr_get_device_name')
            .asFunction(),
        get_device_usb_strings = rtlsdr
            .lookup<NativeFunction<rtlsdr_get_device_usb_strings>>(
                'rtlsdr_get_device_usb_strings')
            .asFunction(),
        get_index_by_serial = rtlsdr
            .lookup<NativeFunction<rtlsdr_get_index_by_serial>>(
                'rtlsdr_get_index_by_serial')
            .asFunction(),
        open = rtlsdr
            .lookup<NativeFunction<rtlsdr_open>>('rtlsdr_open')
            .asFunction(),
        close = rtlsdr
            .lookup<NativeFunction<rtlsdr_close>>('rtlsdr_close')
            .asFunction(),
        set_xtal_freq = rtlsdr
            .lookup<NativeFunction<rtlsdr_set_xtal_freq>>(
                'rtlsdr_set_xtal_freq')
            .asFunction(),
        get_xtal_freq = rtlsdr
            .lookup<NativeFunction<rtlsdr_get_xtal_freq>>(
                'rtlsdr_get_xtal_freq')
            .asFunction(),
        get_usb_strings = rtlsdr
            .lookup<NativeFunction<rtlsdr_get_usb_strings>>(
                'rtlsdr_get_usb_strings')
            .asFunction(),
        write_eeprom = rtlsdr
            .lookup<NativeFunction<rtlsdr_write_eeprom>>('rtlsdr_write_eeprom')
            .asFunction(),
        read_eeprom = rtlsdr
            .lookup<NativeFunction<rtlsdr_read_eeprom>>('rtlsdr_read_eeprom')
            .asFunction(),
        set_center_freq = rtlsdr
            .lookup<NativeFunction<rtlsdr_set_center_freq>>(
                'rtlsdr_set_center_freq')
            .asFunction(),
        get_center_freq = rtlsdr
            .lookup<NativeFunction<rtlsdr_get_center_freq>>(
                'rtlsdr_get_center_freq')
            .asFunction(),
        get_tuner_type = rtlsdr
            .lookup<NativeFunction<rtlsdr_get_tuner_type>>(
                'rtlsdr_get_tuner_type')
            .asFunction(),
        set_freq_correction = rtlsdr
            .lookup<NativeFunction<rtlsdr_set_freq_correction>>(
                'rtlsdr_set_freq_correction')
            .asFunction(),
        get_freq_correction = rtlsdr
            .lookup<NativeFunction<rtlsdr_get_freq_correction>>(
                'rtlsdr_get_freq_correction')
            .asFunction(),
        get_tuner_gains = rtlsdr
            .lookup<NativeFunction<rtlsdr_get_tuner_gains>>(
                'rtlsdr_get_tuner_gains')
            .asFunction(),
        set_tuner_gain = rtlsdr
            .lookup<NativeFunction<rtlsdr_set_tuner_gain>>(
                'rtlsdr_set_tuner_gain')
            .asFunction(),
        set_tuner_bandwidth = rtlsdr
            .lookup<NativeFunction<rtlsdr_set_tuner_bandwidth>>(
                'rtlsdr_set_tuner_bandwidth')
            .asFunction(),
        get_tuner_gain = rtlsdr
            .lookup<NativeFunction<rtlsdr_get_tuner_gain>>(
                'rtlsdr_get_tuner_gain')
            .asFunction(),
        set_tuner_if_gain = rtlsdr
            .lookup<NativeFunction<rtlsdr_set_tuner_if_gain>>(
                'rtlsdr_set_tuner_if_gain')
            .asFunction(),
        set_tuner_gain_mode = rtlsdr
            .lookup<NativeFunction<rtlsdr_set_tuner_gain_mode>>(
                'rtlsdr_set_tuner_gain_mode')
            .asFunction(),
        set_sample_rate = rtlsdr
            .lookup<NativeFunction<rtlsdr_set_sample_rate>>(
                'rtlsdr_set_sample_rate')
            .asFunction(),
        get_sample_rate = rtlsdr
            .lookup<NativeFunction<rtlsdr_get_sample_rate>>(
                'rtlsdr_get_sample_rate')
            .asFunction(),
        set_testmode = rtlsdr
            .lookup<NativeFunction<rtlsdr_set_testmode>>('rtlsdr_set_testmode')
            .asFunction(),
        set_agc_mode = rtlsdr
            .lookup<NativeFunction<rtlsdr_set_agc_mode>>('rtlsdr_set_agc_mode')
            .asFunction(),
        set_direct_sampling = rtlsdr
            .lookup<NativeFunction<rtlsdr_set_direct_sampling>>(
                'rtlsdr_set_direct_sampling')
            .asFunction(),
        get_direct_sampling = rtlsdr
            .lookup<NativeFunction<rtlsdr_get_direct_sampling>>(
                'rtlsdr_get_direct_sampling')
            .asFunction(),
        set_offset_tuning = rtlsdr
            .lookup<NativeFunction<rtlsdr_set_offset_tuning>>(
                'rtlsdr_set_offset_tuning')
            .asFunction(),
        get_offset_tuning = rtlsdr
            .lookup<NativeFunction<rtlsdr_get_offset_tuning>>(
                'rtlsdr_get_offset_tuning')
            .asFunction(),
        reset_buffer = rtlsdr
            .lookup<NativeFunction<rtlsdr_reset_buffer>>('rtlsdr_reset_buffer')
            .asFunction(),
        read_sync = rtlsdr
            .lookup<NativeFunction<rtlsdr_read_sync>>('rtlsdr_read_sync')
            .asFunction(),
        read_async = rtlsdr
            .lookup<NativeFunction<rtlsdr_read_async>>('rtlsdr_read_async')
            .asFunction(),
        cancel_async = rtlsdr
            .lookup<NativeFunction<rtlsdr_cancel_async>>('rtlsdr_cancel_async')
            .asFunction(),
        set_bias_tee = rtlsdr
            .lookup<NativeFunction<rtlsdr_set_bias_tee>>('rtlsdr_set_bias_tee')
            .asFunction();
}
