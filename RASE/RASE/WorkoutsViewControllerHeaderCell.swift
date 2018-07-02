//
//  WorkoutsViewControllerHeaderCell.swift
//  RASE
//
//  Created by Sam Beaulieu on 7/27/17.
//  Copyright © 2017 RASE. All rights reserved.
//

import UIKit
/*
// View Controller for the Header Cell
// - Once variable is set, it sets the views variables
class WorkoutsViewControllerHeaderCell: UITableViewCell {
    
    @IBOutlet weak var daysLeft: UILabel!
    var item: WorkoutsViewModelItem? {
        didSet {
            // cast the WorkoutsViewModelItem to appropriate item type
            guard let item = item as? WorkoutsViewModelHeaderItem  else {
                return
            }
            
            // Set the days left amount
            if item.daysLeft < 0 {
                daysLeft.text = "N/A"
            }
            else {
                daysLeft.text = String(item.daysLeft)
            }
            
            // Add popover view
            let moreInfo: UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width / 3, height: self.frame.height / 3))
            moreInfo.center = self.center
            moreInfo.backgroundColor = .clear
            self.addSubview(moreInfo)
            
            // Make the popover view clickable
            let tap = UITapGestureRecognizer(target: self, action: #selector(moreInfoTapped))
            moreInfo.isUserInteractionEnabled = true
            moreInfo.addGestureRecognizer(tap)
        }
    }
    
    var parent: HomeViewController!
    
    @objc func moreInfoTapped() {
        let vc = PopoverViewController(title: "How To", text: "   This is your homepage. On this page, you'll see your workout and how many days you have left to complete it. View drills by tapping on them. When you've completed one, swipe it left. You can see your completed drills in the archive at the bottom. Try to complete the full workout each time you workout.", width: Int(self.frame.width - 40), center: parent.view.center)
        parent.present(vc, animated: true, completion: nil)
    }
    
}
*/
