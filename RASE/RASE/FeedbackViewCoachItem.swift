//
//  FeedbackViewCoachItem.swift
//  RASE
//
//  Created by Sam Beaulieu on 9/11/17.
//  Copyright © 2017 RASE. All rights reserved.
//

import UIKit

// Class for the coach item which contains the coach rating feedback
// - Always has only one cell
class FeedbackViewCoachItem: FeedbackViewModelItem {
    var type: FeedbackCellType {
        return .coach
    }
    
    var rowCount: Int {
        return coachNames.count
    }
    
    var coachNames = [String]()
    var coachCodes = [Int]()
    
    // Initialize the coach item
    init(coaches: [String], codes: [Int]) {
        
        for each in coaches {
            self.coachNames.append(each)
        }
        for each in codes {
            self.coachCodes.append(each)
        }
    }
}
