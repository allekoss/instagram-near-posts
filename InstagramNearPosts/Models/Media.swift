//
//  Media.swift
//  InstagramNearPosts
//
//  Created by Alejandro Jimenez Lopez on 8/2/17.
//  Copyright © 2017 allekoss. All rights reserved.
//

import Foundation
import ObjectMapper

// MARK: - Media

class Media: Mappable {
    
    // MARK: Properties
    var url: URL!
    var width: Int!
    var height: Int!
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        url <- (map["url"], URLTransform())
        width <- map["width"]
        height <- map["height"]
    }
}

// MARK: - Medias

class Medias: Mappable {
    
    // MARK: Properties
    var lowResolution: Media!
    var standardResolution: Media!
    var thumbnail: Media?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        lowResolution <- map["low_resolution"]
        standardResolution <- map["standard_resolution"]
        thumbnail <- map["thumbnail"]
    }
}
