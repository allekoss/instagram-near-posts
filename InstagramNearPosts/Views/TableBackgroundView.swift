//
//  TableBackgroundView.swift
//  InstagramNearPosts
//
//  Created by Alejandro Jimenez Lopez on 8/8/17.
//  Copyright © 2017 allekoss. All rights reserved.
//

import UIKit

class TableBackgroundView: UIView {
    
    // MARK: IBOutlets

    @IBOutlet fileprivate weak var infoLabel: UILabel!
    
    // MARK: Properties
    
    var info = "" {
        didSet {
            infoLabel.text = info
        }
    }
    
    // MARK: Helpers
    
    static func instanceFromNib() -> TableBackgroundView {
        let nibName = String(describing: TableBackgroundView.self)
        let view = UINib(nibName: nibName, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! TableBackgroundView
        return view
    }

}
