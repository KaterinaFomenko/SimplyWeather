//
//  UserSaving.swift
//  API_OpenWeather
//
//  Created by Катерина Фоменко on 27/09/2024.
//

import Foundation

enum UserSettingKey: String {
    case savedCity = "New name city"
    case defaltName1 = "London"
    case defaltName2 = "Rome"
}

class UserSaving {

    static let keyRecentCities = "RecentCities"
    
    static func saveParam(key: UserSettingKey, value: String) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    static func getParam(key: UserSettingKey) -> String {
        return UserDefaults.standard.string(forKey: key.rawValue) ?? ""
    }
    
    static func getRecentCities() -> [String] {
        UserDefaults.standard.stringArray(forKey: keyRecentCities) ?? []
    }
    
    static func saveRecentCities(_ array: [String]) {
        UserDefaults.standard.set(array, forKey: keyRecentCities)
    }
    
}
