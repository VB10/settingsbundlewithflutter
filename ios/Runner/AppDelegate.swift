import Flutter
import UIKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
        registerDefaultsFromSettingsBundle()
        GeneratedPluginRegistrant.register(with: self)

        ConfigHostApiSetup.setUp(binaryMessenger: controller.binaryMessenger, api: NativeConfigImplementation())
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    private func registerDefaultsFromSettingsBundle() {
        guard let settingsUrl = Bundle.main.url(forResource: "Settings", withExtension: "bundle")?.appendingPathComponent("Root.plist")
        else { return }
        guard let settingsPlist = NSDictionary(contentsOf: settingsUrl) else { return }
        guard let preferences = settingsPlist["PreferenceSpecifiers"] as? [NSDictionary] else { return }

        var defaultsToRegister = [String: Any]()

        for preference in preferences {
            guard let key = preference["Key"] as? String else {
                NSLog("Key not found")
                continue
            }
            defaultsToRegister[key] = preference["DefaultValue"]
        }
        UserDefaults.standard.register(defaults: defaultsToRegister)
    }
}
