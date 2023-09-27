//
//  UserDefaultsManager.swift
//  How_is_the_weather
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import Foundation

final class UserDefaultsManager {
    static func setValue<T>(value: T, key: String) {
        UserDefaults.standard.setValue(value, forKey: key)
    }
    
    static func getValue<T>(key: String) -> T? {
        UserDefaults.standard.value(forKey: key) as? T
    }
}
