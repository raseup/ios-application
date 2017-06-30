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
    @IBOutlet weak var pickerAge: UIPickerView!
    @IBOutlet weak var pickerPosition: UIPickerView!
    @IBOutlet weak var scrollConstraint: NSLayoutConstraint!
    
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
}
