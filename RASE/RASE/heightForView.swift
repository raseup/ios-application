//
//  heightForView.swift
//  RASE
//
//  Created by Sam Beaulieu on 11/16/17.
//  Copyright © 2017 RASE. All rights reserved.
//
// From: https://stackoverflow.com/questions/25180443/adjust-uilabel-height-to-text

import UIKit

func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
    let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
    label.numberOfLines = 0
    label.lineBreakMode = NSLineBreakMode.byWordWrapping
    label.font = font
    label.text = text
    label.sizeToFit()
    
    return label.frame.height
}

extension UIFont {
    func sizeOfString (string: String, constrainedToWidth width: Double) -> CGSize {
        return NSString(string: string).boundingRect(with:  CGSize(width: width, height: Double.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: self], context: nil).size
    }
}
