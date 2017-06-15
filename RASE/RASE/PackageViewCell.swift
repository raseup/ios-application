//
//  PackageViewCell.swift
//  RASE
//
//  Created by Sam Beaulieu on 6/14/17.
//  Copyright © 2017 RASE. All rights reserved.
//

import UIKit

class PackageViewCell: UITableViewCell {
    
    // MARK: Properties
    
    @IBOutlet weak var packageTitle: UILabel!
    @IBOutlet weak var packageDescription: UITextView!
    @IBOutlet weak var packageQuantity: UITextField!
    @IBOutlet weak var packageStepper: UIStepper!
    @IBOutlet weak var packageImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func stepperPressed(_ sender: UIStepper) {
        
        packageQuantity.text = String(Int(packageStepper.value))
    }
    
    @IBAction func quantityEdited(_ sender: UITextField) {
        if(packageQuantity.text != nil)
        {
            if(Double(packageQuantity.text!) != nil)
            {
                packageStepper.value = Double(packageQuantity.text!)!
            }
        }
    }
}

