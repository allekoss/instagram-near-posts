//
//  User.swift
//  InstagramNearPosts
//
//  Created by Alejandro Jimenez Lopez on 7/31/17.
//  Copyright © 2017 allekoss. All rights reserved.
//

import Foundation
import ObjectMapper

class User: Mappable {
    
    // MARK: Properties
    var id: String!
    var username: String?
    var fullname: String?
    var profilePicture: URL?
    var bio: String?
    var website: String?
    var counts: Counts?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        username <- map["username"]
        fullname <- map["full_name"]
        profilePicture <- (map["profile_picture"], URLTransform())
        bio <- map["bio"]
        website <- map["website"]
        counts <- map["counts"]
    }
    
}

class Counts: Mappable {
    
    // MARK: Properties
    var media: Int?
    var follows: Int?
    var followedBy: Int?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        media <- map["media"]
        follows <- map["follows"]
        followedBy <- map["followedBy"]
    }
    
}
