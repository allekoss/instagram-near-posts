//
//  LoginViewController.swift
//  InstagramNearPosts
//
//  Created by Alejandro Jimenez Lopez on 8/1/17.
//  Copyright © 2017 allekoss. All rights reserved.
//

import UIKit
import WebKit
import Alamofire

class LoginViewController: UIViewController, SettingsConfigurable {
    
    // MARK: Properties
    
    var settingsController: SettingsController!
    var webView: WKWebView!
    
    // MARK: Life Cycle
    
    override func loadView() {
        let config = WKWebViewConfiguration()
        config.websiteDataStore = WKWebsiteDataStore.nonPersistent() //This allows to show the login page again, once the token expired.
        
        webView = WKWebView(frame: .zero, configuration: config)
        webView.navigationDelegate = self
        
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var parameters = [String: String]()
        parameters["client_id"] = "e091762ad38d432893f29c6009edad09"
        parameters["redirect_uri"] = "https://www.linkedin.com/in/allekoss/"
        parameters["response_type"] = "token"
        parameters["scope"] = "public_content"
        
        let baseUrl = URL(string: "https://api.instagram.com/oauth/authorize")!
        let baseRequest = URLRequest(url: baseUrl)
        let request = try! URLEncoding.default.encode(baseRequest, with: parameters)
        
        webView.load(request)
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
                
                settingsController.userToken = accessToken
                
                if settingsController.isLoggedIn {
                    performSegue(withIdentifier: Segues.loginSuccess, sender: self)
                }
                else {
                    performSegue(withIdentifier: Segues.loginError, sender: self)
                }
            }
        }
    }
    
}
