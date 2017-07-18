//
//  DashboardModelView.swift
//  RASE
//
//  Created by Sam Beaulieu on 7/10/17.
//  Copyright © 2017 RASE. All rights reserved.
//

import Foundation
import UIKit

// Enum to maintain types of workout view sections
// - Each of these types will correlate to one section in the workout table view
enum WorkoutsViewModelItemType {
    case header
    case buyPrompt
    case progress
    case description
    case fundamentals
    case ballHandling
    case defense
    case passing
    case finishing
    case shooting
}

// Protocol for each section to conform to
// - Each needs a type, a row count, and a title
protocol WorkoutsViewModelItem {
    var type: WorkoutsViewModelItemType { get }
    var rowCount: Int { get }
    var sectionTitle: String  { get }
    var isCollapsible: Bool { get }
    var isCollapsed: Bool { get set }
}

// Extention to WorkoutsViewModelItem protocol to add a default row count and collapsed boolean
extension WorkoutsViewModelItem {
    var rowCount: Int {
        return 1
    }
    
    var isCollapsible: Bool {
        return true
    }
}

// Class for the header item which contains the header info for the workout page
// - Conforms to WorkoutsViewModelItem protocol
// - Always has only one cell
class WorkoutsViewModelHeaderItem: WorkoutsViewModelItem {
    var type: WorkoutsViewModelItemType {
        return .header
    }
    var sectionTitle: String {
        return "Overview"
    }
    var isCollapsed: Bool {
        return false
    }
    var isCollapsed = false
    
    // Variables specific to the header
    var completeBy: Date
    var daysLeft: Int
    var drillNumber: Int
    var pictureID: String
    
    // Initialize the header item and set the local variables
    // - Randomly choose an image to set as the background
    init(completeBy: Date, daysLeft: Int, drillNumber: Int) {
        self.completeBy = completeBy
        self.daysLeft = daysLeft
        self.drillNumber = drillNumber
        
        // Randomly Set Picture from a list of locally stored images
        self.pictureID = ""
    }
}

// Class for the upgrade item which contains a button to suggest to the user to upgrade
// - Only contains current version and will only be shown if not premium
class WorkoutsViewModelUpgradeItem: WorkoutsViewModelItem {
    var type: WorkoutsViewModelItemType {
        return .buyPrompt
    }
    var sectionTitle: String {
        return "Upgrade Today"
    }
    var isCollapsed: Bool {
        return false
    }
    var isCollapsed = false
    
    // Keeps track of the current version for the view controller
    var version: Version
    
    // Initializer takes the current version and sets the local variable to it
    init(version: Version) {
        self.version = version
    }
}

// Class for the progress item which contains an overview of a user's current progress
// - Maintains a reference to the progress manager which is used to keep track of progress
class WorkoutsViewModelProgressItem: WorkoutsViewModelItem {
    var type: WorkoutsViewModelItemType {
        return .progress
    }
    var sectionTitle: String {
        return "This Weeks Progress"
    }
    var isCollapsed = false
    
    // Keeps track of the progress made by a user in a week
    var progress: ProgressManager
    
    // Initalizes the progress view item by setting the passed variable to the local one
    init(progress: ProgressManager) {
        self.progress = progress
    }
}

// Class for the description item which contains a description of the week's workout
class WorkoutsViewModelDescriptionItem: WorkoutsViewModelItem {
    var type: WorkoutsViewModelItemType {
        return .description
    }
    var sectionTitle: String {
        return "Description"
    }
    var isCollapsed = false
    
    // Holds the description of this week's workout
    var description: String
    
    // Initializes the local description with the one from the model
    init(description: String) {
        self.description = description
    }
}

// Class for the fundamental drills
// - Keeps a reference to all the drills as well as to the progress class
// - Allows for row count and updating progress
class WorkoutsViewModelFundamentalsItem: WorkoutsViewModelItem {
    var type: WorkoutsViewModelItemType {
        return .fundamentals
    }
    var sectionTitle: String {
        return "fundamentals"
    }
    var rowCount: Int {
        return progress.total![0]
    }
    var isCollapsed = false
    
