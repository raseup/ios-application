//
//  NewWorkoutViewModelBufferItem.swift
//  RASE
//
//  Created by Sam Beaulieu on 11/14/17.
//  Copyright © 2017 RASE. All rights reserved.
//

import UIKit

// Class for the get buffer item
// - Conforms to NewWorkoutViewModelItem protocol
// - Always has only one cell
class NewWorkoutViewModelBufferItem: NewWorkoutViewModelItem {
    var type: NewWorkoutViewModelItemType {
        return .buffer
    }
    var sectionTitle: String {
        return "Buffer"
    }
    
    // Initialize the item and set the local variables
    init() { }
}
