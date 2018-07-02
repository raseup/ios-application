//
//  FeedbackViewSubmissionItem.swift
//  RASE
//
//  Created by Sam Beaulieu on 9/10/17.
//  Copyright © 2017 RASE. All rights reserved.
//

import UIKit

// Class for the submission item which contains the submission button for the feedback page
// - Always has only one cell
class FeedbackViewSubmissionItem: FeedbackViewModelItem {
    var type: FeedbackCellType {
        return .submission
    }
    
    // Initialize the header item
    init() {
    }
}