    // References to all the drills as well as the progress summary
    var drills = [DrillSummary]()
    var progress: ProgressManager
    
    // Initialized by setting all the drills and progress to the local references
    init(drills: [DrillSummary], progress: ProgressManager) {

        // Add the fundamental drills to the drill list
        for eachDrill in drills{
            if eachDrill.drillType == .fundamentals {
                self.drills.append(eachDrill)
            }
        }
        
        // Set the progress variable
        self.progress = progress
    }
}

// Class for the ball handling drills
// - Keeps a reference to all the drills as well as to the progress class
// - Allows for row count and updating progress
class WorkoutsViewModelBallHandlingItem: WorkoutsViewModelItem {
    var type: WorkoutsViewModelItemType {
        return .ballHandling
    }
    var sectionTitle: String {
        return "Ball Handling"
    }
    var rowCount: Int {
        return progress.total![1]
    }
    var isCollapsed = false
    
    // References to all the drills as well as the progress summary
    var drills = [DrillSummary]()
    var progress: ProgressManager
    
    // Initialized by setting all the drills and progress to the local references
    init(drills: [DrillSummary], progress: ProgressManager) {
        
        // Add the fundamental drills to the drill list
        for eachDrill in drills{
            if eachDrill.drillType == .ballHandling {
                self.drills.append(eachDrill)
            }
        }
        
        self.progress = progress
    }
}

// Class for the defense drills
// - Keeps a reference to all the drills as well as to the progress class
// - Allows for row count and updating progress
class WorkoutsViewModelDefenseItem: WorkoutsViewModelItem {
    var type: WorkoutsViewModelItemType {
        return .defense
    }
    var sectionTitle: String {
        return "Defense "
    }
    var rowCount: Int {
        return progress.total![2]
    }
    var isCollapsed = false
    
    // References to all the drills as well as the progress summary
    var drills = [DrillSummary]()
    var progress: ProgressManager
    
    // Initialized by setting all the drills and progress to the local references
    init(drills: [DrillSummary], progress: ProgressManager) {
        
        // Add the fundamental drills to the drill list
        for eachDrill in drills{
            if eachDrill.drillType == .defense {
                self.drills.append(eachDrill)
            }
        }
        
        self.progress = progress
    }
}

// Class for the passing drills
// - Keeps a reference to all the drills as well as to the progress class
// - Allows for row count and updating progress
class WorkoutsViewModelPassingItem: WorkoutsViewModelItem {
    var type: WorkoutsViewModelItemType {
        return .passing
    }
    var sectionTitle: String {
        return "Passing"
    }
    var rowCount: Int {
        return progress.total![3]
    }
    var isCollapsed = false
    
    // References to all the drills as well as the progress summary
    var drills = [DrillSummary]()
    var progress: ProgressManager
    
    // Initialized by setting all the drills and progress to the local references
    init(drills: [DrillSummary], progress: ProgressManager) {
        
        // Add the fundamental drills to the drill list
        for eachDrill in drills{
            if eachDrill.drillType == .passing {
                self.drills.append(eachDrill)
            }
        }
        
        self.progress = progress
    }
}

// Class for the finishing drills
// - Keeps a reference to all the drills as well as to the progress class
// - Allows for row count and updating progress
class WorkoutsViewModelFinishingItem: WorkoutsViewModelItem {
    var type: WorkoutsViewModelItemType {
        return .finishing
    }
    var sectionTitle: String {
        return "Finishing "
    }
    var rowCount: Int {
        return progress.total![4]
    }
    var isCollapsed = false
    
    // References to all the drills as well as the progress summary
    var drills = [DrillSummary]()
    var progress: ProgressManager
    
    // Initialized by setting all the drills and progress to the local references
    init(drills: [DrillSummary], progress: ProgressManager) {
        
        // Add the fundamental drills to the drill list
        for eachDrill in drills{
            if eachDrill.drillType == .finishing {
                self.drills.append(eachDrill)
            }
        }
        
        self.progress = progress
    }
}

