//
//  LandingPageMainViewController.swift
//  RASE
//
//  Created by Sam Beaulieu on 6/30/17.
//  Copyright © 2017 RASE. All rights reserved.
//

import UIKit

class LandingPageMainViewController: UIViewController {
    
    @IBOutlet weak var pageContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.bringSubview(toFront: pageContainerView)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
