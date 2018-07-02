//
//  FeedbackDrillCell.swift
//  RASE
//
//  Created by Sam Beaulieu on 9/10/17.
//  Copyright © 2017 RASE. All rights reserved.
//

import UIKit
/*
// View Controller for the drill Cell
// - Once variable is set, it sets the views variables
class FeedbackDrillCell: UITableViewCell {
    
    @IBOutlet weak var drillFeedbackLabel: UILabel!
    @IBOutlet weak var thumbsUpImage: UIImageView!
    @IBOutlet weak var thumbsDownImage: UIImageView!

    var feedback: Feedback!
    var state = 0
    
    var drillType: DrillType! {
        didSet {
            
            // Set the label
            drillFeedbackLabel.text = "How were the " + drillType.rawValue + " drills?"
            
            // Add touch events for both images
            let tapThumbsUp = UITapGestureRecognizer(target: self, action:  #selector(thumbsUp))
            thumbsUpImage.addGestureRecognizer(tapThumbsUp)
            thumbsUpImage.isUserInteractionEnabled = true
            let tapThumbsDown = UITapGestureRecognizer(target: self, action:  #selector(thumbsDown))
            thumbsDownImage.addGestureRecognizer(tapThumbsDown)
            thumbsDownImage.isUserInteractionEnabled = true
        }
    }
    
    @objc func thumbsUp() {
        
        // If not thumbs up, make thumbs up selected, thumbs down not
        if state != 1 {
            thumbsUpImage.image = #imageLiteral(resourceName: "Selected-Thumb")
            thumbsDownImage.image = #imageLiteral(resourceName: "Unselected-Down-Thumb")
            state = 1
            feedback.drillTypes[drillType] = 1
        }
        // Else if thumbs up, make neither thumbs selected
        else {
            thumbsUpImage.image = #imageLiteral(resourceName: "Unselected-Thumb")
            thumbsDownImage.image = #imageLiteral(resourceName: "Unselected-Down-Thumb")
            state = 0
            feedback.drillTypes[drillType] = 0
        }
    }
    
    @objc func thumbsDown() {
        
        // If not thumbs down, make thumbs down selected, thumbs up not
        if state != -1 {
            thumbsDownImage.image = #imageLiteral(resourceName: "Selected-Down-Thumb")
            thumbsUpImage.image = #imageLiteral(resourceName: "Unselected-Thumb")
            state = -1
            feedback.drillTypes[drillType] = -1
        }
            // Else if thumbs down, make neither thumbs selected
        else {
            thumbsDownImage.image = #imageLiteral(resourceName: "Unselected-Down-Thumb")
            thumbsUpImage.image = #imageLiteral(resourceName: "Unselected-Thumb")
            state = 0
            feedback.drillTypes[drillType] = 0
        }
    }
}*/
