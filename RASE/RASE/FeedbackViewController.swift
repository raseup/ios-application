//
//  FeedbackViewController.swift
//  RASE
//
//  Created by Sam Beaulieu on 9/10/17.
//  Copyright © 2017 RASE. All rights reserved.
//

import UIKit
/*
class FeedbackViewController: UIViewController {

    @IBOutlet weak var feedbackTableView: UITableView!
    
    var items = [FeedbackViewModelItem]()
    var feedback: Feedback!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var localAthlete: Athlete!
    
    // Prepare for use in the table view and for error checking
    var drills = [DrillType]()
    var coachNames = [String]()
    var coachCodes = [Int]()
    
    // Prepare activity indicator and alert variables
    var indicator: ActivityIndicator!
    var alert: UIAlertController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let athlete = localDataManager.sharedInstance.localUser as? Athlete else { return }
        localAthlete = athlete
        
        // Build the feedback object to hold everything needed for the feedback loop
        feedback = Feedback(workout: localAthlete.currentWorkout!, user: localAthlete.email)
        
        // Prepare the table delegate and datasource
        feedbackTableView.delegate = self
        feedbackTableView.dataSource = self
        
        // Prepare variables for the table to build off
        for each in localAthlete.currentWorkout!.drillSummaries {
            if !drills.contains(each.drillType) && !each.daysCompleted.isEmpty {
                drills.append(each.drillType)
            }
        }
        for each in localDataManager.sharedInstance.allUsers {
            if each.type == .coach && each.messagingName != nil && each.code != nil {
                coachNames.append(each.name)
                coachCodes.append(each.code!)
            }
        }

        // Add the proper sections to the list of items
        items.append(FeedbackViewHeaderItem())
        items.append(FeedbackViewDrillItem(drillTypes: drills))
        if localAthlete.version == Version.premium {
            items.append(FeedbackViewVideoItem())
        }
        items.append(FeedbackViewCoachItem(coaches: coachNames, codes: coachCodes))
        items.append(FeedbackViewSubmissionItem())
        
        // Register the nibs for the different required sections
        feedbackTableView.register(UINib(nibName: "feedbackHeader", bundle: nil), forCellReuseIdentifier: "feedbackHeaderCell")
        feedbackTableView.register(UINib(nibName: "feedbackDrills", bundle: nil), forCellReuseIdentifier: "feedbackDrillCell")
        feedbackTableView.register(UINib(nibName: "feedbackVideo", bundle: nil), forCellReuseIdentifier: "feedbackVideoCell")
        feedbackTableView.register(UINib(nibName: "feedbackCoach", bundle: nil), forCellReuseIdentifier: "feedbackCoachCell")
        feedbackTableView.register(UINib(nibName: "feedbackSubmission", bundle: nil), forCellReuseIdentifier: "feedbackSubmissionCell")
        
        // Prepare for automatic resizing of cell height and scrolling
        feedbackTableView.rowHeight = UITableViewAutomaticDimension
        feedbackTableView.estimatedRowHeight = 220
        self.automaticallyAdjustsScrollViewInsets = false
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // Prepare the activity indicator and the alerts
        indicator = ActivityIndicator(viewController: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Attempt to submit the feedback
    func attempSubmit() -> Void {
        
        // Starts the thinking indicator
        indicator.startAnimator()

        // Error checks: Makes sure each section has been reviewed and is filled in
        for each in drills {
            guard let temp = feedback.drillTypes[each] else { failure(message: "Error processing drills. Please try again."); return}
            if temp == 0 {
                failure(message: "Please react to every drill type.")
                return
            }
        }
        for each in coachCodes {
            if feedback.coachRating[each] == nil {
                failure(message: "Please rate each of your coaches.")
                return
            }
        }
        
        // Only lets users upload a video if they have premium
        if localAthlete.version == Version.premium {
            if feedback.videoLink == nil || feedback.videoThumbnail == nil {
                failure(message: "Please upload a video for coach review.")
                return
            }
        }
        
        // Tries to submit the workout feedback
        submitWorkoutFeedback(feedback: feedback, token: localAthlete.token!, success: success, failure: failure)
    }
    
    // Upon success, remove the current workout and dismiss feedback page
    func success() -> Void {
        DispatchQueue.main.async(){
            if let id = self.localAthlete.currentWorkout?.id {
                _ = RASEDB.instance.deleteWorkout(wid: id)
            }
            self.localAthlete.currentWorkout = nil
            self.indicator.removeIndicator()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    // Failure handlers: Each states the error and removes the spinner
    func failure(message: String) -> Void {
        
        // Create the alert
        alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            self.indicator.removeBackground()
        }))
        
        DispatchQueue.main.async(){
            self.indicator.removeSpinner()
            self.present(self.alert, animated: true)
        }
    }
}

// Extension of the view to be used as the datasource and delegate for the table view
// - Contains the functions that will be called when the table view is initiated and updated
extension FeedbackViewController: UITableViewDataSource, UITableViewDelegate {
    
    // Returns the number of sections to the table
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.items.count
    }
    
    // Returns the number of rows per section of the table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items[section].rowCount
    }
    
    // Returns the cell to be displayed at a certain row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = items[indexPath.section]
        
        switch section.type {
        // Add the header cell
        case .header:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "feedbackHeaderCell", for: indexPath) as? FeedbackHeaderCell {
                return cell
            }
            
        // Add the drill cell
        case .drill:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "feedbackDrillCell", for: indexPath) as? FeedbackDrillCell {
                cell.drillType = (section as! FeedbackViewDrillItem).drillTypes[indexPath.row]
                cell.feedback = feedback
                return cell
            }
            
        // Add the video upload cell
        case .video:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "feedbackVideoCell", for: indexPath) as? FeedbackVideoCell {
                cell.feedback = feedback
                cell.parentVC = self
                return cell
            }
            
        // Add the coach cell
        case .coach:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "feedbackCoachCell", for: indexPath) as? FeedbackCoachCell {
                cell.coachName = (section as! FeedbackViewCoachItem).coachNames[indexPath.row]
                cell.coachCode = (section as! FeedbackViewCoachItem).coachCodes[indexPath.row]
                cell.feedback = feedback
                return cell
            }
            
        // Add the submission cells
        case .submission:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "feedbackSubmissionCell", for: indexPath) as? FeedbackSubmissionCell {
                cell.submit = attempSubmit
                return cell
            }
        }
        
        // return the default cell if none of above succeed
        return UITableViewCell()
    }
}*/
