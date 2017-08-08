//
//  StorageController.swift
//  InstagramNearPosts
//
//  Created by Alejandro Jimenez Lopez on 8/4/17.
//  Copyright © 2017 allekoss. All rights reserved.
//

import Foundation

class StorageController {
    fileprivate let cachesDirectoryURL = FileManager.default
        .urls(for: .cachesDirectory, in: .userDomainMask)
        .first!
    
    func save(_ posts: [Post]) {
        let questionsPlist = posts.map { $0.toJSON() } as NSArray
        questionsPlist.write(to: fileUrl(for: .posts), atomically: true)
    }
    
    func fetchPosts() -> [Post]? {
        guard let data = NSArray(contentsOf: fileUrl(for: .posts)) as? [[String: Any]] else {
            return nil
        }
        return data.map { Post(JSON: $0)! }
    }
    
    func save(_ user: User) {
        let userPlist = user.toJSON() as NSDictionary
        userPlist.write(to: fileUrl(for: .user), atomically: true)
    }
    
    func fetchUser() -> User? {
        guard let userEncoding = NSDictionary(contentsOf: fileUrl(for: .user)) as? [String: Any] else {
            let user = User(id: "0")
            user.fullname = "John Doe"
            user.bio = "I am the user of this app"
            return user
        }
        return User(JSON: userEncoding)
    }
}

private extension StorageController {
    enum Storage: String {
        case user
        case posts
    }
    
    func fileUrl(for storage: Storage) -> URL {
        return cachesDirectoryURL
            .appendingPathComponent(storage.rawValue)
            .appendingPathExtension("plist")
    }
}
