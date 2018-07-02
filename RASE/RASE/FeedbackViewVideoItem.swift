//
//  FeedbackViewVideoItem.swift
//  RASE
//
//  Created by Sam Beaulieu on 9/10/17.
//  Copyright © 2017 RASE. All rights reserved.
//

import UIKit

// Class for the video upload item which contains the video upload for the feedback page
// - Always has only one cell
class FeedbackViewVideoItem: FeedbackViewModelItem {
    var type: FeedbackCellType {
        return .video
    }
    
    // Initialize the header item
    init() {
    }
}
