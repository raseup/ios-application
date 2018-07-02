//
//  FeedbackViewModelItem.swift
//  RASE
//
//  Created by Sam Beaulieu on 9/10/17.
//  Copyright © 2017 RASE. All rights reserved.
//

import UIKit

// Protocol for each section to conform to
// - Each needs a type, a row count, and a title
protocol FeedbackViewModelItem {
    var type: FeedbackCellType { get }
    var rowCount: Int { get }
}

// Extention to FeedbackViewModelItem protocol to add a default row count
extension FeedbackViewModelItem {
    var rowCount: Int {
        return 1
    }
}

// Enum to maintain types of feedback view sections
// - Each of these types will correlate to one section in the feedback table view
enum FeedbackCellType {
    case header
    case drill
    case video
    case coach
    case submission
}

