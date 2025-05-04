import 'package:flutter_test/flutter_test.dart';
import 'package:screenshot_preventing_qr_code/screenshot_preventing_qr_code.dart';
import 'package:screenshot_preventing_qr_code/screenshot_preventing_qr_code_platform_interface.dart';
import 'package:screenshot_preventing_qr_code/screenshot_preventing_qr_code_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockScreenshotPreventingQrCodePlatform
    with MockPlatformInterfaceMixin
    implements ScreenshotPreventingQrCodePlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final ScreenshotPreventingQrCodePlatform initialPlatform = ScreenshotPreventingQrCodePlatform.instance;

  test('$MethodChannelScreenshotPreventingQrCode is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelScreenshotPreventingQrCode>());
  });

  test('getPlatformVersion', () async {
    ScreenshotPreventingQrCode screenshotPreventingQrCodePlugin = ScreenshotPreventingQrCode();
    MockScreenshotPreventingQrCodePlatform fakePlatform = MockScreenshotPreventingQrCodePlatform();
    ScreenshotPreventingQrCodePlatform.instance = fakePlatform;

    expect(await screenshotPreventingQrCodePlugin.getPlatformVersion(), '42');
  });
}
