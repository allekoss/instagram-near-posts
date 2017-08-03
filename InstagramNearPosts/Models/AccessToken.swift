//
//  AccessToken.swift
//  InstagramNearPosts
//
//  Created by Alejandro Jimenez Lopez on 8/1/17.
//  Copyright © 2017 allekoss. All rights reserved.
//

import Foundation
import KeychainSwift

class AccessToken {
    
    fileprivate static let tokenKey = "com.allekoss.InstagramNearPosts.AccessToken"
    fileprivate static let keyChain = KeychainSwift()
    
    private init() {
    }
    
    static func get() -> String? {
        return keyChain.get(tokenKey)
    }
    
    static func set(token: String) -> Bool {
        return keyChain.set(token, forKey: tokenKey)
    }
    
    static func delete() -> Bool {
        return keyChain.delete(tokenKey)
    }
    
}
