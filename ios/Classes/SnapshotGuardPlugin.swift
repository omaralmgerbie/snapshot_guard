import Flutter
import UIKit


public class SnapshotGuardPlugin: NSObject, FlutterPlugin {
    var hide:Bool = false;
    var field = UITextField()
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "snapshot_guard", binaryMessenger: registrar.messenger())
    let instance = SnapshotGuardPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
    registrar.addApplicationDelegate(instance)
      instance.addSecuredView()
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {

      if(call.method == "hideSnapshot" ){
          hide.toggle()
          field.isSecureTextEntry = hide
          result(hide)
          return
      }
    result("iOS " + UIDevice.current.systemVersion)
  }

    
    public func applicationWillResignActive(_ application: UIApplication) {
        if(hide){
            field.isSecureTextEntry = false
        }

    }

    public func applicationDidBecomeActive(_ application: UIApplication) {
        if(hide){
            field.isSecureTextEntry = true
        }

    }
    private func addSecuredView() {
        if let window = UIApplication.shared.delegate?.window as? UIWindow {
            if (!window.subviews.contains(field)) {
                window.addSubview(field)
                field.centerYAnchor.constraint(equalTo: window.centerYAnchor).isActive = true
                field.centerXAnchor.constraint(equalTo: window.centerXAnchor).isActive = true
                window.layer.superlayer?.addSublayer(field.layer)
                field.layer.sublayers?.first?.addSublayer(window.layer)
                debugPrint("something")
            }
        }
  
        
    }
}

