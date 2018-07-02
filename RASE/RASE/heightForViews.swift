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

extension UILabel {
    var fontSize: CGFloat {
        get {
            if adjustsFontSizeToFitWidth {
                var currentFont: UIFont = font
                let originalFontSize = currentFont.pointSize
                var currentSize: CGSize = (text! as NSString).size(attributes: [NSFontAttributeName: currentFont])
                
                while currentSize.width > frame.size.width && currentFont.pointSize > (originalFontSize * minimumScaleFactor) {
                    currentFont = currentFont.withSize(currentFont.pointSize - 1)
                    currentSize = (text! as NSString).size(attributes: [NSFontAttributeName: currentFont])
                }
                
                return currentFont.pointSize
            }
            
            return font.pointSize
        }
    }
}
