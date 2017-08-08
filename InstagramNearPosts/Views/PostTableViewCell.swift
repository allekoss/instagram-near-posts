//
//  PostTableViewCell.swift
//  InstagramNearPosts
//
//  Created by Alejandro Jimenez Lopez on 8/3/17.
//  Copyright © 2017 allekoss. All rights reserved.
//

import UIKit
import AlamofireImage

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet fileprivate weak var userProfileImageView: BorderImage!
    @IBOutlet fileprivate weak var userNameLabel: UILabel!
    @IBOutlet fileprivate weak var locationLabel: UILabel!
    @IBOutlet fileprivate weak var mediaImageView: UIImageView!
    @IBOutlet fileprivate weak var likesLabel: UILabel!
    @IBOutlet fileprivate weak var commentsLabel: UILabel!
    @IBOutlet fileprivate weak var likesImageView: UIImageView!
    @IBOutlet fileprivate weak var commentsImageView: UIImageView!
    @IBOutlet fileprivate weak var playImageView: UIImageView!
    
    fileprivate static let userProfilePlaceholderImage: UIImage = {
        let img = UIImage(named: "user-profile-placeholder")!
        return img
    }()
    
    fileprivate static let postPlaceholderImage: UIImage = {
        let img = UIImage(named: "post-image-placeholder")!
        return img
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // This is for applying the tintColor, since from the Storyboard didn't work (https://stackoverflow.com/a/43524192/2213202 & https://stackoverflow.com/a/44831281/2213202)
        likesImageView.tintColor = .lightGray
        commentsImageView.tintColor = .lightGray
        playImageView.tintColor = .white
    }
    
    var userName: String = "" {
        didSet {
            userNameLabel.text = userName
        }
    }
    
    var location: String? {
        didSet {
            locationLabel.text = location
        }
    }
    
    var likes: String? {
        didSet {
            likesLabel.text = likes ?? "0"
        }
    }
    
    var comments: String? {
        didSet {
            commentsLabel.text = comments ?? "0"
        }
    }
    
    var userProfileImageURL: URL? {
        didSet {
            guard let image = userProfileImageURL else {
                userProfileImageView.image = PostTableViewCell.userProfilePlaceholderImage
                return
            }
            userProfileImageView.af_setImage(withURL: image, placeholderImage: PostTableViewCell.userProfilePlaceholderImage)
        }
    }
    
    var postImageURL: URL? {
        didSet {
            guard let image = postImageURL else {
                mediaImageView.image = PostTableViewCell.postPlaceholderImage
                return
            }
            mediaImageView.af_setImage(withURL: image, placeholderImage: PostTableViewCell.postPlaceholderImage)
        }
    }
    
    var type: Post.Category! {
        didSet {
            playImageView.isHidden = (type == .image)
        }
    }
    
}
