//
//  LoginViewController.swift
//  RASE
//
//  Created by Sam Beaulieu on 6/12/17.
//  Copyright © 2017 RASE. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    // Activity Indicator for saving new user
    let spinner: UIActivityIndicatorView = UIActivityIndicatorView()
    var progressContainer: UIView = UIView()
    
    // In case there is an error creating new user
    let alert = UIAlertController(title: "Error", message: "There was a problem logging in. Please try again.", preferredStyle: UIAlertControllerStyle.alert)
    
    let alert2 = UIAlertController(title: "Error", message: "Please enter text for the email, password, and name fields and select values for age and position.", preferredStyle: UIAlertControllerStyle.alert)

    
    var newAthlete: Athlete = Athlete(email: "", password: "", first_name: "", last_name: "", age: 1, position: "", recieve_latest: 1, token: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.alert2.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            // Enable all interactions underneath
            self.emailTextField.isEnabled = true
            self.passwordTextField.isEnabled = true
            self.loginButton.isEnabled = true
            
            self.progressContainer.removeFromSuperview()
        }))
        self.alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            // Enable all interactions underneath
            self.emailTextField.isEnabled = true
            self.passwordTextField.isEnabled = true
            self.loginButton.isEnabled = true
            
            self.progressContainer.removeFromSuperview()
        }))

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func closeLoginButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func showActivityIndicator() {
        
        // Disable all interactions underneath
        self.emailTextField.isEnabled = false
        self.passwordTextField.isEnabled = false
        self.loginButton.isEnabled = false
        
        // create greyed out foreground
        progressContainer.frame = CGRect(x: 0, y: 0, width: 30000, height: 30000)
        progressContainer.center = self.view.center
        progressContainer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha:0.3)
        
        // format spinner
        spinner.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
        spinner.center = self.view.center
        spinner.hidesWhenStopped = true
        spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        
        self.view.addSubview(progressContainer)
        self.view.bringSubview(toFront: progressContainer)
        
        self.view.addSubview(spinner)
        self.view.bringSubview(toFront: spinner)
        spinner.startAnimating()
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        showActivityIndicator()
        
        if emailTextField.text != "" && emailTextField.text!.range(of: "@") != nil {
            newAthlete.email = emailTextField.text!
        }
        else {
            failureHandler2()
            return
        }
        if passwordTextField.text != "" {
            newAthlete.password = passwordTextField.text!
        }
        else {
            failureHandler2()
            return
        }
        
        login(user: newAthlete, success: successHandler, failure: failureHandler)
    }
    
    func failureHandler2() -> Void {
        DispatchQueue.main.async(){
         self.spinner.stopAnimating()
         self.present(self.alert2, animated: true)
         }
        print("Data Entry Failure")
    }
    
    func failureHandler() -> Void {
        DispatchQueue.main.async(){
         self.spinner.stopAnimating()
         self.present(self.alert, animated: true)
        }
        print("Login Failure")
    }
    
    func successHandler() -> Void {
        DispatchQueue.main.async(){
         self.spinner.stopAnimating()
         self.progressContainer.removeFromSuperview()
        }
        self.dismiss(animated: true, completion: nil)
        print("Login Success")
    }
   
}

