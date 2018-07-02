//
//  WorkoutsViewModelDrillItem.swift
//  RASE
//
//  Created by Sam Beaulieu on 1/24/18.
//  Copyright © 2018 RASE. All rights reserved.
//

import Foundation

/*
// Class for the fundamental drills
// - Keeps a reference to all the drills as well as to the progress class
// - Allows for row count and updating progress
class WorkoutsViewModelDrillItem: WorkoutsViewModelItem {
    var type: WorkoutsViewModelItemType {
        return .fundamentals
    }
    var sectionTitle: String {
        return "Drill"
    }
    var rowCount: Int {
        return self.drills.count
    }
    var isCollapsed = false
    
    // References to all the drills as well as the progress summary
    var drills = [DrillSummary]()
    var progress: ProgressManager
    
    // Initialized by setting all the drills and progress to the local references
    init(drills: [DrillSummary], progress: ProgressManager, type: DrillType) {
        
        // Add the fundamental drills to the drill list
        for eachDrill in drills{
            if eachDrill.drillType == type && !eachDrill.drillCompleted! {
                self.drills.append(eachDrill)
            }
        }
        
        // Set the progress variable
        self.progress = progress
    }
    
    // When a drill is completed, set its completed variable, update progress, and remove from drill array
    func complete(drill: DrillSummary) {
        
        // Complete the drill
        _ = drill.complete()
        
        // Update progress
        _ = progress.completeADrill(type: drill.drillType)
        
        // Remove from local drills
        if let index = drills.index(of: drill) {
            drills.remove(at: index)
        }
    }
    
    func uncomplete(drill: DrillSummary) {
        
        // Uncomplete the drill
        _ = drill.uncomplete()
        
        // Update progress
        _ = progress.uncompleteADrill(type: drill.drillType)
        
        // Add to local drills
        drills.append(drill)
    }
}*/
