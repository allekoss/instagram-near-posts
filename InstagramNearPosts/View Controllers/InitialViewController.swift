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
    
    fileprivate var loginError = false
    fileprivate var tokenExpired = false
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if loginError {
            loginError = false
            showAlertInfo(title: "Log In", message: "There was an error while logging in.")
            return
        }
        
        if tokenExpired {
            tokenExpired = false
            showAlertInfo(title: "Access token", message: "It seems your token expired or was revoked.")
            return
        }
        
        if settingsController.isLoggedIn {
            performSegue(withIdentifier: Segues.enterApp, sender: self)
        }
    }
    
    // MARK: - Navigation
    
    @IBAction func showInitialScreen(segue: UIStoryboardSegue) {}
    
    @IBAction func loginError(segue: UIStoryboardSegue) {
        loginError = true
    }
    
    @IBAction func tokenExpired(segue: UIStoryboardSegue) {
        _ = AccessToken.delete()
        tokenExpired = true
    }
    
}

private extension InitialViewController {
    
    func showAlertInfo(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
    
}
