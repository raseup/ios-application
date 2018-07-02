//
//  FeedbackViewHeaderItem.swift
//  RASE
//
//  Created by Sam Beaulieu on 9/10/17.
//  Copyright © 2017 RASE. All rights reserved.
//

import UIKit

// Class for the header item which contains the header info for the feedback page
// - Always has only one cell
class FeedbackViewHeaderItem: FeedbackViewModelItem {
    var type: FeedbackCellType {
        return .header
    }
    
    // Initialize the header item
    init() {
    }
}
