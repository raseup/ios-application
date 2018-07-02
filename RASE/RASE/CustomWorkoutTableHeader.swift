//
//  File.swift
//  RASE
//
//  Created by Sam Beaulieu on 7/27/17.
//  Copyright © 2017 RASE. All rights reserved.
//

import UIKit
import Foundation
/*
// View Controller for the dynamic headers
class CustomWorkoutTableHeader: UITableViewHeaderFooterView {
    
    @IBOutlet weak var sectionTitleLabel: UILabel!
    @IBOutlet weak var arrowLabel: UILabel!
    
    var section: Int = 0
    weak var delegate: CustomWorkoutTableHeaderDelegate?
    
    var item: WorkoutsViewModelItem! {
        didSet {
            sectionTitleLabel?.text = item.sectionTitle
            collapse(collapsed: item.isCollapsed)
            
            // Add top and bottom lines to the header
            let px = 1 / UIScreen.main.scale
            let top = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: px))
            top.backgroundColor = .white
            self.addSubview(top)
            let bottom = UIView(frame: CGRect(x: 0, y: self.frame.height-1, width: self.frame.width, height: px))
            bottom.backgroundColor = .white
            self.addSubview(bottom)
        }
    }
    
    func collapse(collapsed: Bool) {
        arrowLabel?.rotate(collapsed ? -.pi/2 : 0.0)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(headerTapped)))
    }
    
    @objc private func headerTapped(gestureRecognizer: UITapGestureRecognizer) {
        delegate?.toggleSection(header: self, section: section)
    }
    
}

protocol CustomWorkoutTableHeaderDelegate: class {
    func toggleSection(header: CustomWorkoutTableHeader, section: Int)
}

extension UIView {
    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        self.layer.add(animation, forKey: nil)
    }
}*/
