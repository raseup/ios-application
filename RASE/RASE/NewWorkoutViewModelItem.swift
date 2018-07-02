//
//  NewWorkoutViewModelItem.swift
//  RASE
//
//  Created by Sam Beaulieu on 11/13/17.
//  Copyright © 2017 RASE. All rights reserved.
//

import UIKit

// Protocol for each section to conform to
// - Each needs a type, a row count, and a title
protocol NewWorkoutViewModelItem {
    var type: NewWorkoutViewModelItemType { get }
    var rowCount: Int { get }
    var sectionTitle: String  { get }
}

// Extention to NewWorkoutViewModelItem protocol to add a default row count
extension NewWorkoutViewModelItem {
    var rowCount: Int {
        return 1
    }
}

// Enum to maintain types of new workout cells
// - Each of these types will correlate to one section in the table view
enum NewWorkoutViewModelItemType {
    case welcome
    case tutorial
    case buffer
}
