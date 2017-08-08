//
//  SettingsController.swift
//  InstagramNearPosts
//
//  Created by Alejandro Jimenez Lopez on 8/4/17.
//  Copyright © 2017 allekoss. All rights reserved.
//

import Foundation

class SettingsController {
    
    static let minSearchRadius = 500
    static let maxSearchRadius = 5000
    
    fileprivate enum Keys: String {
        case searchRadius
        case isLoggedIn
    }
    
    fileprivate let defaults = UserDefaults.standard
    
    var isLoggedIn: Bool {
        get {
            return AccessToken.get() != nil
        }
    }
    
    var userToken: String? {
        get {
            return AccessToken.get()
        }
        set {
            guard let newToken = newValue else {
                _ = AccessToken.delete()
                return
            }
            _ = AccessToken.set(token: newToken)
        }
    }
    
    
    var searchRadius: Int {
        get {
            let radius = defaults.object(forKey: Keys.searchRadius.rawValue) as! Int
            return radius
        }
        set {
            let radiusClampped = max(SettingsController.minSearchRadius, min(newValue, SettingsController.maxSearchRadius))
            defaults.set(radiusClampped, forKey: Keys.searchRadius.rawValue)
        }
    }
    
    init() {
        defaults.register(defaults: [Keys.searchRadius.rawValue: SettingsController.minSearchRadius])
    }
}
