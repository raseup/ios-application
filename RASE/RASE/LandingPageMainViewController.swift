//
//  LandingPageMainViewController.swift
//  RASE
//
//  Created by Sam Beaulieu on 6/30/17.
//  Copyright © 2017 RASE. All rights reserved.
//

import UIKit
import CoreData

class LandingPageMainViewController: UIViewController {
    
    @IBOutlet weak var pageContainerView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var raseIcon: UIImageView!
    @IBOutlet weak var raseIconWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var joinNowButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var buttonSeperator: UILabel!
    
    var vc: LandingPageViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create page view and initialize
        vc = LandingPageViewController(nibName: "LandingPageViewController", bundle: nil)
        self.addChildViewController(vc)
        self.view.addSubview(vc.view)
        vc.didMove(toParentViewController: self)
        
        // Arranges landing page view properly
        view.bringSubview(toFront: pageControl)
        view.bringSubview(toFront: raseIcon)
        
        // Prepares the swiping view controller
        vc.pageControl = self.pageControl
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Adjust the icon's size on load
        vc.view.frame = pageContainerView.frame
        raseIconWidthConstraint.constant = UIScreen.main.bounds.width / 3
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Segue to the create account view controller
    @IBAction func joinNowSelected(_ sender: Any) {
        let joinVC = NewAthleteViewController(nibName: "NewAthleteViewController", bundle: nil)
        joinVC.background = getBackgroundImage()
        self.present(joinVC, animated: true, completion: nil)
    }
    
    // Segue to the login view controller
    @IBAction func loginSelected(_ sender: Any) {
        let loginVC = LoginViewController(nibName: "LoginViewController", bundle: nil)
        loginVC.background = getBackgroundImage()
        self.present(loginVC, animated: true, completion: nil)
    }
    
    // Create an image of the current background
    func getBackgroundImage() -> UIImage {
        raseIcon.isHidden = true
        UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, true, 1)
        self.view.drawHierarchy(in: self.view.bounds, afterScreenUpdates: true)
        let screen = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        raseIcon.isHidden = false
        return screen!
    }
}
