//
//  FeedbackViewDrillsItem.swift
//  RASE
//
//  Created by Sam Beaulieu on 9/10/17.
//  Copyright © 2017 RASE. All rights reserved.
//

import UIKit

// Class for the drill item which contains the drill info for the feedback page
class FeedbackViewDrillItem: FeedbackViewModelItem {
    var type: FeedbackCellType {
        return .drill
    }
    var rowCount: Int {
        return drillTypes.count
    }
    
    var drillTypes = [DrillType]()
    
    // Initialize the header item
    init(drillTypes: [DrillType]) {
        
        for each in drillTypes {
            self.drillTypes.append(each)
        }
        
    }
}
