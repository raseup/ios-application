//
//  WorkoutsViewControllerEquipmentCell.swift
//  RASE
//
//  Created by Sam Beaulieu on 7/31/17.
//  Copyright © 2017 RASE. All rights reserved.
//

import UIKit
/*
// View Controller for the Equipment Cell
// - Once variable is set, it sets the views variables
class WorkoutsViewControllerEquipmentCell: UITableViewCell {
    
    @IBOutlet weak var equipment00: UILabel!
    @IBOutlet weak var equipment01: UILabel!
    @IBOutlet weak var equipment10: UILabel!
    @IBOutlet weak var equipment11: UILabel!
    @IBOutlet weak var equipment12: UILabel!
    
    var item: WorkoutsViewModelItem? {
        didSet {
            // cast the WorkoutsViewModelItem to appropriate item type
            guard let item = item as? WorkoutsViewModelEquipmentItem  else {
                return
            }
            
            // Set the days equipment labels
            switch item.equipment.count {
                case 0:
                    equipment00.text = ""
                    equipment01.text = ""
                    equipment10.text = ""
                    equipment11.text = "None Required"
                    equipment12.text = ""
                    break
                case 1:
                    equipment00.text = ""
                    equipment01.text = ""
                    equipment10.text = ""
                    equipment11.text = "\(String(item.equipment[0].quantity!)) x \(item.equipment[0].name!)"
                    equipment12.text = ""
                    break
                case 2:
                    equipment00.text = "\(String(item.equipment[0].quantity!)) x \(item.equipment[0].name!)"
                    equipment01.text = "\(String(item.equipment[1].quantity!)) x \(item.equipment[1].name!)"
                    equipment10.text = ""
                    equipment11.text = ""
                    equipment12.text = ""
                    break
                case 3:
                    equipment00.text = ""
                    equipment01.text = ""
                    equipment10.text = "\(String(item.equipment[0].quantity!)) x \(item.equipment[0].name!)"
                    equipment11.text = "\(String(item.equipment[1].quantity!)) x \(item.equipment[1].name!)"
                    equipment12.text = "\(String(item.equipment[2].quantity!)) x \(item.equipment[2].name!)"
                    break
                default:
                    equipment00.text = ""
                    equipment01.text = ""
                    equipment10.text = ""
                    equipment11.text = ""
                    equipment12.text = ""
                    break
            }
            
        }
    }
    
}
*/
