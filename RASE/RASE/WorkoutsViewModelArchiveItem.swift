//
//  WorkoutsViewModelArchiveItem.swift
//  RASE
//
//  Created by Sam Beaulieu on 7/31/17.
//  Copyright © 2017 RASE. All rights reserved.
//

import UIKit

/*
// Class for the defense drills
// - Keeps a reference to all the drills as well as to the progress class
// - Allows for row count and updating progress
class WorkoutsViewModelArchiveItem: WorkoutsViewModelItem {
    var type: WorkoutsViewModelItemType {
        return .archive
    }
    var sectionTitle: String {
        return "Archive "
    }
    var rowCount: Int {
        return self.drills.count
    }
    var isCollapsed = true
    
    // References to all the drills as well as the progress summary
    var drills = [DrillSummary]()
    var progress: ProgressManager
    
    // Initialized by setting all the drills and progress to the local references
    init(drills: [DrillSummary], progress: ProgressManager) {
        
        // Add all the completed drills to the list
        for eachDrill in drills {
            if eachDrill.drillCompleted! {
                self.drills.append(eachDrill)
            }
        }
        self.progress = progress
    }
    
    // Called when completing a drill, adds it to the list
    func completeDrill(drill: DrillSummary) {
        drills.append(drill)
    }
    
    // Called when uncompleting a drill, looks through drills and deletes it from the list
    func uncompleteDrill(drill: DrillSummary) {
        
        if let index = drills.index(of: drill) {
            drills.remove(at: index)
        }
    }
}
*/