// Class for the shooting drills
// - Keeps a reference to all the drills as well as to the progress class
// - Allows for row count and updating progress
class WorkoutsViewModelShootingItem: WorkoutsViewModelItem {
    var type: WorkoutsViewModelItemType {
        return .shooting
    }
    var sectionTitle: String {
        return "Shooting"
    }
    var rowCount: Int {
        return progress.total![3]
    }
    var isCollapsed = false
    
    // References to all the drills as well as the progress summary
    var drills = [DrillSummary]()
    var progress: ProgressManager
    
    // Initialized by setting all the drills and progress to the local references
    init(drills: [DrillSummary], progress: ProgressManager) {
        
        // Add the fundamental drills to the drill list
        for eachDrill in drills{
            if eachDrill.drillType == .shooting {
                self.drills.append(eachDrill)
            }
        }
        
        self.progress = progress
    }
}


// Class to model the whole view by adding whatever items are necessary to an array
// - The list of items will contain data for each of the sections to be added
// - This class initializes all the item classes and puts them in the right order
class WorkoutsViewModel: NSObject {
    
    // References to all the drills, the current progress, and the sections to be implemented
    var items = [WorkoutsViewModelItem]()
    var drills = [DrillSummary]()
    var progressManager: ProgressManager?
    
    init(workout: Workouts) {
        super.init()
        
        guard let progressManager = workout.completedDrills else { return }
        
        // Add the header section to the list of items
        if let completeBy = workout.completeBy, let daysLeft = workout.daysLeft, let drillNumber = workout.drillNumber {
            let headerItem = WorkoutsViewModelHeaderItem(completeBy: completeBy, daysLeft: daysLeft, drillNumber: drillNumber)
            items.append(headerItem)
        }
        
        // Add the upgrade section to the list of items if not premium
        let version = workout.currentVersion
        if version != nil && version! != .premium {
            let upgradeItem = WorkoutsViewModelUpgradeItem(version: version!)
            items.append(upgradeItem)
        }
        
        // Add the progress section to the list of items
        if let progress = workout.completedDrills {
            let progressItem = WorkoutsViewModelProgressItem(progress: progress)
            items.append(progressItem)
        }
        
        // Add the description section to the list of items
        if let description = workout.description {
            let descriptionItem = WorkoutsViewModelDescriptionItem(description: description)
            items.append(descriptionItem)
        }
        
        drills = workout.drillSummaries
        
        // Add fundamentals section to the list of items if necessary
        if !drills.isEmpty && progressManager.total![0] != 0 {
            let fundamentalsItem = WorkoutsViewModelFundamentalsItem(drills: drills, progress: progressManager)
            items.append(fundamentalsItem)
        }
        
        // Add Ball Handling section to the list of items if necessary
        if !drills.isEmpty && progressManager.total![1] != 0 {
            let ballHandlingItem = WorkoutsViewModelBallHandlingItem(drills: drills, progress: progressManager)
            items.append(ballHandlingItem)
        }
        
        // Add Defense section to the list of items if necessary
        if !drills.isEmpty && progressManager.total![2] != 0 {
            let defenseItem = WorkoutsViewModelDefenseItem(drills: drills, progress: progressManager)
            items.append(defenseItem)
        }
        
        // Add Passing section to the list of items if necessary
        if !drills.isEmpty && progressManager.total![3] != 0 {
            let passingItem = WorkoutsViewModelPassingItem(drills: drills, progress: progressManager)
            items.append(passingItem)
        }
        
        // Add Finishing section to the list of items if necessary
        if !drills.isEmpty && progressManager.total![4] != 0 {
            let finishingItem = WorkoutsViewModelFinishingItem(drills: drills, progress: progressManager)
            items.append(finishingItem)
        }
        
        // Add Shooting section to the list of items if necessary
        drills = workout.drillSummaries
        if !drills.isEmpty && progressManager.total![5] != 0 {
            let shootingItem = WorkoutsViewModelShootingItem(drills: drills, progress: progressManager)
            items.append(shootingItem)
        }
    }
}

