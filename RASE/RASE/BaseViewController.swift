//
//  baseViewController.swift
//  RASE
//
//  Created by Sam Beaulieu on 7/2/17.
//  Copyright © 2017 RASE. All rights reserved.
//

import UIKit
import CoreData


class BaseViewController: UIViewController {
    
    let loggedIn = TabBarViewController(nibName: "TabBarViewController", bundle: nil)
    let notLoggedIn = LandingPageMainViewController(nibName: "LandingPageMainViewController", bundle: nil)
    var isLoggedIn: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Used for Logout
        let notificationName = Notification.Name("Logout")
        NotificationCenter.default.addObserver(self, selector: #selector(logout), name: notificationName, object: nil)
        
        
        self.addChildViewController(loggedIn)
        loggedIn.view.frame = self.view.frame

        self.addChildViewController(notLoggedIn)
        notLoggedIn.view.frame = self.view.frame
        
        // Check if anyone is logged in and load the correct view
        if let user = RASEDB.instance.getPrimaryUser() {
            isLoggedIn = true
            loggedIn.user = user
            self.view.addSubview(loggedIn.view)
            loggedIn.didMove(toParentViewController: self)
        }
        else {
            self.view.addSubview(notLoggedIn.view)
            notLoggedIn.didMove(toParentViewController: self)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Change from not logged in to logged in
        let user = RASEDB.instance.getPrimaryUser()
        if user == nil && !isLoggedIn {
            
            // Remove not logged in view
            notLoggedIn.view.removeFromSuperview()
            notLoggedIn.removeFromParentViewController()
            
            // Add logged in view
            isLoggedIn = true
            loggedIn.user = user
            self.view.addSubview(loggedIn.view)
            loggedIn.didMove(toParentViewController: self)
        }
        else if user != nil && isLoggedIn {
            
            // Remove logged in view
            loggedIn.view.removeFromSuperview()
            loggedIn.removeFromParentViewController()
            
            // Add not logged in view
            isLoggedIn = false
            self.view.addSubview(notLoggedIn.view)
            notLoggedIn.didMove(toParentViewController: self)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkForFeedback()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func logout(notification: NSNotification) {
        print("LOGOUT!")
    }

    
    func checkForFeedback() {
    
        // Check to see if it is time for the feedback loop
        // - First, make sure a user is logged in and has a workout
        /*
        guard let athlete = localDataManager.sharedInstance.localUser as? Athlete else { return }
        guard let work = athlete.currentWorkout else { return }
        
        // - Second, get the start date and current date for the workout
        let currentCalendar = Calendar.current
        guard let startCal = currentCalendar.ordinality(of: .day, in: .era, for: work.startDate) else {return}
        guard let endCal = currentCalendar.ordinality(of: .day, in: .era, for: Date()) else {return}
        
        // - Third, if its the end of the workout, push the feedback view
        if endCal - startCal == 7  {
            let vc = FeedbackViewController(nibName: "feedbackViewController", bundle: nil)
            self.present(vc, animated: true, completion: nil)
        }
        */
    }
}
