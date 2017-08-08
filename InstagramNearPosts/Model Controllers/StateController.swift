//
//  StateController.swift
//  InstagramNearPosts
//
//  Created by Alejandro Jimenez Lopez on 8/5/17.
//  Copyright © 2017 allekoss. All rights reserved.
//

import Foundation

class StateController {
    
    fileprivate let storageController: StorageController
    
    init(storageController: StorageController) {
        self.storageController = storageController
    }
    
    var posts: [Post]? {
        get {
            return storageController.fetchPosts()
        }
        set {
            if let newPosts = newValue {
                storageController.save(newPosts)
            }
        }
    }
    
    var user: User? {
        get {
            return storageController.fetchUser()
        }
        set {
            if let newUserData = newValue {
                storageController.save(newUserData)
            }
        }
    }
    
}
