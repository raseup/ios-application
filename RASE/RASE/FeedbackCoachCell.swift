//
//  FeedbackCoachCell.swift
//  RASE
//
//  Created by Sam Beaulieu on 9/11/17.
//  Copyright © 2017 RASE. All rights reserved.
//

import UIKit
/*
// View Controller for the coach Cell
class FeedbackCoachCell: UITableViewCell, StarRatingControlDelegate {
    
    @IBOutlet weak var ratingPlacement: UIView!
    @IBOutlet weak var coachPromptLabel: UILabel!
    
    var starRatingControl: StarRatingControl?
    var coachCode: Int!
    
    var coachName: String! {
        didSet {
            coachPromptLabel.text = "How would you rate Coach " + coachName + "?"
        }
    }
    
    var feedback: Feedback! {
        didSet {
            starRatingControl = StarRatingControl(frame: ratingPlacement.frame)
            starRatingControl!.canEdit = true
            starRatingControl?.delegate = self
            self.addSubview(starRatingControl!)
        }
    }
    
    // Returns the rating when updated
    func starRatingControl(_ ratingView: StarRatingControl, didUpdate rating: Float){
        feedback.coachRating[coachCode] = Double(rating)
    }
}
*/
