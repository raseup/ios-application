//
//  baseViewController.swift
//  RASE
//
//  Created by Sam Beaulieu on 7/2/17.
//  Copyright © 2017 RASE. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    @IBOutlet weak var NotLoggedInContainer: UIView!
    @IBOutlet weak var LoggedInContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
