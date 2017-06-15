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
    @IBOutlet weak var picker: UIPickerView!
    
    var ageList: [String] = [String]()
    var skillList = ["Introductive Level", "Fundemental Level", "Intermediate Level", "Advanced Level", "Professional Level"]
    var positionList = ["Point Guard", "Shooting Guard", "Small Forward", "Power Forward", "Center", "I do not have a position"]
    
    var pickerSource: [String] = [String]()
    var currentTextField: UITextField? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.picker.delegate = self
        self.picker.dataSource = self
        self.ageTextField.delegate = self
        self.positionTextField.delegate = self
        
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
        return self.pickerSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        self.view.endEditing(true)
        return self.pickerSource[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.currentTextField!.text = self.pickerSource[row]
        self.picker.isHidden = true
        
    }
    
    @IBAction func ageBeginEditing(_ sender: UITextField) {
        
        self.currentTextField = self.ageTextField
        self.pickerSource = self.ageList
        self.picker.isHidden = false
        self.currentTextField!.endEditing(true)
    }
    
    @IBAction func positionBeginEdition(_ sender: UITextField) {
        self.currentTextField = self.positionTextField
        self.pickerSource = self.positionList
        self.picker.isHidden = true
        self.currentTextField!.endEditing(true)
        
        print(picker.isHidden)
    }
    
    
}
