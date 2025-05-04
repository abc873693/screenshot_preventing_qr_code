
import 'screenshot_preventing_qr_code_platform_interface.dart';

class ScreenshotPreventingQrCode {
  Future<String?> getPlatformVersion() {
    return ScreenshotPreventingQrCodePlatform.instance.getPlatformVersion();
  }
}
