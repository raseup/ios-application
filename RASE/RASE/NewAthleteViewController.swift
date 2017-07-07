//
//  NewAthleteViewController.swift
//  RASE
//
//  Created by Sam Beaulieu on 6/15/17.
//  Copyright © 2017 RASE. All rights reserved.
//

import UIKit

class NewAthleteViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    // Variables
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var positionTextField: UITextField!
    @IBOutlet weak var recieveLatestSwitch: UISwitch!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var pickerAge: UIPickerView!
    @IBOutlet weak var pickerPosition: UIPickerView!
    @IBOutlet weak var scrollConstraint: NSLayoutConstraint!
    
    // Activity Indicator for saving new user
    let spinner: UIActivityIndicatorView = UIActivityIndicatorView()
    var progressContainer: UIView = UIView()
    
    // In case there is an error creating new user
    let alert = UIAlertController(title: "Error", message: "There was a problem creating your account. Please try again.", preferredStyle: UIAlertControllerStyle.alert)
    
    let alert2 = UIAlertController(title: "Error", message: "Please enter text for the email, password, and name fields and select values for age and position.", preferredStyle: UIAlertControllerStyle.alert)
    
    var newAthlete: Athlete = Athlete(email: "", password: "", first_name: "", last_name: "", age: 1, position: "", recieve_latest: 1, token: "")
    
    var ageList: [String] = [String]()
    var positionList = ["Point Guard", "Shooting Guard", "Small Forward", "Power Forward", "Center", "I do not have a position"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.pickerAge.delegate = self
        self.pickerAge.dataSource = self
        self.pickerPosition.delegate = self
        self.pickerPosition.dataSource = self
        
        for val in 4...75
        {
            self.ageList.append(String(val))
        }
        
        self.alert2.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            // Enable all interactions underneath
            self.emailTextField.isEnabled = true
            self.passwordTextField.isEnabled = true
            self.firstNameTextField.isEnabled = true
            self.lastNameTextField.isEnabled = true
            self.ageTextField.isEnabled = true
            self.positionTextField.isEnabled = true
            self.recieveLatestSwitch.isEnabled = true
            self.createAccountButton.isEnabled = true
            
            self.progressContainer.removeFromSuperview()
        }))
        self.alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            // Enable all interactions underneath
            self.emailTextField.isEnabled = true
            self.passwordTextField.isEnabled = true
            self.firstNameTextField.isEnabled = true
            self.lastNameTextField.isEnabled = true
            self.ageTextField.isEnabled = true
            self.positionTextField.isEnabled = true
            self.recieveLatestSwitch.isEnabled = true
            self.createAccountButton.isEnabled = true
            
            self.progressContainer.removeFromSuperview()
        }))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Picker Functions
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        if pickerView.tag == 1
        {
            return self.ageList.count
        }
        else
        {
            return self.positionList.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView.tag == 1
        {
            return self.ageList[row]
        }
        else
        {
            return self.positionList[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView.tag == 1
        {
            self.ageTextField.text = self.ageList[row]
            self.scrollConstraint.constant = 0
            self.pickerAge.isHidden = true
        }
        else
        {
            self.positionTextField.text = self.positionList[row]
            self.scrollConstraint.constant = 0
            self.pickerPosition.isHidden = true
        }
    }
    
    @IBAction func emailBeginEditing(_ sender: UITextField) {
        self.scrollConstraint.constant = 0
        self.pickerPosition.isHidden = true
        self.pickerAge.isHidden = true
    }
    
    @IBAction func passwordBeginEditing(_ sender: UITextField) {
        self.scrollConstraint.constant = 0
        self.pickerPosition.isHidden = true
        self.pickerAge.isHidden = true
    }
    
    @IBAction func firstNameBeginEditing(_ sender: UITextField) {
        self.scrollConstraint.constant = 0
        self.pickerPosition.isHidden = true
        self.pickerAge.isHidden = true
    }
    
    @IBAction func lastNameBeginEditing(_ sender: UITextField) {
        self.pickerPosition.isHidden = true
        self.pickerAge.isHidden = true
        self.scrollConstraint.constant = 0
    }
    
    @IBAction func ageBeginEditing(_ sender: UITextField) {
        self.pickerAge.isHidden = false
        self.pickerPosition.isHidden = true
        self.scrollConstraint.constant = -216
        self.ageTextField.endEditing(true)
    }
    
    @IBAction func positionBeginEdition(_ sender: UITextField) {
        self.pickerPosition.isHidden = false
        self.pickerAge.isHidden = true
        self.scrollConstraint.constant = -216
        self.positionTextField.endEditing(true)
    }
    
    @IBAction func closeButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func showActivityIndicator() {
        
        // Disable all interactions underneath
        self.emailTextField.isEnabled = false
        self.passwordTextField.isEnabled = false
        self.firstNameTextField.isEnabled = false
        self.lastNameTextField.isEnabled = false
        self.ageTextField.isEnabled = false
        self.positionTextField.isEnabled = false
        self.recieveLatestSwitch.isEnabled = false
        self.createAccountButton.isEnabled = false
        
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

    
    @IBAction func createNewUser(_ sender: UIButton) {
        
        showActivityIndicator()
        
        // First do error checking
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
        if firstNameTextField.text != "" {
            newAthlete.first_name = firstNameTextField.text!
        }
        else {
            failureHandler2()
            return
        }
        
        if lastNameTextField.text != "" {
            newAthlete.last_name = lastNameTextField.text!
        }
        else {
            failureHandler2()
            return
        }
        
        if ageTextField.text != "" && Int64(ageTextField.text!) != 0 {
            newAthlete.age = Int64(ageTextField.text!)!
        }
        else {
            failureHandler2()
            return
        }
        
        if positionTextField.text != "" {
            newAthlete.position = positionTextField.text!
        }
        else {
            failureHandler2()
            return
        }
        
        newAthlete.recieve_latest = Int64(NSNumber(value:recieveLatestSwitch.isOn))
        
        createUser(user: newAthlete, success: successHandler, failure: failureHandler)
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
        print("Create User Failure")
    }

    func successHandler() -> Void {
        DispatchQueue.main.async(){
            self.spinner.stopAnimating()
            self.progressContainer.removeFromSuperview()
        }
        self.dismiss(animated: true, completion: nil)
        print("Create User Success")
    }
}
