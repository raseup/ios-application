//
//  PopoverViewController.swift
//  RASE
//
//  Created by Sam Beaulieu on 2/10/18.
//  Copyright © 2018 RASE. All rights reserved.
//

import UIKit

class PopoverViewController: UIViewController {
    
    var popoverTitle: String?
    var popoverText: String?
    var popoverWidth: Int!
    var popoverCenter: CGPoint!
    
    init(title: String?, text: String?, width: Int, center: CGPoint)
    {
        super.init(nibName: "popoverViewController", bundle: nil)
        self.modalPresentationStyle = .overFullScreen
        self.modalTransitionStyle = .crossDissolve
        
        popoverTitle = title
        popoverText = text
        popoverWidth = width
        popoverCenter = center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add the tap gesture to background
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissPopover))
        let dismiss = UIView(frame: self.view.frame)
        dismiss.addGestureRecognizer(tap)
        self.view.addSubview(dismiss)
        
        // Create the title label
        let titleLabel = UILabel()
        titleLabel.font = UIFont(name: "TradeGothicLT-Bold", size: 20)
        titleLabel.text = popoverTitle
        titleLabel.textAlignment = .center
        titleLabel.textColor = workoutOrange
        titleLabel.frame = CGRect(x: 12, y: 10, width: popoverWidth - 10, height: 20)
        
        // Create the text label
        let textLabel = UILabel()
        textLabel.font = UIFont(name: "MSReferenceSansSerif", size: 15)
        textLabel.text = popoverText
        textLabel.textColor = .white
        textLabel.textAlignment = .justified
        textLabel.numberOfLines = 0
        var y_text = 5
        if popoverTitle != nil { y_text += 30}
        var height_text = 0
        if popoverText != nil { height_text += Int(heightForView(text: popoverText!, font: textLabel.font, width: CGFloat(popoverWidth - 20))) }
        textLabel.frame = CGRect(x: 12, y: y_text, width: popoverWidth - 20, height: height_text)
        
        // Calculate the height
        let height = 12 + y_text + height_text
        
        // Create the view
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let mainView = UIVisualEffectView(effect: blurEffect)
        mainView.frame = CGRect(x: 0, y: 0, width: popoverWidth, height: height)
        mainView.center = popoverCenter
        mainView.layer.cornerRadius = 15
        mainView.clipsToBounds = true

        // Add the title and text labels
        if popoverTitle != nil {
            mainView.contentView.addSubview(titleLabel)
        }
        if popoverText != nil {
            mainView.contentView.addSubview(textLabel)
        }
        self.view.addSubview(mainView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func dismissPopover() {
        self.dismiss(animated: true, completion: nil)
    }
}
