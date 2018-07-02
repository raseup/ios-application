//
//  FetchProfilePicture.swift
//  RASE
//
//  Created by Sam Beaulieu on 1/20/18.
//  Copyright © 2018 RASE. All rights reserved.
//

import Foundation

func fetchProfilePicture(token: String, user: User) {
    
    // Prepare request header info
    print("Fetching user data from server using this token: \(token)")
    
    var request = URLRequest(url: URL(string: "http://raseup.azurewebsites.net/methods/get_image/")!)
    request.httpMethod = "GET"
    request.setValue(("Bearer \(token)"), forHTTPHeaderField: "Authorization")
    
    // Make the request
    URLSession.shared.dataTask(with: request) { (data, response, error) in
        
        // Check for errors
        if error != nil {
            print("error=\(String(describing: error))")
            return
        }
        
        if data == nil {
            return
        }
        
        //print(String(data: data!, encoding: String.Encoding.utf8) as String!)
        
        // Parse JSON response for user data
        do {
            // Obtain the body of the JSON response
            if let json = try JSONSerialization.jsonObject(with: data!) as? [String: Any] {
                
                if let error = json["error"] as? String {
                    print("error=\(String(describing: error))")
                    return
                }
                
                guard let body = json["data"] as? [String: Any] else { return }
                
                // Get the image in String64
                guard let imageString = body["image"] as? String else { return }
                
                // Convert the image to a UIImage
                if let image = imageFromString64(string: imageString) {
                    
                    // Set the image to the user
                    user.image = image
                }
            }
        }
        catch let error as NSError {
            print("error=\(String(describing: error))")
        }
    }.resume()
}
