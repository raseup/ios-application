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
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var positionTextField: UITextField!
    @IBOutlet weak var shootingTextField: UITextField!
    @IBOutlet weak var ballHandlingTextField: UITextField!
    @IBOutlet weak var finishingTextField: UITextField!
    @IBOutlet weak var passingTextField: UITextField!
    @IBOutlet weak var defenseTextField: UITextField!
    @IBOutlet weak var videoLabel: UILabel!
    @IBOutlet weak var videoTextField: UILabel!
    @IBOutlet weak var checkoutButton: UIButton!
    @IBOutlet weak var pickerAge: UIPickerView!
    @IBOutlet weak var pickerSkills: UIPickerView!
    @IBOutlet weak var pickerPosition: UIPickerView!
    @IBOutlet weak var scrollConstraint: NSLayoutConstraint!
    
    var ageList: [String] = [String]()
    var skillList = ["Introductive Level", "Fundemental Level", "Intermediate Level", "Advanced Level", "Professional Level"]
    var positionList = ["Point Guard", "Shooting Guard", "Small Forward", "Power Forward", "Center", "I do not have a position"]
    
    var currentTextField: UITextField? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        currentTextField = shootingTextField
        
        self.pickerAge.delegate = self
        self.pickerAge.dataSource = self
        self.pickerSkills.delegate = self
        self.pickerSkills.dataSource = self
        self.pickerPosition.delegate = self
        self.pickerPosition.dataSource = self
        self.ageTextField.delegate = self
        self.positionTextField.delegate = self
        self.shootingTextField.delegate = self
        self.ballHandlingTextField.delegate = self
        self.finishingTextField.delegate = self
        self.passingTextField.delegate = self
        self.defenseTextField.delegate = self
        
        for val in 4...75
        {
            self.ageList.append(String(val))
        }
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
        else if pickerView.tag == 2
        {
            return self.positionList.count
        }
        else
        {
            return self.skillList.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView.tag == 1
        {
            return self.ageList[row]
        }
        else if pickerView.tag == 2
        {
            return self.positionList[row]
        }
        else
        {
            return self.skillList[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView.tag == 1
        {
            self.ageTextField.text = self.ageList[row]
            self.scrollConstraint.constant = 0
            self.pickerAge.isHidden = true
        }
        else if pickerView.tag == 2
        {
            self.positionTextField.text = self.positionList[row]
            self.scrollConstraint.constant = 0
            self.pickerPosition.isHidden = true
        }
        else
        {
            self.currentTextField!.text = self.skillList[row]
            self.scrollConstraint.constant = 0
            self.pickerSkills.isHidden = true
        }
    }
    
    @IBAction func ageBeginEditing(_ sender: UITextField) {
        self.pickerAge.isHidden = false
        self.scrollConstraint.constant = -175
        self.ageTextField.endEditing(true)
    }
    
    @IBAction func positionBeginEdition(_ sender: UITextField) {
        self.pickerPosition.isHidden = false
        self.scrollConstraint.constant = -175
        self.positionTextField.endEditing(true)
    }
    
    @IBAction func skillsBeginEditing(_ sender: UITextField) {
        self.pickerSkills.isHidden = false
        self.scrollConstraint.constant = -175
        sender.endEditing(true)
        currentTextField! = sender
    }
    
    @IBAction func shootingBeginEditing(_ sender: UITextField) {
        self.pickerSkills.isHidden = false
        self.scrollConstraint.constant = -175
        shootingTextField.endEditing(true)
        currentTextField! = shootingTextField
    }
}
