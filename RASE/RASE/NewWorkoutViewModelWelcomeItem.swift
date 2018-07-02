//
//  NewWorkoutViewModelWelcomeItem.swift
//  RASE
//
//  Created by Sam Beaulieu on 11/13/17.
//  Copyright © 2017 RASE. All rights reserved.
//

import UIKit

// Class for the welcome item 
// - Conforms to NewWorkoutViewModelItem protocol
// - Always has only one cell
class NewWorkoutViewModelWelcomeItem: NewWorkoutViewModelItem {
    var type: NewWorkoutViewModelItemType {
        return .welcome
    }
    var sectionTitle: String {
        return "Welcome"
    }
    
    // Initialize the item and set the local variables
    init() {    }
}

