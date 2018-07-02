//
//  DashboardModelView.swift
//  RASE
//
//  Created by Sam Beaulieu on 7/10/17.
//  Copyright © 2017 RASE. All rights reserved.
//

import UIKit

import AWSS3
import AVKit
import AVFoundation
/*
// Class to model the whole view by adding whatever items are necessary to an array
// - The list of items will contain data for each of the sections to be added
// - This class initializes all the item classes and puts them in the right order
class WorkoutsViewModel: HomeViewModel {
    
    // References to all the drills, the current progress, and the sections to be implemented
    var items = [WorkoutsViewModelItem]()
    var progressManager: ProgressManager!
    var parent: HomeViewController!
    
    init(workout: Workouts, parent: HomeViewController) {
        super.init()
        
        self.parent = parent
        
        guard let progress = workout.completedDrills else { return }
        self.progressManager = progress
        
        // Add the header section to the list of items
        let currentCalendar = Calendar.current
        guard let startCal = currentCalendar.ordinality(of: .day, in: .era, for: workout.startDate) else {return}
        guard let endCal = currentCalendar.ordinality(of: .day, in: .era, for: Date()) else {return}
        let headerItem = WorkoutsViewModelHeaderItem(daysLeft: 7 - (endCal-startCal))
        items.append(headerItem)
        
        // Add the equipment section to the list of items
        let equipmentItem = WorkoutsViewModelEquipmentItem(equipment: workout.equipmentSummaries)
        items.append(equipmentItem)
        
        // Add the progress section to the list of items
        let progressItem = WorkoutsViewModelProgressItem(progress: progressManager)
        items.append(progressItem)
        
        let drills = workout.drillSummaries
        
        // Add Ball Handling section to the list of items
        if !drills.isEmpty {
            let ballHandlingItem = WorkoutsViewModelBallHandlingItem(drills: drills, progress: progressManager, type: .ballHandling)
            items.append(ballHandlingItem)
        }
        
        // Add Defense section to the list of items
        if !drills.isEmpty {
            let defenseItem = WorkoutsViewModelDefenseItem(drills: drills, progress: progressManager, type: .defense)
            items.append(defenseItem)
        }
        
        // Add Passing section to the list of items
        if !drills.isEmpty {
            let passingItem = WorkoutsViewModelPassingItem(drills: drills, progress: progressManager, type: .passing)
            items.append(passingItem)
        }
        
        // Add Finishing section to the list of items
        if !drills.isEmpty {
            let finishingItem = WorkoutsViewModelFinishingItem(drills: drills, progress: progressManager, type: .finishing)
            items.append(finishingItem)
        }
        
        // Add Shooting section to the list of items
        if !drills.isEmpty {
            let shootingItem = WorkoutsViewModelShootingItem(drills: drills, progress: progressManager, type: .shooting)
            items.append(shootingItem)
        }
        
        // Add Archive section to the list of items
        let archiveItem = WorkoutsViewModelArchiveItem(drills: drills, progress: progressManager)
        items.append(archiveItem)
    }
    
    // Returns the number of sections to the table
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    // Returns the number of rows per section of the table
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        let item = items[section]
        if item.isCollapsed && item.isCollapsible {
            return 0
        }
        return items[section].rowCount
    }
    
    // Defines which headers to show and which ones to hide
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if items[section].isDrill && items[section].rowCount != 0 {
            return 30
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "workoutHeader") as? CustomWorkoutTableHeader {
            headerView.item = items[section]
            headerView.section = section
            headerView.preservesSuperviewLayoutMargins = false
            headerView.layoutMargins = UIEdgeInsets.zero
            headerView.delegate = self
            return headerView
        }
        return nil
    }

    
    // Returns the cell to be displayed at a certain row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let section = items[indexPath.section]

        switch section.type {
            // Add the header cells to the list
            case .header:
                if let cell = tableView.dequeueReusableCell(withIdentifier: "headerItem", for: indexPath) as? WorkoutsViewControllerHeaderCell {
                    cell.item = section
                    cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
                    cell.parent = self.parent
                    return cell
                }
                
            // Add the equipment cells to the list
            case .equipment:
                if let cell = tableView.dequeueReusableCell(withIdentifier: "equipmentItem", for: indexPath) as? WorkoutsViewControllerEquipmentCell {
                    cell.item = section
                    cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
                    return cell
                }
                
            // Add the progress cells to the list
            case .progress:
                if let cell = tableView.dequeueReusableCell(withIdentifier: "progressItem", for: indexPath) as? WorkoutsViewControllerProgressCell {
                    cell.progress = (section as! WorkoutsViewModelProgressItem).progress
                    cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
                    return cell
                }
            
            // Add the fundamental drill cells to the list
            case .fundamentals:
                if let cell = tableView.dequeueReusableCell(withIdentifier: "drillItem", for: indexPath) as? WorkoutsViewControllerDrillCell {
                    let sectionWithType = section as! WorkoutsViewModelFundamentalsItem
                    cell.drill = sectionWithType.drills[indexPath.row]
                    cell.preservesSuperviewLayoutMargins = false
                    cell.separatorInset = UIEdgeInsets.zero
                    cell.layoutMargins = UIEdgeInsets.zero
                    return cell
                }
            
            // Add the shooting drill cells to the list
            case .shooting:
                if let cell = tableView.dequeueReusableCell(withIdentifier: "drillItem", for: indexPath) as? WorkoutsViewControllerDrillCell {
                    let sectionWithType = section as! WorkoutsViewModelShootingItem
                    cell.drill = sectionWithType.drills[indexPath.row]
                    cell.preservesSuperviewLayoutMargins = false
                    cell.separatorInset = UIEdgeInsets.zero
                    cell.layoutMargins = UIEdgeInsets.zero
                    return cell
                }
            
            // Add the ball handling drill cells to the list
            case .ballHandling:
                if let cell = tableView.dequeueReusableCell(withIdentifier: "drillItem", for: indexPath) as? WorkoutsViewControllerDrillCell {
                    let sectionWithType = section as! WorkoutsViewModelBallHandlingItem
                    cell.drill = sectionWithType.drills[indexPath.row]
                    cell.preservesSuperviewLayoutMargins = false
                    cell.separatorInset = UIEdgeInsets.zero
                    cell.layoutMargins = UIEdgeInsets.zero
                    return cell
                }
            
            // Add the finishing drill cells to the list
            case .finishing:
                if let cell = tableView.dequeueReusableCell(withIdentifier: "drillItem", for: indexPath) as? WorkoutsViewControllerDrillCell {
                    let sectionWithType = section as! WorkoutsViewModelFinishingItem
                    cell.drill = sectionWithType.drills[indexPath.row]
                    cell.preservesSuperviewLayoutMargins = false
                    cell.separatorInset = UIEdgeInsets.zero
                    cell.layoutMargins = UIEdgeInsets.zero
                    return cell
                }
            
            // Add the passing drill cells to the list
            case .passing:
                if let cell = tableView.dequeueReusableCell(withIdentifier: "drillItem", for: indexPath) as? WorkoutsViewControllerDrillCell {
                    let sectionWithType = section as! WorkoutsViewModelPassingItem
                    cell.drill = sectionWithType.drills[indexPath.row]
                    cell.preservesSuperviewLayoutMargins = false
                    cell.separatorInset = UIEdgeInsets.zero
                    cell.layoutMargins = UIEdgeInsets.zero
                    return cell
                }
            
            // Add the defense drill cells to the list
            case .defense:
                if let cell = tableView.dequeueReusableCell(withIdentifier: "drillItem", for: indexPath) as? WorkoutsViewControllerDrillCell {
                    let sectionWithType = section as! WorkoutsViewModelDefenseItem
                    cell.drill = sectionWithType.drills[indexPath.row]
                    cell.preservesSuperviewLayoutMargins = false
                    cell.separatorInset = UIEdgeInsets.zero
                    cell.layoutMargins = UIEdgeInsets.zero
                    return cell
                }
            
            // Add the archived drill cells to the list
            case .archive:
                if let cell = tableView.dequeueReusableCell(withIdentifier: "drillItem", for: indexPath) as? WorkoutsViewControllerDrillCell {
                    let sectionWithType = section as! WorkoutsViewModelArchiveItem
                    cell.drill = sectionWithType.drills[indexPath.row]
                    cell.preservesSuperviewLayoutMargins = false
                    cell.separatorInset = UIEdgeInsets.zero
                    cell.layoutMargins = UIEdgeInsets.zero
                    return cell
                }
        }

        // return the default cell if none of above succeed
        return UITableViewCell()
    }
    
    // For completion and decompletion
    func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        
        // Get the section type
        let sectionRaw = items[editActionsForRowAt.section]
        let archiveSection = items.last as! WorkoutsViewModelArchiveItem
        
        // First check if the section contains drills
        if sectionRaw.isDrill {
            
            // If it contains drills and is not the archive, use complete
            if sectionRaw.type != .archive {
                let complete = UITableViewRowAction(style: .normal, title: "Complete") { action, index in
                    
                    let section = sectionRaw as! WorkoutsViewModelDrillItem
                    
                    tableView.beginUpdates()
                    // Update the sections
                    archiveSection.completeDrill(drill: section.drills[editActionsForRowAt.row])
                    section.complete(drill: section.drills[editActionsForRowAt.row])
                    // Move the row
                    if archiveSection.isCollapsed {
                        tableView.deleteRows(at: [editActionsForRowAt], with: .fade)
                    }
                    else {
                        tableView.moveRow(at: editActionsForRowAt, to: IndexPath(row: archiveSection.rowCount-1, section: self.items.count-1))
                    }
                    
                    tableView.endUpdates()
                    
                    self.reloadSections?(2)
                }
                
                complete.backgroundColor = .green
                return [complete]
            }
            // If it is the archive, uncomplete
            else {
                let uncomplete = UITableViewRowAction(style: .normal, title: "Uncomplete") { action, index in
                    // If uncompleted is clicked:
                    
                    // Get the drill that was uncompleted
                    let uncompletedDrill = archiveSection.drills[editActionsForRowAt.row]
                    
                    
                    var sectionReference: WorkoutsViewModelDrillItem?
                    var section = -1
                    for each in self.items {
                        section += 1
                        if each.type == uncompletedDrill.drillType {
                            sectionReference = each as? WorkoutsViewModelDrillItem
                            break
                        }
                    }
                    
                    tableView.beginUpdates()
                    // Update the datasources
                    sectionReference?.uncomplete(drill: uncompletedDrill)
                    archiveSection.uncompleteDrill(drill: uncompletedDrill)
                    // Move the row
                    if sectionReference!.isCollapsed {
                        tableView.deleteRows(at: [editActionsForRowAt], with: .automatic)
                    }
                    else {
                        tableView.moveRow(at: editActionsForRowAt, to: IndexPath(row: sectionReference!.rowCount-1, section: section))
                    }
                    tableView.endUpdates()
                    
                    // Reload Progress Section and
                    self.reloadSections?(2)
                    
                }
                uncomplete.backgroundColor = workoutOrange
                return [uncomplete]
            }
        }
        
        // If it falls through and doesn't contain drills, return nil
        return nil
    }
    
    // For completion and decompletion
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
       
        // Get the section type
        let section = items[indexPath.section]
        
        // Only make sections that contain drills editable
        if section.isDrill {
            return true
        }
        return false
    }
    
    // Stops non drills from being selected
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        if items[indexPath.section].isDrill {
            return indexPath
        }
        return nil
    }
    
    // Stops non drills from being highlighted when tapped
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
       
        if !items[indexPath.section].isDrill {
            return false
        }
        return true
    }
    
    // For playing selected videos
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // First deselect the video
        tableView.deselectRow(at: indexPath, animated: true)
 
        let sectionRaw = items[indexPath.section]
        
        if sectionRaw.type == .archive {
            let section = sectionRaw as! WorkoutsViewModelArchiveItem
            playVideo(link: section.drills[indexPath.row].videoURL)
        }
        else if sectionRaw.isDrill {
            let section = sectionRaw as! WorkoutsViewModelDrillItem
            playVideo(link: section.drills[indexPath.row].videoURL)
        }
    }
    
    // Play the video with the provided link
    func playVideo(link: String) {
        // Then play the video
        guard let url = URL(string: link) else {return}
        let player = AVPlayer(url: url)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        parent.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
    }
}

extension WorkoutsViewModel: CustomWorkoutTableHeaderDelegate {
    func toggleSection(header: CustomWorkoutTableHeader, section: Int) {
        var item = items[section]
        if item.isCollapsible {
            
            // Toggle collapse
            let collapsed = !item.isCollapsed
            item.isCollapsed = collapsed
            header.collapse(collapsed: collapsed)
            
            // Adjust the number of the rows inside the section
            reloadSections?(section)
        }
    }
}*/
