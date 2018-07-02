//
//  TabBarViewController.swift
//  RASE
//
//  Created by Sam Beaulieu on 9/18/17.
//  Copyright © 2017 RASE. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    var user: User!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Removes the titles and sets the positions of the tab bar pictures
        if self.tabBar.items != nil {
            for each in self.tabBar.items! {
                each.title = nil
                each.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)
            }
        }
    }
}
