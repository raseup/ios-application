//
//  LandingPageMainViewController.swift
//  RASE
//
//  Created by Sam Beaulieu on 6/30/17.
//  Copyright © 2017 RASE. All rights reserved.
//

import UIKit

var pageControlGlobal: UIPageControl?

class LandingPageMainViewController: UIViewController {
    
    @IBOutlet weak var pageContainerView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.bringSubview(toFront: pageContainerView)
        view.bringSubview(toFront: pageControl)
        
        pageControl.numberOfPages = orderedViewControllers.count
        pageControl.currentPage = 0
        pageControlGlobal = pageControl
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
