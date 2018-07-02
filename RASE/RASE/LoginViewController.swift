//
//  LoginViewController.swift
//  RASE
//
//  Created by Sam Beaulieu on 6/12/17.
//  Copyright © 2017 RASE. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController, UITextFieldDelegate  {
    
    // Variables
    @IBOutlet weak var raseIcon: UIImageView!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var termsText: UILabel!
    @IBOutlet weak var termsButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    // In case there is an error creating new user
    var alert: UIAlertController!
    var indicator: ActivityIndicator!
    
    // Local variable for the background image
    var background: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Set the background to the image
        self.view.backgroundColor = UIColor.clear
        loginButton.layer.cornerRadius = 5.0
        
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
        
        // Add the background view
        let darkView = UIView()
        darkView.backgroundColor = backgroundGray
        darkView.alpha = 0.8
        darkView.frame = self.view.frame
        self.view.insertSubview(darkView, aboveSubview: backgroundImageView)
        
        // Prepare the activity indicator and the alerts
        indicator = ActivityIndicator(viewController: self)
        let px = 1 / UIScreen.main.scale
        
        // Prepare the email text field
        emailTextField.keyboardAppearance = .dark
        emailTextField.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSForegroundColorAttributeName: placeHolderWhite])
        emailTextField.returnKeyType = .done
        emailTextField.delegate = self
        let emailBottom = UIView(frame: CGRect(x: emailTextField.frame.minX, y: emailTextField.frame.maxY, width: emailTextField.frame.width, height: px))
        emailBottom.backgroundColor = placeHolderWhite
        self.view.addSubview(emailBottom)
        
        // Prepare the password text field
        passwordTextField.keyboardAppearance = .dark
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSForegroundColorAttributeName: placeHolderWhite])
        passwordTextField.returnKeyType = .done
        passwordTextField.delegate = self
        let passbottom = UIView(frame: CGRect(x: passwordTextField.frame.minX, y: passwordTextField.frame.maxY, width: passwordTextField.frame.width, height: px))
        passbottom.backgroundColor = placeHolderWhite
        self.view.addSubview(passbottom)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if RASEDB.instance.getPrimaryUser() != nil {
            self.dismiss(animated: false, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }

    // Dismiss button pressed
    @IBAction func closeLoginButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // Join now button pressed
    @IBAction func joinNowButtonPressed(_ sender: Any) {
        let vc = NewAthleteViewController(nibName: "NewAthleteViewController", bundle: nil)
        vc.background = self.background
        self.present(vc, animated: true, completion: nil)
    }
    
    // Presents the disclaimer page
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
    
    // Presents the forgot password page
    @IBAction func forgotPasswordButtonPressed(_ sender: UIButton) {
        
        // Generates the background image
        UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, true, 1)
        self.view.drawHierarchy(in: self.view.bounds, afterScreenUpdates: true)
        let screen = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // Presents the view
        let vc = RecoverPasswordViewController(nibName: "RecoverPasswordView", bundle: nil)
        vc.background = screen
        self.present(vc, animated: true, completion: nil)
    }
    
    // Attempts to log in
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
        // Prepare for the login fetch
        indicator.startAnimator()
        
        // Error check the input fields
        if emailTextField.text == "" || emailTextField.text!.range(of: "@") == nil || emailTextField.text!.components(separatedBy: "@")[1].range(of: ".") == nil{
            failureHandler(message: "Please enter a valid email address.")
            return
        }
        if passwordTextField.text == "" {
            failureHandler(message: "Please enter your password.")
            return
        }
        
        // Send the login request
        login(email: emailTextField.text!, password: passwordTextField.text!, success: successHandler, failure: failureHandler)
    }
    
    // Upon failure, show an error message
    func failureHandler(message: String) -> Void {
        
        // Create the alert
        alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            self.indicator.removeBackground()
        }))
        
        DispatchQueue.main.async(){
            self.indicator.removeSpinner()
            self.present(self.alert, animated: true)
        }
    }
    
    // Upon success, dismiss and send to the logged in view
    func successHandler() -> Void {
        DispatchQueue.main.async(){
            self.indicator.removeIndicator()
            self.dismiss(animated: true, completion: nil)
        }
        print("Login Success")
    }
}

