//
//  InitialViewController.swift
//  InstagramNearPosts
//
//  Created by Alejandro Jimenez Lopez on 7/31/17.
//  Copyright © 2017 allekoss. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController, SettingsConfigurable {
    
    // MARK: - Properties
    
    var settingsController: SettingsController!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if settingsController.isLoggedIn {
            performSegue(withIdentifier: Segues.enterApp, sender: self)
        }
    }
    
    // MARK: - Navigation
    
    @IBAction func showInitialScreen(segue: UIStoryboardSegue) {}
    
    @IBAction func loginError(segue: UIStoryboardSegue) {
        // TODO: show an error message to the user
        print("There was an error while logging in.")
    }
    
    @IBAction func tokenExpired(segue: UIStoryboardSegue) {
        // TODO: show an information message to the user
        _ = AccessToken.delete()
        print("It seems your token expired or was revoked.")
    }
    
}
