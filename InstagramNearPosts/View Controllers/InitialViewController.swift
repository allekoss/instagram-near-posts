//
//  InitialViewController.swift
//  InstagramNearPosts
//
//  Created by Alejandro Jimenez Lopez on 7/31/17.
//  Copyright © 2017 allekoss. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if AccessToken.get() != nil {
            performSegue(withIdentifier: SegueNames.enterApp.rawValue, sender: self)
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueNames.enterLogin.rawValue {
            guard let navVC = segue.destination as? UINavigationController,
                let topVC = navVC.topViewController as? LoginViewController
                else {
                    return
            }
            
            topVC.delegate = self
        }
    }
    
}

extension InitialViewController: LoginViewControllerDelegate {
    
    func loginSuccessful() {
        dismiss(animated: true, completion: nil)
    }
    
    func loginFail() {
        dismiss(animated: true, completion: nil)
        print("Error while getting the token")
    }
    
    func loginCancel() {
        dismiss(animated: true, completion: nil)
    }
    
}
