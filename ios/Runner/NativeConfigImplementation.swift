//
//  NativeConfigImplementation.swift
//  Runner
//
//  Created by vb10 on 22.07.2023.
//

import Foundation

class NativeConfigImplementation: ConfigHostApi {
    let userDefault = UserDefaults.standard

    func userToken() throws -> String? {
        guard let userName = userDefault.value(forKey: SettingsKey.userName.rawValue) as? String else { return nil }

        return userName
    }

    func appEnvironment() throws -> IosAppData? {
        guard let enviroment = userDefault.value(forKey: SettingsKey.config.rawValue) as? String else { return nil }
        let resultType = AppEnviroment.fetchAppDataEnum(value: enviroment)
        
        guard resultType != nil else {
            return nil
        }
        
        return IosAppData(type: resultType!)
    }
}

private enum SettingsKey: String {
    case userName = "app_username"
    case config = "app_config"
}

private enum AppEnviroment: String {
    case prod
    case debug

    static func fetchAppDataEnum(value: String) -> IosAppEnvironment? {
        switch value {
            case AppEnviroment.prod.rawValue:
                return IosAppEnvironment.prod
            case AppEnviroment.debug.rawValue:
                return IosAppEnvironment.dev
            default:
                return nil
        }
    }
}
