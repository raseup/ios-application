//
//  DashboardViewController.swift
//  RASE
//
//  Created by Sam Beaulieu on 6/12/17.
//  Copyright © 2017 RASE. All rights reserved.
//

import UIKit

/*
class HomeViewModel: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var reloadSections: ((_ section: Int) -> Void)?
    
    // These will be overwritten by inherited object
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

class HomeViewController: UIViewController {
    
    @IBOutlet var homeTableView: UITableView!
    
    // Local variables for the workout and view model
    var work: Workouts!
    var homeViewModel: HomeViewModel!
    
    // References for the a local athlete
    weak var localAthlete: Athlete!
    
    var indicator: ActivityIndicator!
    var alert: UIAlertController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Prepare navigation bar and center image
        let logo = UIImage(named: "RASE Icon - White")
        let imageView = UIImageView(image: logo)
        imageView.frame = CGRect(x: 0, y: 0, width: 22, height: 30)
        imageView.contentMode = .scaleAspectFit // set imageview's content mode
        imageView.widthAnchor.constraint(equalToConstant: 22).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.navigationItem.titleView = imageView
        
        // Format back button
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.tintColor = workoutOrange
        
        // Register the nibs for the different required sections
        homeTableView.register(UINib(nibName: "workoutHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "workoutHeader")
        homeTableView.register(UINib(nibName: "workoutHeaderCell", bundle: nil), forCellReuseIdentifier: "headerItem")
        homeTableView.register(UINib(nibName: "workoutEquipmentCell", bundle: nil), forCellReuseIdentifier: "equipmentItem")
        homeTableView.register(UINib(nibName: "workoutProgressCell", bundle: nil), forCellReuseIdentifier: "progressItem")
        homeTableView.register(UINib(nibName: "workoutUpgradeCell", bundle: nil), forCellReuseIdentifier: "upgradeItem")
        homeTableView.register(UINib(nibName: "workoutDrillCell", bundle: nil), forCellReuseIdentifier: "drillItem")
        
        homeTableView.register(UINib(nibName: "newWorkoutWelcome", bundle: nil), forCellReuseIdentifier: "newWelcomeItem")
        homeTableView.register(UINib(nibName: "newWorkoutGetWorkout", bundle: nil), forCellReuseIdentifier: "newWorkoutItem")
        homeTableView.register(UINib(nibName: "newWorkoutTutorial", bundle: nil), forCellReuseIdentifier: "newTutorialItem")
        homeTableView.register(UINib(nibName: "newWorkoutBuffer", bundle: nil), forCellReuseIdentifier: "newBufferItem")
        
        homeTableView.register(UINib(nibName: "coachAdminFinancialsCell", bundle: nil), forCellReuseIdentifier: "financialsItem")
        homeTableView.register(UINib(nibName: "coachAdminLineMetricsCell", bundle: nil), forCellReuseIdentifier: "lineItem")
        homeTableView.register(UINib(nibName: "coachAdminPieMetricsCell", bundle: nil), forCellReuseIdentifier: "pieItem")
        homeTableView.register(UINib(nibName: "coachAdminRadarMetricsCell", bundle: nil), forCellReuseIdentifier: "radarItem")
        homeTableView.register(UINib(nibName: "coachAdminCandleMetricsCell", bundle: nil), forCellReuseIdentifier: "candleItem")
        homeTableView.register(UINib(nibName: "coachAdminBarMetricsCell", bundle: nil), forCellReuseIdentifier: "barItem")
        
        // For automatic row height calculations
        homeTableView.rowHeight = UITableViewAutomaticDimension
        homeTableView.estimatedRowHeight = 50                   // Was 266
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // If the user is an athlete
        if let athlete = localDataManager.sharedInstance.localUser as? Athlete {
            localAthlete = athlete
            handleAthlete()
        }
        // If the user is some sort of staff member
        else if localDataManager.sharedInstance.localUser?.type == .coach || localDataManager.sharedInstance.localUser?.type == .admin {
            handleAdminCoach()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        // Upon leaving the page, send and recieve updates to/from the server
        if work != nil {
            asynchronousUpdateWorkout(code: work.workoutCode)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Function called whenever the home view is changed or updated- sets the view model
    func resetHomeViewModel() {
        
        // Link the table view up with the view model
        DispatchQueue.main.async {
            
            self.homeTableView.delegate = self.homeViewModel
            self.homeTableView.dataSource = self.homeViewModel
            
            self.homeViewModel?.reloadSections = { [weak self] (section: Int) in
                self?.homeTableView?.beginUpdates()
                self?.homeTableView?.reloadSections([section], with: .fade)
                self?.homeTableView?.endUpdates()
            }
            
            self.homeTableView.reloadData()
        }
    }
}

// Extension to handle the case where the user is an Athlete
extension HomeViewController {

    func handleAthlete() {
        // If the athlete does not have a workout associated with their account
        if localAthlete.workoutCode == nil && localAthlete.archiveThumbnails.count == 0 {
            
            // Display workout page
            self.homeViewModel = NewWorkoutViewModel(parent: self)
            self.homeTableView.separatorStyle = .none
            self.homeTableView.isScrollEnabled = false
            self.resetHomeViewModel()
        }
        // Else if the athlete's workout is not downloaded
        else if localAthlete.currentWorkout == nil {
            
            // Download the workout and load it
            pullWorkoutFromServer(code: localAthlete.workoutCode)
        }
        // Else if the workout has already been downloaded, first update it 
        else {
            
            // Set the local variables and reset the page
            if work == nil {
                work = localAthlete.currentWorkout!
            }
            
            // Get start and end calendar to compare dates
            let currentCalendar = Calendar.current
            guard let startCal = currentCalendar.ordinality(of: .day, in: .era, for: work.startDate) else {return}
            guard let endCal = currentCalendar.ordinality(of: .day, in: .era, for: Date()) else {return}
            
            if (endCal - startCal < 7) && (!work.drillSummaries.isEmpty) {
                
                // Check to see if it is a different day than the application was last opened
                guard let prevCal = currentCalendar.ordinality(of: .day, in: .era, for: (localAthlete.lastLoggedOn)!) else {return}
                
                // If it is a different day:
                if endCal - prevCal > 0 {
                    
                    // Update previous time accessed to now
                    localAthlete.lastLoggedOn = Date()
                    
                    // Check to see if all drills for that day were completed
                    var completed = 0
                    for eachDrill in work.completedDrills.dayProgress {
                        completed = completed + eachDrill
                    }
                    if completed == work.drillSummaries.count {
                        
                        // If they were, update days worked out
                        work.daysWorkedOut = work.daysWorkedOut + 1
                    }
                    
                    // Clear the days progress and uncomplete each drill
                    for eachDrill in work.drillSummaries {
                        eachDrill.drillCompleted = false
                    }
                    work.completedDrills.dayProgress = [0,0,0,0,0,0]
                }
                
                // Update the home view model with the updated number
                self.homeViewModel = WorkoutsViewModel(workout: work, parent: self)
                resetHomeViewModel()
                
                // Pull workout updates from the server
                asynchronousUpdateWorkout(code: work.workoutCode)
            }
            else {
                pullWorkoutFromServer()
            }
        }
    }
    
    // Starts the activity indicator and calls the fetch function
    func pullWorkoutFromServer(code: Int? = nil) {
        
        // Start the indicator
        self.indicator = ActivityIndicator(viewController: self)
        self.indicator.startAnimator()
        
        // If the user has a workout code, pull that workout
        if code != nil {
            fetchCurrentWorkoutFromServer(code: code!, success: successWorkout, failure: failureWorkout)
        }
        // Else get a new workout
        else {
            fetchWorkoutFromServer(success: successWorkout, failure: failureWorkout)
        }
    }
    
    // Update the workout asynchronously
    // - Pulls the workout, updates any drills that have been changed
    // - Pushes update to the cloud
    func asynchronousUpdateWorkout(code: Int) -> Void {
        DispatchQueue.main.async() {
            fetchCurrentWorkoutFromServer(code: code, success: self.successUpdate, failure: self.failureUpdate)
        }
    }
    
    // Once recieved, go through and update the workout
    // - Only update drills that havent been changed locally and have been changed remotely
    func successUpdate(workout: Workouts) -> Void {
        
        // Keep track of whether there are any locally changed drills
        var localChanged = false
        
        // Go through all remote drills
        for eachDrill in workout.drillSummaries {
            
            // Find its equivilent in the local drills
            for eachLocal in self.work.drillSummaries {
                
                // If the drills match, the local one has not been changed, and the remote one is different, update
                if eachDrill == eachLocal && !eachLocal.locallyChanged && eachDrill.drillCompleted != eachLocal.drillCompleted {
                    if eachDrill.drillCompleted {
                        _ = eachLocal.complete()
                        _ = self.work.completedDrills.completeADrill(type: eachLocal.drillType)
                    }
                    else {
                        _ = eachLocal.uncomplete()
                        _ = self.work.completedDrills.uncompleteADrill(type: eachLocal.drillType)
                    }
                }
                
                if eachLocal.locallyChanged {
                    localChanged = true
                }
            }
        }
        
        // After updating all the drills, reload the table
        self.homeViewModel = WorkoutsViewModel(workout: work, parent: self)
        self.resetHomeViewModel()
        
        // Once table is reloaded, save workout to server and local database
        if localChanged {
            let feedback = Feedback(workout: work, user: localAthlete.email)
            feedback.drillTypes.removeAll()
            feedback.coachRating.removeAll()
            submitWorkoutFeedback(feedback: feedback, token: localAthlete.token!, success: self.workoutSaveBackSuccess, failure: self.workoutSaveBackFailure)
            
            DispatchQueue.main.async {
                if let id = self.work.id {
                    _ = RASEDB.instance.updateWorkout(wid: id, newWorkout: self.work)
                }
                else {
                    _ = RASEDB.instance.addWorkout(newWorkout: self.work)
                }
            }
        }
    }
    
    func failureUpdate(message: String) -> Void {
        // Do nothing on failure
    }
    
    func successWorkout(workout: Workouts) -> Void {
        DispatchQueue.main.async(){
            
            // Upon success, set the classes workout
            self.work = workout
            self.homeViewModel = WorkoutsViewModel(workout: self.work, parent: self)
            self.resetHomeViewModel()
            
            // Once a new workout has been created, add it to the local user and save the user
            self.localAthlete.currentWorkout = self.work
            localDataManager.sharedInstance.saveUserData()
            
            self.indicator.removeIndicator()
            self.homeTableView.isScrollEnabled = true
            
            // Now that the workout is downloaded, asynchronously get drill thumbnail
            DispatchQueue.global(qos: .background).async {
                
                // Get the thumbnails
                for eachDrill in workout.drillSummaries {
                    if let image = thumbnailFromURL(url: eachDrill.videoURL) {
                        eachDrill.thumbnail = image
                    }
                }
            }
        }
    }
    
    // Success handler for saving back drills
    func workoutSaveBackSuccess() -> Void {
        
        // Mark all drills as unchanged
        for each in self.work.drillSummaries {
            each.locallyChanged = false
        }
    }
    
    // Failure handler for saving back drills
    func workoutSaveBackFailure(message: String) -> Void {
        // Do nothing
    }
    
    func failureWorkout(message: String) -> Void {
        
        // Create the alert
        alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            self.indicator.removeBackground()
        }))
        
        DispatchQueue.main.async(){
            
            // Upon failure, create empty dummy workout to display
            self.work = Workouts(daysAWeek: 0, code: 0, drills: [DrillSummary](), equipment: [EquipmentSummary]())
            self.homeViewModel = WorkoutsViewModel(workout: self.work, parent: self)
            self.resetHomeViewModel()
            
            // Once a new workout has been created, add it to the local user and save the user
            self.localAthlete.currentWorkout = self.work
            localDataManager.sharedInstance.saveUserData()
            
            self.indicator.removeSpinner()
            self.present(self.alert, animated: true)
        }
    }
}

// Extension to handle the case where the user is an Coach
extension HomeViewController {
    
    func handleAdminCoach() {
        
        // Fetch/Generate coach data
        
        // Create view model
        self.homeViewModel = CoachAdminViewModel(parent: self)
        self.homeTableView.separatorColor = .clear
       
        // Assign view model to table
        resetHomeViewModel()
    }
}

*/

