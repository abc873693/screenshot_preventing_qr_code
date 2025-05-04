import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'screenshot_preventing_qr_code_platform_interface.dart';

/// An implementation of [ScreenshotPreventingQrCodePlatform] that uses method channels.
class MethodChannelScreenshotPreventingQrCode extends ScreenshotPreventingQrCodePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('screenshot_preventing_qr_code');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
