//
//  NewWorkoutViewModelTutorialItem.swift
//  RASE
//
//  Created by Sam Beaulieu on 11/14/17.
//  Copyright © 2017 RASE. All rights reserved.
//

import UIKit

// Class for the get tutorial item
// - Conforms to NewWorkoutViewModelItem protocol
// - Always has only one cell
class NewWorkoutViewModelTutorialtItem: NewWorkoutViewModelItem {
    var type: NewWorkoutViewModelItemType {
        return .tutorial
    }
    var sectionTitle: String {
        return "Tutorial"
    }
    
    // Initialize the item and set the local variables
    init() { }
}
