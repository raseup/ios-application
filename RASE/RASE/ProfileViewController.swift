//
//  ArchiveViewController.swift
//  RASE
//
//  Created by Sam Beaulieu on 7/26/17.
//  Copyright © 2017 RASE. All rights reserved.
//

import UIKit
/*

class ProfileViewController: UIViewController, UITextFieldDelegate {
    
    // The header items
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var postsLabel: UILabel!
    
    // The text fields for new data
    @IBOutlet weak var newPasswordOne: UITextField!
    @IBOutlet weak var newPasswordTwo: UITextField!
    @IBOutlet weak var PositionOrDescription: UITextField!
    @IBOutlet weak var DaysWeekOrAvailability: UITextField!
    @IBOutlet weak var oldPassword: UITextField!
    @IBOutlet weak var newPasswordsMatchingLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    
    var activeTextField: UITextField?
    
    // The pickers for position and days a week and their variables
    let positionPicker = UIPickerView()
    let daysWeekPicker = UIPickerView()
    var daysList = ["1", "2", "3", "4", "5", "6", "7"]
    var positionList = ["Point Guard", "Shooting Guard", "Small Forward", "Power Forward", "Center", "I do not have a position"]
    let duration = 0.5
    
    // The constraint for the scroll view to be adjusted for the pickers
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollViewBottomConstraint: NSLayoutConstraint!
    
    // Activity indicator and alerts for submittion
    var indicator: ActivityIndicator!
    var alert: UIAlertController!
    var alertWorkoutFailure: UIAlertController!
    let alertSuccess = UIAlertController(title: "Success!", message: "You have successfully updated your account.", preferredStyle: UIAlertControllerStyle.alert)
    
    var userType: UserType!
    var pictureChanged = false
    
    var background: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the background to the image
        self.view.backgroundColor = UIColor.clear
        
        let backgroundImageView = UIImageView(image: background)
        backgroundImageView.frame = UIScreen.main.bounds
        self.view.insertSubview(backgroundImageView, at: 0)
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = UIScreen.main.bounds
        self.view.insertSubview(blurEffectView, aboveSubview: backgroundImageView)
        
        // Get the type of the user
        guard let typeTemp = localDataManager.sharedInstance.localUser?.type else { return }
        userType = typeTemp
        
        // Prepare indicator and success alert action
        self.alertSuccess.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            
            self.scrollViewBottomConstraint.constant = 0
            
            // If the user is a coach, make it description and availability
            if let coach = localDataManager.sharedInstance.localUser as? Coach {
                self.PositionOrDescription.attributedText = NSAttributedString(string: coach.description, attributes: [NSForegroundColorAttributeName: UIColor.white])
                self.DaysWeekOrAvailability.attributedText = NSAttributedString(string: coach.description, attributes: [NSForegroundColorAttributeName: UIColor.white])
            }
                // Else if its an athlete, make it days and position
            else if let athlete = localDataManager.sharedInstance.localUser as? Athlete {
                self.PositionOrDescription.attributedText = NSAttributedString(string: athlete.position.rawValue, attributes: [NSForegroundColorAttributeName: UIColor.white])
                self.DaysWeekOrAvailability.attributedText = NSAttributedString(string: String(athlete.days), attributes: [NSForegroundColorAttributeName: UIColor.white])
            }
            
            self.indicator.removeBackground()
        }))
        
        // Make the profile picture a circle and add the gesture to change it
        profilePicture.image = localDataManager.sharedInstance.localUser!.image
        profilePicture.layer.cornerRadius = profilePicture.frame.width / 2
        profilePicture.clipsToBounds = true
        let pictureTap = UITapGestureRecognizer(target: self, action: #selector(changeProfilePicture))
        profilePicture.addGestureRecognizer(pictureTap)
        profilePicture.isUserInteractionEnabled = true
        
        submitButton.layer.cornerRadius = 5.0
        let px = 1 / UIScreen.main.scale
        
        let positionBottom = UIView(frame: CGRect(x: self.PositionOrDescription.frame.minX, y: self.PositionOrDescription.frame.maxY + 2, width: self.PositionOrDescription.frame.width, height: px))
        positionBottom.backgroundColor = placeHolderWhite
        self.scrollView.addSubview(positionBottom)
        
        let daysBottom = UIView(frame: CGRect(x: self.DaysWeekOrAvailability.frame.minX, y: self.DaysWeekOrAvailability.frame.maxY + 2, width: self.DaysWeekOrAvailability.frame.width, height: px))
        daysBottom.backgroundColor = placeHolderWhite
        self.scrollView.addSubview(daysBottom)
        
        // Set the posts and name for the user
        nameLabel.text = localDataManager.sharedInstance.localUser?.name
        if let athlete = localDataManager.sharedInstance.localUser as? Athlete {
            if athlete.archiveThumbnails.count == 1 {
                postsLabel.text = "\(athlete.archiveThumbnails.count) video"
            }
            else {
                postsLabel.text = "\(athlete.archiveThumbnails.count) videos"
            }
            
            self.PositionOrDescription.attributedPlaceholder = NSAttributedString(string: "new description", attributes: [NSForegroundColorAttributeName: placeHolderWhite])
            
            self.DaysWeekOrAvailability.attributedPlaceholder = NSAttributedString(string: "new availability", attributes: [NSForegroundColorAttributeName: placeHolderWhite])
            
            PositionOrDescription.attributedText = NSAttributedString(string: athlete.position.rawValue, attributes: [NSForegroundColorAttributeName: UIColor.white])
            DaysWeekOrAvailability.attributedText = NSAttributedString(string: String(athlete.days), attributes: [NSForegroundColorAttributeName: UIColor.white])
            
        }
        else if let coach = localDataManager.sharedInstance.localUser as? Coach {
            postsLabel.text = ""
            
            self.PositionOrDescription.attributedPlaceholder = NSAttributedString(string: "new description", attributes: [NSForegroundColorAttributeName: placeHolderWhite])
            
            self.DaysWeekOrAvailability.attributedPlaceholder = NSAttributedString(string: "new availability", attributes: [NSForegroundColorAttributeName: placeHolderWhite])
            
            PositionOrDescription.attributedText = NSAttributedString(string: coach.description, attributes: [NSForegroundColorAttributeName: UIColor.white])
            DaysWeekOrAvailability.attributedText = NSAttributedString(string: coach.description, attributes: [NSForegroundColorAttributeName: UIColor.white])
        }
        
        // Set the text field information for each of the fields
        self.newPasswordOne.tag = 1
        self.newPasswordOne.delegate = self
        self.newPasswordOne.returnKeyType = .done
        self.newPasswordOne.keyboardAppearance = .dark
        self.newPasswordOne.attributedPlaceholder = NSAttributedString(string: "new password", attributes: [NSForegroundColorAttributeName: placeHolderWhite])
        let passwordBottom = UIView(frame: CGRect(x: self.newPasswordOne.frame.minX, y: self.newPasswordOne.frame.maxY + 2, width: self.newPasswordOne.frame.width, height: px))
        passwordBottom.backgroundColor = placeHolderWhite
        self.scrollView.addSubview(passwordBottom)
        
        self.newPasswordTwo.tag = 1
        self.newPasswordTwo.delegate = self
        self.newPasswordTwo.returnKeyType = .done
        self.newPasswordTwo.keyboardAppearance = .dark
        self.newPasswordTwo.attributedPlaceholder = NSAttributedString(string: "new password", attributes: [NSForegroundColorAttributeName: placeHolderWhite])
        let passwordBottom2 = UIView(frame: CGRect(x: self.newPasswordTwo.frame.minX, y: self.newPasswordTwo.frame.maxY + 2, width: self.newPasswordTwo.frame.width, height: px))
        passwordBottom2.backgroundColor = placeHolderWhite
        self.scrollView.addSubview(passwordBottom2)
        
        self.oldPassword.tag = 1
        self.oldPassword.delegate = self
        self.oldPassword.returnKeyType = .done
        self.oldPassword.keyboardAppearance = .dark
        self.oldPassword.attributedPlaceholder = NSAttributedString(string: "old password", attributes: [NSForegroundColorAttributeName: placeHolderWhite])
        let passwordBottom3 = UIView(frame: CGRect(x: self.oldPassword.frame.minX, y: self.oldPassword.frame.maxY + 2, width: self.oldPassword.frame.width, height: px))
        passwordBottom3.backgroundColor = placeHolderWhite
        self.scrollView.addSubview(passwordBottom3)
        
        
        // If the user is an athlete, prepare all the pickers and set them
        if userType == .athlete {
            
            // Prepare the picker view's toolbar
            let pickerBar = UIToolbar(frame:  CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44))
            pickerBar.barTintColor = backgroundGray
            let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(donePressed))
            let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
            pickerBar.setItems([spaceButton, doneButton], animated: true)
            
            // Set the days a week picker
            self.daysWeekPicker.tag = 1
            self.daysWeekPicker.backgroundColor = backgroundGray
            self.daysWeekPicker.delegate = self
            self.daysWeekPicker.dataSource = self
            self.DaysWeekOrAvailability.delegate = self
            self.DaysWeekOrAvailability.inputAccessoryView = pickerBar
            self.DaysWeekOrAvailability.inputView = daysWeekPicker

            // Set the position picker
            self.positionPicker.tag = 2
            self.positionPicker.backgroundColor = backgroundGray
            self.positionPicker.delegate = self
            self.positionPicker.dataSource = self
            self.PositionOrDescription.delegate = self
            self.PositionOrDescription.inputAccessoryView = pickerBar
            self.PositionOrDescription.inputView = positionPicker
            
        }
        // Otherwise if the user is a coach, treat the fields like text boxes
        else if userType == .coach {
            // Set description field
            self.PositionOrDescription.delegate = self
            self.PositionOrDescription.returnKeyType = .done
            self.PositionOrDescription.keyboardAppearance = .dark
            
            // Set availability field
            self.DaysWeekOrAvailability.delegate = self
            self.DaysWeekOrAvailability.returnKeyType = .done
            self.DaysWeekOrAvailability.keyboardAppearance = .dark
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        
        if indicator == nil {
            indicator = ActivityIndicator(viewController: self)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func swiped() {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func dissmissPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // When a text field is selected for editing, update the scroll constraints and set the active field
    func textFieldDidBeginEditing(_ textField: UITextField) { // became first responder
        
        // Set the current text field
        activeTextField = textField
        
        // Animate the constraint so the view can scroll
        if textField.tag == 1 {
            // No toolbar for password so a bit less constraint
            self.scrollViewBottomConstraint.constant = 216
        }
        else {
            self.scrollViewBottomConstraint.constant = 260
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
        self.scrollViewBottomConstraint.constant = 125
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
        self.scrollViewBottomConstraint.constant = 125
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func passwordTwoEditingChanged(_ sender: UITextField) {
        if newPasswordOne.text == newPasswordTwo.text {
            newPasswordsMatchingLabel.isHidden = true
        }
        else {
            newPasswordsMatchingLabel.isHidden = false
        }
    }
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        
        // If its a coach, make a request to update the coach
        if let coach = localDataManager.sharedInstance.localUser as? Coach {
            
            // Check to see if anything has changed, if so and no password, error
            if profilePicture.image != coach.image || newPasswordOne.text != "" || PositionOrDescription.text != coach.description || DaysWeekOrAvailability.text != coach.availability {
                
                // Disable all interactions underneath while error checking and sending request
                self.indicator.startAnimator()
                
                // First error check for new passwords - they must be equal
                if newPasswordOne.text != newPasswordTwo.text {
                    failureHandler(message: "New passwords much match.")
                    return
                }
                
                if oldPassword.text == "" {
                    failureHandler(message: "You must enter your current password for verification.")
                    return
                }
                
                // Prepare variables
                var newInfo = [String: String]()
                newInfo["userType"] = "coach"
                newInfo["oldPassword"] = oldPassword.text!
                
                if newPasswordOne.text != nil && newPasswordOne.text != ""{
                    newInfo["newPassword"] = newPasswordOne.text
                }
                if PositionOrDescription.text != nil && PositionOrDescription.text != "" {
                    newInfo["newDescription"] = PositionOrDescription.text
                }
                if DaysWeekOrAvailability.text != nil && DaysWeekOrAvailability.text != "" {
                    newInfo["newAvailability"] = DaysWeekOrAvailability.text
                }
                if pictureChanged {
                    newInfo["newImage"] = imageToString64(image: profilePicture.image!)
                }
                
                // Make the request
                updateUser(newData: newInfo, success: successHandler, failure: failureHandler)
            }
        }
        // Else if its an athlete, make a request to update the coach
        else if let athlete = localDataManager.sharedInstance.localUser as? Athlete {
            
            // Check to see if anything has changed, if so and no password, error
            if profilePicture.image != athlete.image || newPasswordOne.text != "" || PositionOrDescription.text != athlete.position.rawValue || DaysWeekOrAvailability.text != String(athlete.days) {
                
                // Disable all interactions underneath while error checking and sending request
                self.indicator.startAnimator()
                
                // First error check for new passwords - they must be equal
                if newPasswordOne.text != newPasswordTwo.text {
                    failureHandler(message: "New passwords much match.")
                    return
                }
                
                if oldPassword.text == "" {
                    failureHandler(message: "You must enter your current password for verification.")
                    return
                }
                
                // Prepare variables
                var newInfo = [String: String]()
                newInfo["userType"] = "athlete"
                newInfo["oldPassword"] = oldPassword.text!
                
                if newPasswordOne.text != nil && newPasswordOne.text != ""{
                    newInfo["newPassword"] = newPasswordOne.text
                }
                if PositionOrDescription.text != nil && PositionOrDescription.text != "" {
                    newInfo["newPosition"] = PositionOrDescription.text
                }
                if DaysWeekOrAvailability.text != nil && DaysWeekOrAvailability.text != "" {
                    newInfo["newDays"] = DaysWeekOrAvailability.text
                }
                if pictureChanged {
                    newInfo["newImage"] = imageToString64(image: profilePicture.image!)
                }
                
                // Make the request
                updateUser(newData: newInfo, success: successHandler, failure: failureHandler)
            }
        }
    }
    
    // Failure handler for the update request
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
        print("Update user failed")
    }
    
    // Success handler for update request
    func successHandler() -> Void {
        DispatchQueue.main.async(){
            self.indicator.removeSpinner()
            self.present(self.alertSuccess, animated: true)
        }
        print("Update user success")
    }
}

// Extension to handle all logout functions
extension ProfileViewController {
    
    @IBAction func logoutClicked(_ sender: UIButton) {
        
        let logoutQuestion = UIAlertController(title: "Logout", message: "Are you sure you would like to log out?", preferredStyle: UIAlertControllerStyle.alert)
        
        // Add alert handlers
        logoutQuestion.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            
            // Start the logout animator
            self.indicator.startAnimator()
            
            // Send workout data to the server if there is one
            if let work = (localDataManager.sharedInstance.localUser as? Athlete)?.currentWorkout {
                let feedback = Feedback(workout: work, user: localDataManager.sharedInstance.localUser!.email)
                feedback.drillTypes.removeAll()
                feedback.coachRating.removeAll()
                submitWorkoutFeedback(feedback: feedback, token: localDataManager.sharedInstance.localUser!.token!, success: self.workoutSuccess, failure: self.workoutFailure)
            }
            else {
                // Ask the server to revoke the token
                logout(token: localDataManager.sharedInstance.localUser!.token!, success: self.success, failure: self.failure)
                
                // Flush the local database (not device data)
                self.flushLocalDataAndDismiss()
            }
        }))
        
        logoutQuestion.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            
            // Do nothing
        }))
        
        // Present the logout alert
        self.present(logoutQuestion, animated: true, completion: nil)
    }
    
    func flushLocalDataAndDismiss() {
        
        // Flush any locally saved videos
        let fileManager = FileManager.default
        let directory = NSHomeDirectory()
        do {
            let files = try fileManager.contentsOfDirectory(atPath: directory)
            for eachFile in files {
                print("Removing \(eachFile) from \(directory)")
                try fileManager.removeItem(atPath: directory + eachFile)
            }
        }
        catch {
            print(error)
            print("Could not delete files from home directory.")
        }
        
        // Flush the database
        for each in localDataManager.sharedInstance.allUsers {
            if each.id != nil {
                _ = RASEDB.instance.deleteUser(uid: each.id!)
            }
        }
        
        // Reset local variables 
        localDataManager.sharedInstance.localUser = nil
        localDataManager.sharedInstance.allUsers.removeAll()
        
        // Remove the indicator and dismiss the page
        self.indicator.removeIndicator()
        self.dismiss(animated: true, completion: nil)
    }
    
    // Success handler for update request
    func workoutSuccess() -> Void {
        DispatchQueue.main.async(){
            
            // Ask the server to revoke the token
            logout(token: localDataManager.sharedInstance.localUser!.token!, success: self.success, failure: self.failure)
            
            // Flush user data
            self.flushLocalDataAndDismiss()
        }
        print("Workout updated, revoking token and flushing")
    }
    
    // Success handler for update request
    func workoutFailure(message: String) -> Void {
        
        alertWorkoutFailure = UIAlertController(title: "Error", message: "Was not able to backup workout data. Progress may be lost if you decide to continue logging out. Error is: \(message)", preferredStyle: UIAlertControllerStyle.alert)
        
        // Add alert handlers for workout update failure
        alertWorkoutFailure.addAction(UIAlertAction(title: "Logout", style: .destructive, handler: { action in
            
            // Ask the server to revoke the token
            logout(token: localDataManager.sharedInstance.localUser!.token!, success: self.success, failure: self.failure)

            // Flush user data
            self.flushLocalDataAndDismiss()
        }))
        alertWorkoutFailure.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: { action in
            
            self.indicator.removeBackground()
        }))
        
        DispatchQueue.main.async {
            self.indicator.removeSpinner()
            self.present(self.alertWorkoutFailure, animated: true)
        }
        print("Failed to update workout progress and log out with error: \(message)")
    }
    
    // Success handler for update request
    func success() -> Void {
        print("Token successfully revoked")
    }
    
    // Success handler for update request
    func failure(message: String) -> Void {
        print("Token unsuccessfully revoked with error: \(message)")
    }
}

// Extension to handle all the image chagning
extension ProfileViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    // Gives the number of picker columns
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    // Sets the number of rows for each picker
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        if pickerView.tag == 1 { return self.daysList.count }
        else { return self.positionList.count }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView.tag == 1 { return self.daysList[row] }
        else{ return self.positionList[row] }
    }
    
    // Set picker view row labels and color
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        if pickerView.tag == 1 {
            return NSAttributedString(string: self.daysList[row], attributes: [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "TradeGothicLT", size: 18.0)!])
        }
        else{
            return NSAttributedString(string: self.positionList[row], attributes: [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "TradeGothicLT", size: 18.0)!])
        }
    }
    
    // Determines what happens when a row is selected
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView.tag == 1
        {
            self.DaysWeekOrAvailability.attributedText = NSAttributedString(string: self.daysList[row], attributes: [NSForegroundColorAttributeName: UIColor.white])
        }
        else
        {
            self.PositionOrDescription.attributedText = NSAttributedString(string: self.positionList[row], attributes: [NSForegroundColorAttributeName: UIColor.white])
        }
    }
}

// Handles a new image being chosen
extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // When the profile picture is clicked, ask to upload a new picture or take one
    @objc func changeProfilePicture() {
        
        // Prepare action sheet and picker
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        let uploadType = UIAlertController(title: "Change Profile Picture", message: nil, preferredStyle: .actionSheet)
        uploadType.popoverPresentationController?.sourceView = self.view
        
        // If the camera is available, set up the alert with take a photo
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            // Add the option to the action sheet
            uploadType.addAction(UIAlertAction(title: "Take Photo", style: .default) { (alert : UIAlertAction!) in
                
                // Set up and open the picker if pressed
                imagePicker.sourceType = .camera
                imagePicker.allowsEditing = true
                self.present(imagePicker, animated: true, completion: nil)
            })
        }
        
        // Add the photo libary option to the action sheet
        uploadType.addAction(UIAlertAction(title: "Upload Photo", style: .default) { (alert : UIAlertAction!) in
            
            // Open the photo library
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        })
        
        // Add a cancel putton to the action sheet
        uploadType.addAction(UIAlertAction(title: "Cancel", style: .default) { (alert : UIAlertAction!) in
        })
        
        // Present the action sheet
        self.present(uploadType, animated: true, completion: nil)
    }
    
    // If an image was picked
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {

            self.profilePicture.image = resizeImage(image: image, newSize: CGSize(width: 100, height: 100), keepAspect: true)
            pictureChanged = true
        }
        else if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {

            self.profilePicture.image = resizeImage(image: image, newSize: CGSize(width: 100, height: 100), keepAspect: true)
            pictureChanged = true
        }
        else {
            print("Error!")
        }
    
        picker.dismiss(animated: true, completion: nil)
    }
}*/
