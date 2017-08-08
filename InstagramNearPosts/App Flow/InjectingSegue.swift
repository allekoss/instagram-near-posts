//
//  InjectingSegue.swift
//  InstagramNearPosts
//
//  Created by Alejandro Jimenez Lopez on 8/5/17.
//  Copyright © 2017 allekoss. All rights reserved.
//

import UIKit

class InjectingSegue: UIStoryboardSegue {
    override func perform() {
        destination.storyboard?.configure(viewController: destination)
        super.perform()
    }
}
