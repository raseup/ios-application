//
//  RecoverPasswordViewController.swift
//  RASE
//
//  Created by Sam Beaulieu on 9/20/17.
//  Copyright © 2017 RASE. All rights reserved.
//

import UIKit

class RecoverPasswordViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var raseIcon: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var helpText: UILabel!
    
    var indicator: ActivityIndicator!
    var alert: UIAlertController!
    
    var background: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the background to the image
        self.view.backgroundColor = UIColor.clear
        
        // Adds the background blur
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = UIScreen.main.bounds
        self.view.insertSubview(blurEffectView, at: 0)
        
        let px = 1 / UIScreen.main.scale
        
        // Set text field information for email field
        emailTextField.keyboardAppearance = .dark
        emailTextField.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSForegroundColorAttributeName: placeHolderWhite])
        emailTextField.returnKeyType = .done
        let emailBottom = UIView(frame: CGRect(x: emailTextField.frame.minX, y: emailTextField.frame.maxY + 1, width: emailTextField.frame.width, height: px))
        emailBottom.backgroundColor = placeHolderWhite
        self.view.addSubview(emailBottom)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // Set the indicator
        indicator = ActivityIndicator(viewController: self)
        submitButton.layer.cornerRadius = 5.0
        
        // Sets the background image - done here to get correct screen size
        let backgroundImageView = UIImageView(image: background)
        backgroundImageView.frame = UIScreen.main.bounds
        self.view.insertSubview(backgroundImageView, at: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // Dismiss the reset password page
    @IBAction func dismissButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    // Fire off the request
    @IBAction func sendLinkButtonPressed(_ sender: UIButton) {
        
        // Start activity indicator
        self.indicator.startAnimator()
        
        // Check to ensure something has been entered in the text feild
        if let email = self.emailTextField.text,
            email.range(of: "@") != nil,
            email.components(separatedBy: "@")[1].range(of: ".") != nil {
            
            
            resetPassword(email: email, success: self.success, failure: self.failure)
        }
        // If the email is not valid show an alert
        else {
            self.indicator.removeSpinner()
            
            alert = UIAlertController(title: "Error", message: "Please enter a valid email address.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                self.indicator.removeBackground()
            }))
            
            self.present(self.alert, animated: true)
        }
    }
    
    // Present an alert indicating success then dismiss the view
    func success() -> Void {
        
        // Create the alert
        alert = UIAlertController(title: "Success", message: "The request has been sent; you should recieve an email soon.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            self.indicator.removeBackground()
            self.dismiss(animated: true, completion: nil)
        }))
        
        // Remove the spinner and present the alert
        DispatchQueue.main.async {
            self.indicator.removeSpinner()
            self.present(self.alert, animated: true)
        }
    }
    
    // Request for email failed - stop the spinning and display the message
    func failure(message: String) -> Void {
        
        // Create the alert
        alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            self.indicator.removeBackground()
        }))
        
        // Remove the spinner and present the alert
        DispatchQueue.main.async {
            self.indicator.removeSpinner()
            self.present(self.alert, animated: true)
        }
    }
}
