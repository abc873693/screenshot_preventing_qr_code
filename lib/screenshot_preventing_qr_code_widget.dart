import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class ScreenshotPreventingQrCodeWidget extends StatelessWidget {
  const ScreenshotPreventingQrCodeWidget({
    super.key,
    required this.data,
    this.errorCorrectionLevel = 'M',
    this.height = 300.0,
    this.width = 300.0,
  });

  final String data;
  final String errorCorrectionLevel;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    const String viewType = 'screenshot_preventing_qr_code_widget';
    final Map<String, dynamic> creationParams = <String, dynamic>{
      'data': data,
      'errorCorrectionLevel': errorCorrectionLevel,
      'height': height,
      'width': width,
    };
    return UiKitView(
      key: ValueKey('$data-$errorCorrectionLevel-$height-$width'),
      viewType: viewType,
      layoutDirection: TextDirection.ltr,
      creationParams: creationParams,
      creationParamsCodec: const StandardMessageCodec(),
    );
  }
}
