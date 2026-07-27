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
      switch( call.method ){
      case "toggleGuard" : toggleGuard(result: result)
      case "switchGuardStatus" :
          let status = call.arguments! as? Bool ?? false
          switchGuardStatus(status: status, result:result)
      default : result( FlutterError(code:"INVALID_METHOD", message: "The method called is invalid", details: nil))
      }
  }
    
    private func switchGuardStatus(status: Bool, result: FlutterResult) {
            hide = status
        field.isSecureTextEntry = hide
        result(hide)
    }
    
    private func toggleGuard(result: FlutterResult) {
        hide.toggle()
        field.isSecureTextEntry = hide
        result(hide)
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
                let view = UIView(frame: CGRect(x: 0, y: 0, width: field.frame.self.width, height: field.frame.self.height))
                window.addSubview(field)
                window.layer.superlayer?.addSublayer(field.layer)
                field.layer.sublayers?.last!.addSublayer(window.layer)
                field.leftView = view
                field.leftViewMode = .always
            }
        }
  
        
    }
}

