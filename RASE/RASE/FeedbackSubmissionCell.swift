//
//  FeedbackSubmissionCell.swift
//  RASE
//
//  Created by Sam Beaulieu on 9/10/17.
//  Copyright © 2017 RASE. All rights reserved.
//

import UIKit

// View Controller for the submission cell
class FeedbackSubmissionCell: UITableViewCell {

    @IBOutlet weak var submitButton: UIButton!
    
    var submit: (() -> Void)!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        submitButton.layer.cornerRadius = 5.0
    }
    
    @IBAction func submitPressed(_ sender: UIButton) {
        submit()
    }
}
