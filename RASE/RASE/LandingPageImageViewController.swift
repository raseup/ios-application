//
//  LandingPageImageViewController.swift
//  RASE
//
//  Created by Sam Beaulieu on 3/24/18.
//  Copyright © 2018 RASE. All rights reserved.
//

import UIKit

class LandingPageImageViewController: UIViewController {

    @IBOutlet weak var backgroundImage: UIImageView!
    
    var background: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backgroundImage.image = background
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