// Extension of the view model to be used as the datasource and delegate for the table view
// - Contains the functions that will be called when the table view is initiated and updated
extension WorkoutsViewModel: UITableViewDataSource, UITableViewDelegate {
    
    // Returns the number of sections to the table
    func numberOfSections(in tableView: UITableView) -> Int {
        print("number of sections")
        return items.count
    }
    
    // Returns the number of rows per section of the table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("number of rows")
        let item = items[section]
        if item.isCollapsed && item.isCollapsible {
            return 0
        }
        return items[section].rowCount
    }
    
    // Defines how the header should look for each section
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        view.tintColor = UIColor.white
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.black
    }
    
    // Defines which headers to show and which ones to hide
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        switch section {
        // Overview section
        case 0:
            return 0
        // Upgrade section
        case 1:
            return 0
        // Description section
        case 3:
            return 0
        // All other sections (progress and drills)
        default:
            return 15
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: CustomTableHeader.identifier) as? CustomTableHeader {
            headerView.item = items[section]
            headerView.section = section
            headerView.delegate = self
            return headerView
        }
        return UIView()
    }

    
    // Returns the cell to be displayed at a certain row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("displaying rows")
        let section = items[indexPath.section]

        switch section.type {
        // Add the header cells to the list
        case .header:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "headerItem", for: indexPath) as? WorkoutsViewControllerHeaderCell {
                cell.item = section
                return cell
            }
            
        // Add the upgrade cells to the list
        case .buyPrompt:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "upgradeItem", for: indexPath) as? WorkoutsViewControllerUpgradeCell {
                return cell
            }
            
        // Add the progress cells to the list
        case .progress:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "progressItem", for: indexPath) as? WorkoutsViewControllerProgressCell {
                cell.progress = progressManager
                return cell
            }
        
        // Add the fundamental drill cells to the list
        case .fundamentals:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "drillsItem", for: indexPath) as? WorkoutsViewControllerDrillCell {
                let sectionWithType = section as! WorkoutsViewModelFundamentalsItem
                cell.drill = sectionWithType.drills[indexPath.row]
                return cell
            }
        
        // Add the ball handling drill cells to the list
        case .ballHandling:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "drillsItem", for: indexPath) as? WorkoutsViewControllerDrillCell {
                let sectionWithType = section as! WorkoutsViewModelBallHandlingItem
                cell.drill = sectionWithType.drills[indexPath.row]
                return cell
            }
        
        // Add the defense drill cells to the list
        case .defense:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "drillsItem", for: indexPath) as? WorkoutsViewControllerDrillCell {
                let sectionWithType = section as! WorkoutsViewModelDefenseItem
                cell.drill = sectionWithType.drills[indexPath.row]
                return cell
            }
            
        // Add the passing drill cells to the list
        case .passing:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "drillsItem", for: indexPath) as? WorkoutsViewControllerDrillCell {
                let sectionWithType = section as! WorkoutsViewModelPassingItem
                cell.drill = sectionWithType.drills[indexPath.row]
                return cell
            }
        
        // Add the finishing drill cells to the list
        case .finishing:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "drillsItem", for: indexPath) as? WorkoutsViewControllerDrillCell {
                let sectionWithType = section as! WorkoutsViewModelFinishingItem
                cell.drill = sectionWithType.drills[indexPath.row]
                return cell
            }
        
        // Add the shooting drill cells to the list
        case .shooting:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "drillsItem", for: indexPath) as? WorkoutsViewControllerDrillCell {
                let sectionWithType = section as! WorkoutsViewModelShootingItem
                cell.drill = sectionWithType.drills[indexPath.row]
                return cell
            }
        
        // Default return default cell
        default:
            return UITableViewCell()
        }

        // return the default cell if none of above succeed
        return UITableViewCell()
    }
}
