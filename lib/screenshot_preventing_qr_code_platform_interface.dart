import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'screenshot_preventing_qr_code_method_channel.dart';

abstract class ScreenshotPreventingQrCodePlatform extends PlatformInterface {
  /// Constructs a ScreenshotPreventingQrCodePlatform.
  ScreenshotPreventingQrCodePlatform() : super(token: _token);

  static final Object _token = Object();

  static ScreenshotPreventingQrCodePlatform _instance = MethodChannelScreenshotPreventingQrCode();

  /// The default instance of [ScreenshotPreventingQrCodePlatform] to use.
  ///
  /// Defaults to [MethodChannelScreenshotPreventingQrCode].
  static ScreenshotPreventingQrCodePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ScreenshotPreventingQrCodePlatform] when
  /// they register themselves.
  static set instance(ScreenshotPreventingQrCodePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
