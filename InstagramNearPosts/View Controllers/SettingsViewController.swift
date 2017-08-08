//
//  SettingsViewController.swift
//  InstagramNearPosts
//
//  Created by Alejandro Jimenez Lopez on 8/7/17.
//  Copyright © 2017 allekoss. All rights reserved.
//

import UIKit
import Eureka

class SettingsViewController: FormViewController, SettingsConfigurable {
    
    // MARK: Properties
    
    var settingsController: SettingsController!
    
    fileprivate let SearchRadiusSliderRowTag = "SearchRadiusSlider"
    
    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        form +++ SliderRow() { row in
            row.tag = SearchRadiusSliderRowTag
            row.title = "Search Radius"
            row.minimumValue = Float(SettingsController.minSearchRadius)
            row.maximumValue = Float(SettingsController.maxSearchRadius)
            row.steps = 100
            row.value = Float(settingsController.searchRadius)
        }
    }
    
    // MARK: IBActions
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveSettings(_ sender: UIBarButtonItem) {
        let searchRadiusRow = form.rowBy(tag: SearchRadiusSliderRowTag) as! SliderRow
        settingsController.searchRadius = Int(searchRadiusRow.value!)
        dismiss(animated: true, completion: nil)
    }

}
