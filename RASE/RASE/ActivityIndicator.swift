//
//  ActivitySpinner.swift
//  RASE
//
//  Created by Sam Beaulieu on 8/19/17.
//  Copyright © 2017 RASE. All rights reserved.
//

import UIKit

class ActivityIndicator {
    
    let spinner: RaseSpinner = RaseSpinner()
    var progressContainer: UIView = UIView()
    var progressContainerActive: Bool = false
    var viewController: UIViewController!
    
    init(viewController: UIViewController) {
        
        self.viewController = viewController
        
        // create greyed out foreground
        progressContainer.frame = viewController.view.frame
        progressContainer.center = viewController.view.center
        progressContainer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha:0.3)
        
        // format spinner
        spinner.frame = CGRect(x: 0.0, y: 0.0, width: 75.0, height: 75.0)
        spinner.center = viewController.view.center
        spinner.isAnimating = false
    }
    
    // Add the spinner and start the animation
    func startAnimator() {
        
        // If the spinner is not spinning and it's told to, add the views and start spinning
        if !spinner.isAnimating {
            
            // Add the progress container
            viewController.view.addSubview(progressContainer)
            viewController.view.bringSubview(toFront: progressContainer)
            progressContainerActive = true
            
            // Add the spinner
            viewController.view.addSubview(spinner)
            viewController.view.bringSubview(toFront: spinner)
            
            // Start the animation
            spinner.isAnimating = true
        }
    }
    
    // Remove just the spinner and leave the background
    func removeSpinner() {
        
        // If the spinner is spinning, stop it
        if spinner.isAnimating {
            spinner.removeFromSuperview()
            spinner.isAnimating = false
        }
    }
    
    // Remove the grayed out background
    func removeBackground() {
        if !spinner.isAnimating && progressContainerActive{
            progressContainer.removeFromSuperview()
            progressContainerActive = false
        }
    }
    
    // Remove the spinner and background
    func removeIndicator() {
        if spinner.isAnimating && progressContainerActive {
            spinner.removeFromSuperview()
            spinner.isAnimating = false
            progressContainer.removeFromSuperview()
            progressContainerActive = false
        }
    }
}
