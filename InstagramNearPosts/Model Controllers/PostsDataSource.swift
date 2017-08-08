//
//  PostsDataSource.swift
//  InstagramNearPosts
//
//  Created by Alejandro Jimenez Lopez on 8/5/17.
//  Copyright © 2017 allekoss. All rights reserved.
//

import UIKit

class PostsDataSource: NSObject {

    // MARK: Properties
    fileprivate let posts: [Post]
    
    init(posts: [Post]) {
        self.posts = posts
    }
    
    func post(at indexPath: IndexPath) -> Post {
        return posts[indexPath.row]
    }
    
}

extension PostsDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell") as! PostTableViewCell
        let post = self.post(at: indexPath)
        
        cell.userName = post.user.fullname ?? post.user.username
        cell.location = post.location
        cell.likes = "\(post.likes ?? 0)"
        cell.comments = "\(post.comments ?? 0)"
        cell.userProfileImageURL = post.user.profilePicture
        cell.type = post.type
        
        if post.type == .image {
            cell.postImageURL = post.images?.standardResolution.url
        }
        else if post.type == .video {
            cell.postImageURL = post.videos?.standardResolution.url
        }
        
        // This is for keeping the cell's shadows while scrolling down (https://stackoverflow.com/a/31831977/2213202)
        cell.layer.zPosition = CGFloat(indexPath.row)
        
        return cell
    }
    
}
