//
//  Post.swift
//  InstagramNearPosts
//
//  Created by Alejandro Jimenez Lopez on 8/2/17.
//  Copyright © 2017 allekoss. All rights reserved.
//

import Foundation
import ObjectMapper

class Post: Mappable {
    
    enum Category: String {
        case image
        case video
    }
    
    // MARK: Properties
    var id: String!
    var type: Category!
    var user: User!
    var caption: String?
    var comments: Int?
    var likes: Int?
    var images: Images!
    var videos: Videos?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        type <- (map["type"], EnumTransform())
        user <- map["user"]
        caption <- map["caption.text"]
        comments <- map["comments.count"]
        likes <- map["likes.count"]
        images <- map["images"]
        videos <- map["videos"]
    }
}
