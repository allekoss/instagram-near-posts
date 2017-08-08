//
//  PostsViewController.swift
//  InstagramNearPosts
//
//  Created by Alejandro Jimenez Lopez on 8/2/17.
//  Copyright © 2017 allekoss. All rights reserved.
//

import UIKit
import Permission
import CoreLocation

class PostsViewController: UIViewController, Stateful, SettingsConfigurable, ApiReachable {
    
    // MARK: IBOutlets
    
    @IBOutlet fileprivate weak var tableView: UITableView!
    
    // MARK: Properties
    
    var stateController: StateController!
    var settingsController: SettingsController!
    var apiController: ApiController!
    
    var postsDataSource: PostsDataSource!
    
    let locationPermission: Permission = {
        var permission: Permission = Permission.locationWhenInUse
        
        let deniedAlert = permission.deniedAlert
        deniedAlert.title    = "Please allow access to your location"
        deniedAlert.message  = nil
        deniedAlert.cancel   = "Cancel"
        deniedAlert.settings = "Settings"
        
        permission.presentPrePermissionAlert = true
        let prePermissionAlert = permission.prePermissionAlert
        prePermissionAlert.title   = "Let Near Posts access your location?"
        prePermissionAlert.message = "This allows you to browse recent posts near your current location."
        prePermissionAlert.cancel  = "Not Now"
        prePermissionAlert.confirm = "Give Access"
        
        return permission
    }()
    
    lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        return manager
    }()
    
    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let cachedPosts = stateController.posts {
            updateDataSource(withPosts: cachedPosts)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tryToFetchPostsWithLocation()
    }

}

private extension PostsViewController {
    
    func configureTableView() {
        tableView.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "postCell")
        tableView.estimatedRowHeight = 360
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func updateDataSource(withPosts posts: [Post]) {
        postsDataSource = PostsDataSource(posts: posts)
        tableView.dataSource = postsDataSource
        tableView.reloadData()
    }
    
    func fetchPosts(latitude: Double, longitude: Double, distance: Int) {
//        let searchArea = ApiController.CircularArea(lat: 25.776842, lng: -80.188635, distance: 500) //Miami
//        let searchArea = ApiController.CircularArea(lat: -0.186393, lng: -78.481756, distance: 5000) //Quito
        
        let searchArea = ApiController.CircularArea(lat: latitude, lng: longitude, distance: distance)
        
        NetworkActivityIndicator.shared.visible = true
        apiController.loadPosts(searchArea: searchArea) { [weak self] (result: ApiController.Result<[Post]>) in
            NetworkActivityIndicator.shared.visible = false
            
            switch result {
            case .tokenExpired:
                self?.performSegue(withIdentifier: Segues.tokenExpired, sender: self)
            case .failure(let error):
                print(error)
                self?.showTableBackgroundViewIfNeeded(info: "There was an error while trying to fetch the data from the service.")
            case .success(let posts):
                if posts.count > 0 {
                    self?.stateController.posts = posts
                    self?.updateDataSource(withPosts: posts)
                    self?.hideTableBackgroundView()
                }
                else {
                    let newRadius = distance + 500
                    if newRadius <= SettingsController.maxSearchRadius {
                        self?.fetchPosts(latitude: latitude, longitude: longitude, distance: newRadius)
                    }
                    else {
                        self?.showTableBackgroundViewIfNeeded(info: "There are no post to show.")
                    }
                }
            }
        }
    }
    
    func tryToFetchPostsWithLocation() {
        locationPermission.request { [weak self] (status) in
            switch status {
            case .authorized:
                self?.locationManager.startUpdatingLocation()
                return
            case .denied:        print("denied")
            case .disabled:      print("disabled")
            case .notDetermined: print("not determined")
            }
            
            self?.showTableBackgroundViewIfNeeded(info: "You need to allow access to obtain your current location.")
        }
    }
    
    func getTableBackgroundView(info: String) -> TableBackgroundView {
        let bgView = TableBackgroundView.instanceFromNib()
        bgView.info = info
        return bgView
    }
    
    func showTableBackgroundViewIfNeeded(info: String) {
        let count = stateController.posts?.count ?? 0
        
        if count == 0 {
            tableView.backgroundView = getTableBackgroundView(info: info)
        }
    }
    
    func hideTableBackgroundView() {
        tableView.backgroundView = nil
    }
    
}

extension PostsViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        
        let currentLocation = locations.last!
        let lat = currentLocation.coordinate.latitude
        let lng = currentLocation.coordinate.longitude
        
        fetchPosts(latitude: lat, longitude: lng, distance: settingsController.searchRadius)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
    
}


