//
//  PostsViewController.swift
//  InstagramNearPosts
//
//  Created by Alejandro Jimenez Lopez on 8/2/17.
//  Copyright © 2017 allekoss. All rights reserved.
//

import UIKit

class PostsViewController: UIViewController {
    
    let apiController = ApiController(accessToken: AccessToken.get()!)

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let searchAreaMiami = ApiController.CircularArea(lat: 25.776842, lng: -80.188635, distance: 5000)
        let searchAreaQuito = ApiController.CircularArea(lat: -0.186393, lng: -78.481756, distance: 5000)
        
        apiController.loadPosts(searchArea: searchAreaQuito) { (result: ApiController.Result<[Post]>) in
            switch result {
            case .tokenExpired:
                print("token Expired")
            case .failure(let error):
                print(error)
            case .success(let posts):
                print(posts)
            }
        }
    }

}
