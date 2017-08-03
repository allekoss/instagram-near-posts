//
//  UserViewController.swift
//  InstagramNearPosts
//
//  Created by Alejandro Jimenez Lopez on 8/1/17.
//  Copyright © 2017 allekoss. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    
    let apiController = ApiController(accessToken: AccessToken.get()!)

    override func viewDidLoad() {
        super.viewDidLoad()

        apiController.loadUser { (result: ApiController.Result<User>) in
            switch result {
            case .tokenExpired:
                print("token Expired")
            case .failure(let error):
                print(error)
            case .success(let user):
                print(user)
            }
        }
    }

}
