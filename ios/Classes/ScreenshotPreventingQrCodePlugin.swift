import Flutter
import UIKit
import SwiftUI
import ScreenshotPreventing
import CoreImage.CIFilterBuiltins

public class ScreenshotPreventingQrCodePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "screenshot_preventing_qr_code", binaryMessenger: registrar.messenger())
    let instance = ScreenshotPreventingQrCodePlugin()
    let factory = FlutterViewFactory(messenger: registrar.messenger())
    registrar.register(factory, withId: "screenshot_preventing_qr_code_widget")
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}

class FlutterViewFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger

    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }

    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return FLNativeView(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args,
            binaryMessenger: messenger)
    }

    /// Implementing this method is only necessary when the `arguments` in `createWithFrame` is not `nil`.
    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
          return FlutterStandardMessageCodec.sharedInstance()
    }
}

class FLNativeView: NSObject, FlutterPlatformView {
    private var _view: UIView


    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?
    ) {
        _view = UIView()
        super.init()
        // iOS views can be created here
        createNativeView(view: _view, arguments: args)
    }

    func view() -> UIView {
        return _view
    }

    func createNativeView(
        view _view: UIView,
        arguments args: Any?
    ){
        
        if let params = args as? [String: Any] {
          var data = params["data"] as! String
          var height = params["height"] as! Double
          var width = params["width"] as! Double
            
          let keyWindows = UIApplication.shared.windows.first(where: { $0.isKeyWindow}) ?? UIApplication.shared.windows.first
          let topController = keyWindows?.rootViewController
          var child = UIHostingController(rootView: ContentView(
              from: data,
              height: height,
              width: width
          ))
          child.view.translatesAutoresizingMaskIntoConstraints = false
          topController?.addChild(child)
          _view.addSubview(child.view)
          NSLayoutConstraint.activate(
            [
                child.view.leadingAnchor.constraint(equalTo: _view.leadingAnchor),
                child.view.trailingAnchor.constraint(equalTo: _view.trailingAnchor),
                child.view.topAnchor.constraint(equalTo: _view.topAnchor),
                child.view.bottomAnchor.constraint(equalTo:  _view.bottomAnchor)
            ])
  //        child.view!.didMove(toParent: topController)
        }
    }
}
struct ContentView: View {

    @State private var preventScreenshot = true
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()

    var from: String
    var height: CGFloat
    var width: CGFloat

    var body: some View {
        Image(uiImage: generateQRCode(from: from))
            .resizable()
            .scaledToFit()
            .frame(width: width, height: height)
            .screenshotProtected(isProtected: preventScreenshot)
    }

    func generateQRCode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)

        if let outputImage = filter.outputImage {
            let transform = CGAffineTransform(scaleX: 10, y: 10)
            let scaledImage = outputImage.transformed(by: transform)

            if let cgImage = context.createCGImage(scaledImage, from: scaledImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }

        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}
