//
//  NetworkActivityIndicator.swift
//  InstagramNearPosts
//
//  Created by Alejandro Jimenez Lopez on 8/7/17.
//  Copyright © 2017 allekoss. All rights reserved.
//

import UIKit

class NetworkActivityIndicator: NSObject {
    
    static let shared = NetworkActivityIndicator()
    
    internal var activitiesCount = 0
    
    var visible: Bool = false {
        didSet {
            if visible {
                self.activitiesCount += 1
            } else {
                self.activitiesCount -= 1
            }
            
            if self.activitiesCount < 0 {
                self.activitiesCount = 0
            }
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = (self.activitiesCount > 0)
        }
    }
}
