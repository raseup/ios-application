//
//  FeedbackVideoCell.swift
//  RASE
//
//  Created by Sam Beaulieu on 9/10/17.
//  Copyright © 2017 RASE. All rights reserved.
//

import UIKit
import MobileCoreServices
import AVKit
import AVFoundation
/*
// View Controller for the video Cell
class FeedbackVideoCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var lengthLabel: UILabel!
    @IBOutlet weak var selectVideoButton: UIButton!
    
    var feedback: Feedback!
    var parentVC: FeedbackViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectVideoButton.layer.cornerRadius = 5.0
    }
    
    @IBAction func selectVideoPressed(_ sender: UIButton) {
        
        // Prepare action sheet and picker
        let videoPicker = UIImagePickerController()
        videoPicker.mediaTypes = [kUTTypeMovie as String]
        videoPicker.allowsEditing = true
        videoPicker.delegate = self
        let uploadType = UIAlertController(title: "Upload a Video", message: nil, preferredStyle: .actionSheet)
        uploadType.popoverPresentationController?.sourceView = self.parentVC.view
        
        // If the camera is available, set up the alert with take a photo
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            // Add the option to the action sheet
            uploadType.addAction(UIAlertAction(title: "Take Video", style: .default) { (alert : UIAlertAction!) in
                
                // Set up and open the camera if pressed
                videoPicker.sourceType = .camera
                videoPicker.videoMaximumDuration = 60.0
                self.parentVC.present(videoPicker, animated: true, completion: nil)
            })
        }
        
        // Add the photo libary option to the action sheet
        uploadType.addAction(UIAlertAction(title: "Upload Video", style: .default) { (alert : UIAlertAction!) in
            
            // Open the photo library
            videoPicker.sourceType = .photoLibrary
            self.parentVC.present(videoPicker, animated: true, completion: nil)
        })
        
        // Add a cancel putton to the action sheet
        uploadType.addAction(UIAlertAction(title: "Cancel", style: .default) { (alert : UIAlertAction!) in
        })
        
        // Present the action sheet
        parentVC.present(uploadType, animated: true, completion: nil)
    }
}

// Handles a new video being chosen
extension FeedbackVideoCell: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // If a video was picked
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // First verify that the selected media is a video
        let type = info[UIImagePickerControllerMediaType] as! String
        if type == (kUTTypeMovie as String) {
            
            // Get the url of the chosen video
            guard let urlTemp = info[UIImagePickerControllerMediaURL] as? URL else {return}
            
            // Set the url to the feedback model
            self.feedback.videoLink = urlTemp
            
            // Get the duration of the video
            let urlAsset: AVURLAsset = AVURLAsset(url: urlTemp)
            let duration: CMTime = urlAsset.duration
            self.lengthLabel.text = "Length: " + timeToString(seconds: duration.seconds)
            
            // Get the thumbnail for the video
            self.feedback.videoThumbnail = thumbnailFromURL(url: urlTemp.absoluteString)
            self.thumbnailImage.image = self.feedback.videoThumbnail
            self.thumbnailImage.layer.cornerRadius = 5.0
            self.thumbnailImage.clipsToBounds = true
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
}*/
