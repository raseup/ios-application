//
//  ImageHelperFunctions.swift
//  RASE
//
//  Created by Sam Beaulieu on 8/27/17.
//  Copyright © 2017 RASE. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

// Convert an image to a string
func imageToString64(image: UIImage) -> String {
    
    // Get the image as data
    let data = UIImagePNGRepresentation(image)!
    
    // Convert the data to a string
    let tempString = data.base64EncodedString(options: .endLineWithCarriageReturn)
    
    return tempString
}

// Convert a string to an image
func imageFromString64(string: String) -> UIImage? {
    
    // Conver the string to data
    let data = Data(base64Encoded: string, options: .ignoreUnknownCharacters)
    if data == nil {
        return nil
    }
    
    // Convert the data to an image
    let tempImage = UIImage(data: data!)
    
    return tempImage
}

// Get a thumbnail from a URL
func thumbnailFromURL(url: String) -> UIImage? {
    
    // First try to create the url
    guard let temp_url = URL(string: url) else { return nil }
    
    // Prepare to pull the thumbnail
    let asset = AVAsset(url: temp_url)
    let assetImageGen = AVAssetImageGenerator(asset: asset)
    let time = CMTimeMakeWithSeconds(10, 60)
    
    do {
        // Pull the thumbnail and return
        let temp = try assetImageGen.copyCGImage(at: time, actualTime: nil)
        let thumb = UIImage(cgImage: temp)
        return thumb
    }
    catch {
        // If thumbnail fails, return nil
        print(error)
        return nil
    }
}

// Resize an image
// https://stackoverflow.com/questions/42545955/scale-image-to-smaller-size-in-swift3
func resizeImage(image: UIImage, newSize: CGSize, keepAspect: Bool) -> UIImage {
    
    // Prepare the new size to set the image to
    var toSize = newSize
    
    // If its desired to keep the aspect ratio in tact, change the new size to reflect that
    if keepAspect {
        let horizontalRatio = newSize.width / image.size.width
        let verticalRatio = newSize.height / image.size.height
        
        let ratio = max(horizontalRatio, verticalRatio)
        toSize = CGSize(width: image.size.width * ratio, height: image.size.height * ratio)
    }
    
    // Resize the image
    UIGraphicsBeginImageContextWithOptions(toSize, true, 0)
    image.draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: toSize))
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    // Return the image
    return newImage!
}
