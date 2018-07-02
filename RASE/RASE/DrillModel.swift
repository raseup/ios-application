//
//  DrillsModel.swift
//  RASE
//
//  Created by Sam Beaulieu on 7/24/17.
//  Copyright © 2017 RASE. All rights reserved.
//

import UIKit

enum DrillType: String {
    case defense = "Defense"
    case passing = "Passing"
    case shooting = "Shooting"
    case ballHandling = "Ball Handling"
    case finishing = "Finishing"
}

// Class object to hold a summary of a specific drill
// - Each drill has a name, sets, reps, urls, type, and completed value
class DrillSummary {
    
    // Only setable during creation - otherwise constant and readonly
    public private(set) var drillName: String!
    public private(set) var drillSetsAndReps: String!
    public private(set) var videoURL: String!
    public private(set) var drillType: DrillType!
    public private(set) var drillCode: Int!
    
    // Only setable during creation and member functions - otherwise constant and readonly
    public private(set) var daysCompleted = [String]()
    public private(set) var locallyChanged: Bool!
    
    // Setable by anyone, anywhere
    var thumbnail: UIImage! {
        didSet {
            imagesChanged = true
            if updateDBAutomatically {
                updateDatabase()
            }
        }
    }
    var updateDBAutomatically: Bool = false
    var imagesChanged: Bool = false
    
    // Initialize a drill in a workout
    // - Each workout should have a name, sets, reps, video_url, and image_url
    init(name: String, setsAndReps: String, url: String, thumbnail: UIImage, type: DrillType, code: Int, daysCompleted: [String] = [], locallyChanged: Bool = false, autoUpdate: Bool = true) {
        
        // Set drill name
        self.drillName = name
        
        // Set drill sets
        self.drillSetsAndReps = setsAndReps
        
        // Set drill url
        self.videoURL = url
        
        // Set drill thumbnail
        self.thumbnail = thumbnail
        
        // Set drill type
        self.drillType = type
        
        // Set drill code
        self.drillCode = code
        
        // Set the days completed
        self.daysCompleted = daysCompleted
        
        // Set locally changed data
        self.locallyChanged = locallyChanged
        
        // Update on changes
        self.updateDBAutomatically = autoUpdate
    }
    
    // When the completion function is called, add the date it was completed to the array
    func setComplete() -> Int {
        daysCompleted.append(dateToString(date: Date()))
        locallyChanged = true
        if updateDBAutomatically { updateDatabase() }
        return 0
    }
    
    // When the uncomplete function is called, remove the date it was completed from the array if there
    func setUncomplete() -> Int {
        daysCompleted = daysCompleted.filter{$0 != dateToString(date: Date())}
        locallyChanged = true
        if updateDBAutomatically { updateDatabase() }
        return 0
    }
    
    // Update the current drill in the database asynchronously with a background thread
    func updateDatabase() {
        DispatchQueue.global(qos: .background).async {
            if !RASEDB.instance.updateDrill(drill: self) {
                _ = RASEDB.instance.addDrill(newDrill: self)
            }
        }
    }
}

extension DrillSummary: Equatable {
    static func == (lhs: DrillSummary, rhs: DrillSummary) -> Bool {
        return lhs.drillCode! == rhs.drillCode!
    }
}
