//
//  UserDefaultsManager.swift
//  shic
//
//  Created by Руслан Парастаев on 04.10.2024.
//

import Foundation

final class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    
    private var userDefaults: UserDefaults {
        if let userDefaults = UserDefaults(suiteName: "group.com.ruslanparastaev.shic") {
            return userDefaults
        } else {
            return UserDefaults.standard
        }
    }
    private var standart: UserDefaults = UserDefaults.standard
    
}
