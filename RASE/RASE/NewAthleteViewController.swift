//
//  NewAthleteViewController.swift
//  RASE
//
//  Created by Sam Beaulieu on 6/15/17.
//  Copyright © 2017 RASE. All rights reserved.
//

import UIKit
import Foundation

class NewAthleteViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate {
    
    // Variables
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var dateOfBirth: UITextField!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var scrollConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var termsText: UILabel!
    @IBOutlet weak var termsButton: UIButton!
    @IBOutlet weak var helpText: UILabel!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var raseIcon: UIImageView!
    
    var activeTextField: UITextField?
    
    // Activity Indicator for saving new user and alert for failures
    var indicator: ActivityIndicator!
    var alert: UIAlertController!
    
    // Prepare data picker variables
    let dateBirthPicker = UIDatePicker()
    var tempDate: Date!
    
    // Prepare background variables
    var background: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the blur
        let blur = CIFilter(name: "CIGaussianBlur")!
        blur.setValue(CIImage(image: background), forKey: kCIInputImageKey)
        blur.setValue(3.0, forKey: kCIInputRadiusKey)
        let ciContext = CIContext(options: nil)
        let result = blur.value(forKey: kCIOutputImageKey) as! CIImage!
        let cgImage = ciContext.createCGImage(result!, from: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        
        // Set the background image
        let backgroundImageView = UIImageView(image: UIImage(cgImage: cgImage!))
        backgroundImageView.frame = self.view.frame
        self.view.insertSubview(backgroundImageView, at: 0)
        
        // Set the background view
        let darkView = UIView()
        darkView.backgroundColor = backgroundGray
        darkView.alpha = 0.8
        darkView.frame = self.view.frame
        self.view.insertSubview(darkView, aboveSubview: backgroundImageView)
        
        // Initialize activity indicator
        self.indicator = ActivityIndicator(viewController: self)
        let px = 1 / UIScreen.main.scale
        scrollView.delegate = self
        
        // Round the create accound button
        createAccountButton.layer.cornerRadius = 5.0
        
        // Set text field information for email field
        self.emailTextField.delegate = self
        self.emailTextField.returnKeyType = .done
        self.emailTextField.keyboardAppearance = .dark
        self.emailTextField.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSForegroundColorAttributeName: placeHolderWhite])
        let emailBottom = UIView(frame: CGRect(x: emailTextField.frame.minX, y: emailTextField.frame.maxY, width: emailTextField.frame.width, height: px))
        emailBottom.backgroundColor = placeHolderWhite
        self.scrollView.addSubview(emailBottom)
        
        // Set text field information for password field
        self.passwordTextField.tag = 2
        self.passwordTextField.delegate = self
        self.passwordTextField.returnKeyType = .done
        self.passwordTextField.keyboardAppearance = .dark
        self.passwordTextField.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSForegroundColorAttributeName: placeHolderWhite])
        let passwordBottom = UIView(frame: CGRect(x: passwordTextField.frame.minX, y: passwordTextField.frame.maxY, width: passwordTextField.frame.width, height: px))
        passwordBottom.backgroundColor = placeHolderWhite
        self.scrollView.addSubview(passwordBottom)
        
        // Set text field information for first name field
        self.firstNameTextField.delegate = self
        self.firstNameTextField.returnKeyType = .done
        self.firstNameTextField.keyboardAppearance = .dark
        self.firstNameTextField.attributedPlaceholder = NSAttributedString(string: "full name", attributes: [NSForegroundColorAttributeName: placeHolderWhite])
        let firstBottom = UIView(frame: CGRect(x: firstNameTextField.frame.minX, y: firstNameTextField.frame.maxY, width: firstNameTextField.frame.width, height: px))
        firstBottom.backgroundColor = placeHolderWhite
        self.scrollView.addSubview(firstBottom)

        // Prepare the picker view's toolbar
        let pickerBar = UIToolbar(frame:  CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44))
        pickerBar.barTintColor = backgroundGray
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(donePressed))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        pickerBar.setItems([spaceButton, doneButton], animated: true)
        
        // Set date picker
        self.dateBirthPicker.backgroundColor = backgroundGray
        self.dateBirthPicker.datePickerMode = .date
        self.dateBirthPicker.setValue(UIColor.white, forKeyPath: "textColor")
        self.dateBirthPicker.addTarget(self, action:  #selector(dateBirthChanged), for: .valueChanged)
        self.dateOfBirth.delegate = self
        self.dateOfBirth.inputView = self.dateBirthPicker
        self.dateOfBirth.inputAccessoryView = pickerBar
        self.dateOfBirth.attributedPlaceholder = NSAttributedString(string: "date of birth", attributes: [NSForegroundColorAttributeName: placeHolderWhite])
        let dateBottom = UIView(frame: CGRect(x: dateOfBirth.frame.minX, y: dateOfBirth.frame.maxY, width: dateOfBirth.frame.width, height: px))
        dateBottom.backgroundColor = placeHolderWhite
        self.scrollView.addSubview(dateBottom)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // When a text field is selected for editing, update the scroll constraints and set the active field
    func textFieldDidBeginEditing(_ textField: UITextField) { // became first responder
        
        // Set the current text field
        activeTextField = textField
        
        // Animate the constraint so the view can scroll
        if textField.tag == 2 {
            // No toolbar for password so a bit less constraint
            self.scrollConstraint.constant = 216
        }
        else {
            self.scrollConstraint.constant = 260
        }
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    // Dismissal for text fields
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // Close the input view of the responder
        textField.resignFirstResponder()
        
        // Animate the constraint back to 0
        self.scrollConstraint.constant = 0
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
        return true
    }
    
    // Dismissal for picker views
    @objc func donePressed() {
        
        // Close the input view of the responder
        activeTextField?.resignFirstResponder()

        // Animate the constraint back to 0
        self.scrollConstraint.constant = 0
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    // If the date picker is changed, set the date
    @objc func dateBirthChanged(sender:UIDatePicker) {
        tempDate = sender.date
        dateOfBirth.text = dateToStringReadable(date: sender.date)
    }
    
    // Dismiss the page
    @IBAction func closeButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // Present the disclaimer page
    @IBAction func disclaimerButtonPressed(_ sender: UIButton) {
        
        // Generates the background image
        UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, true, 1)
        self.view.drawHierarchy(in: self.view.bounds, afterScreenUpdates: true)
        let screen = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // Presents the view
        let vc = TermsAndConditionsViewController(nibName: "TermsAndConditionsView", bundle: nil)
        vc.background = screen
        self.present(vc, animated: true, completion: nil)
    }

    @IBAction func createNewUser(_ sender: UIButton) {
        
        // Start progress indicator
        self.indicator.startAnimator()
        
        // First do error checking
        if emailTextField.text == "" || emailTextField.text!.range(of: "@") == nil {
            failureHandler(message: "Please enter a valid email address.")
            return
        }
        if passwordTextField.text == nil {
            failureHandler(message: "Please enter a password.")
            return
        }
        
        // Checks to see if the password has at least:
        // - 8 characters
        // - 1 uppercase
        // - 1 lowercase
        // - 1 number
        let regex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[A-Za-z\\d]{8,}"
        let isMatched = NSPredicate(format:"SELF MATCHES %@", regex).evaluate(with: passwordTextField.text)
        if !isMatched {
            failureHandler(message: "Passwords must be at least 8 character and have at least one uppercase letter, one lowercase letter, and one number.")
            return
        }
        
        // Checks that a valid name has been entered
        // - Must have first and last
        if firstNameTextField.text == "" {
            failureHandler(message: "Please enter your name.")
            return
        }
        var lastName: String = ""
        var firstName: String = ""
        let nameTrimmed = firstNameTextField.text!.trimmingCharacters(in: .whitespaces)
        let nameSplit = nameTrimmed.split(separator: " ", maxSplits: 1, omittingEmptySubsequences: true)
        
        if nameSplit.count == 1 {
            failureHandler(message: "Please enter a last name.")
            return
        }
        if nameSplit.count != 2 {
            failureHandler(message: "Please enter your name as 'First Last'.")
            return
        }
        firstName = String(nameSplit[0])
        lastName = String(nameSplit[1])
        
        // Checks date of birth
        if dateOfBirth.text == "" && Int(dateOfBirth.text!) == 0 {
            failureHandler(message: "Please select your birth of date.")
            return
        }
        
        // Prepares request and sends create user request
        let userInfo = ["email": emailTextField.text!,
                        "password": passwordTextField.text!,
                        "first": firstName,
                        "last": lastName,
                        "dateBirth": dateToString(date: tempDate),
                        "days" : "2",
                        "recieve": "true"]
        
        createUser(user: userInfo, success: successHandler, failure: failureHandler)
    }

    // Upon failure, display an error message
    func failureHandler(message: String) -> Void {
        
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

    // Upon success, remove the spinner and dismiss to the logged in view
    func successHandler() -> Void {
        
        // Remove the spinner and dismiss the page
        DispatchQueue.main.async {
            self.indicator.removeIndicator()
            self.dismiss(animated: true, completion: nil)
        }
    }
}
