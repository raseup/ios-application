//
//  NewWorkoutViewControllerTutorialCell.swift
//  RASE
//
//  Created by Sam Beaulieu on 11/14/17.
//  Copyright © 2017 RASE. All rights reserved.
//

import UIKit

class NewWorkoutViewControllerTutorialCell: UITableViewCell {
    
    @IBOutlet weak var ProfileTutorialView: UIView!
    @IBOutlet weak var NotificationsTutorialView: UIView!
    @IBOutlet weak var coachTutorialView: UIView!
    
    @IBOutlet weak var tutorialScrollView: UIScrollView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ProfileTutorialView.layer.cornerRadius = 5
        NotificationsTutorialView.layer.cornerRadius = 5
        coachTutorialView.layer.cornerRadius = 5
        tutorialScrollView.contentInset = UIEdgeInsetsMake(0, 20, 0, 20)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
