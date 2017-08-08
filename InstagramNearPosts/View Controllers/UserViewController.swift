//
//  UserViewController.swift
//  InstagramNearPosts
//
//  Created by Alejandro Jimenez Lopez on 8/1/17.
//  Copyright © 2017 allekoss. All rights reserved.
//

import UIKit
import AlamofireImage

class UserViewController: UIViewController, Stateful, ApiReachable {
    
    // MARK: IBOutlets
    
    @IBOutlet fileprivate weak var userProfileImageView: BorderImage!
    @IBOutlet fileprivate weak var postsLabel: UILabel!
    @IBOutlet fileprivate weak var followersLabel: UILabel!
    @IBOutlet fileprivate weak var followingLabel: UILabel!
    @IBOutlet fileprivate weak var usernameLabel: UILabel!
    @IBOutlet fileprivate weak var bioLabel: UILabel!
    @IBOutlet fileprivate weak var webPageButton: UIButton!
    
    // MARK: Properties
    
    var stateController: StateController!
    var settingsController: SettingsController!
    var apiController: ApiController!
    
    fileprivate let userProfilePlaceholderImage: UIImage = {
        let img = UIImage(named: "instagram-user-image")!
        return img
    }()
    
    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let cachedUser = stateController?.user {
            updateUI(with: cachedUser)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchUser()
    }

}

private extension UserViewController {
    
    func fetchUser() {
        NetworkActivityIndicator.shared.visible = true
        apiController.loadUser { [weak self] (result: ApiController.Result<User>) in
            NetworkActivityIndicator.shared.visible = false
            
            switch result {
            case .tokenExpired:
                self?.performSegue(withIdentifier: Segues.tokenExpired, sender: self)
            case .failure(let error):
                print(error)
            case .success(let user):
                self?.stateController.user = user
                self?.updateUI(with: user)
            }
        }
    }
    
    func updateUI(with user: User) {
        if let userProfileUrl = user.profilePicture {
            userProfileImageView.af_setImage(withURL: userProfileUrl, placeholderImage: userProfilePlaceholderImage)
        }
        else {
            userProfileImageView.image = userProfilePlaceholderImage
        }
        
        usernameLabel.text = user.fullname ?? user.username
        bioLabel.text = user.bio
        webPageButton.setTitle(user.website, for: .normal)
        
        if let counts = user.counts {
            postsLabel.text = "\(counts.media ?? 0)"
            followersLabel.text = "\(counts.followedBy ?? 0)"
            followingLabel.text = "\(counts.follows ?? 0)"
        }
    }
    
}


