//
//  LoginViewController.swift
//  InstagramNearPosts
//
//  Created by Alejandro Jimenez Lopez on 8/1/17.
//  Copyright © 2017 allekoss. All rights reserved.
//

import UIKit
import WebKit

protocol LoginViewControllerDelegate {
    func loginSuccessful()
    func loginFail()
    func loginCancel()
}

class LoginViewController: UIViewController {
    
    // MARK: Properties
    
    var webView: WKWebView!
    var delegate: LoginViewControllerDelegate?
    
    // MARK: Life Cycle
    
    override func loadView() {
        let config = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: config)
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let clientID = "e091762ad38d432893f29c6009edad09"
        let redirectUrl = "https://www.linkedin.com/in/allekoss/"
        
        let authUrl = URL(string: "https://api.instagram.com/oauth/authorize/?client_id=\(clientID)&redirect_uri=\(redirectUrl)&response_type=token&scope=public_content")
        let myRequest = URLRequest(url: authUrl!)
        webView.load(myRequest)
    }
    
    // MARK: IBActions
    
    @IBAction func dismissViewController(sender: UIBarButtonItem) {
        delegate?.loginCancel()
    }

}

extension LoginViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let responseUrl = navigationResponse.response.url else {
            decisionHandler(.cancel)
            return
        }
        
        if responseUrl.absoluteString.contains("instagram.com") {
            decisionHandler(.allow)
        }
        else {
            decisionHandler(.cancel)
            
            let accessTokenParamName = "access_token"
            let urlSplitted = responseUrl.absoluteString.components(separatedBy: accessTokenParamName)
            
            if urlSplitted.count == 2 { //The access token is present in the URL
                var accessToken = urlSplitted[1]
                accessToken.remove(at: accessToken.startIndex)
                
                if AccessToken.set(token: accessToken) {
                    delegate?.loginSuccessful()
                }
                else {
                    delegate?.loginFail()
                }
            }
        }
    }
    
}
