//
//  State.swift
//  InstagramNearPosts
//
//  Created by Alejandro Jimenez Lopez on 8/5/17.
//  Copyright © 2017 allekoss. All rights reserved.
//

import Foundation

class State {
    let storageController = StorageController()
    let settingsController = SettingsController()
    let stateController: StateController
    let apiController: ApiController
    
    init() {
        stateController = StateController(storageController: storageController)
        apiController = ApiController(settingsController: settingsController)
    }
}

protocol Stateful: class {
    var stateController: StateController! { get set }
}

protocol SettingsConfigurable: class {
    var settingsController: SettingsController! { get set }
}

protocol ApiReachable: class {
    var apiController: ApiController! { get set }
}
