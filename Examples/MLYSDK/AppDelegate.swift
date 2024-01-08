import MLYSDK
import UIKit

@objcMembers
class DemoConfig: NSObject {
    static var prod = DemoConfig(
        "cegh8d9j11u91ba1u600",
        "vsp.mlytics.com",
        "https://vsp-stream.s3.ap-northeast-1.amazonaws.com/HLS/raw/SpaceX.m3u8"
    )
    
    @objc
    static var defaultConfig = prod

    var id: String
    var server: String
    var url: String

    init(_ id: String, _ server: String, _ url: String) {
        self.id = id
        self.server = server
        self.url = url
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window?.rootViewController = UINavigationController(rootViewController: ViewController())
        window?.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(_: UIApplication) {}

    func applicationDidEnterBackground(_: UIApplication) {}

    func applicationWillEnterForeground(_: UIApplication) {}

    func applicationDidBecomeActive(_: UIApplication) {}

    func applicationWillTerminate(_: UIApplication) {}
}

extension UIDevice {
    static func statusBarHeight() -> CGFloat {
        var statusBarHeight: CGFloat = 0
        if #available(iOS 13.0, *) {
            let scene = UIApplication.shared.connectedScenes.first
            guard let windowScene = scene as? UIWindowScene else { return 0 }
            guard let statusBarManager = windowScene.statusBarManager else { return 0 }
            statusBarHeight = statusBarManager.statusBarFrame.height
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
        return statusBarHeight
    }

    static func navigationBarHeight() -> CGFloat {
        return 44.0
    }

    static func navigationFullHeight() -> CGFloat {
        return UIDevice.statusBarHeight() + UIDevice.navigationBarHeight()
    }

    static func tabBarHeight() -> CGFloat {
        return 49.0
    }
}

extension UIView {
    static func getScreenWidth() ->CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        return screenWidth
    }
    
    static func getScreenHeight() ->CGFloat {
        let screenWidth = UIScreen.main.bounds.height
        return screenWidth
    }
}
