//
//  Login.swift
//  RASE
//
//  Created by Sam Beaulieu on 8/19/17.
//  Copyright © 2017 RASE. All rights reserved.
//

import UIKit

func login(email: String, password: String, success: @escaping() -> Void, failure: @escaping(_ message: String) -> Void) {
    
    // Prepare request
    print("Fetching token from server")
    let loginString = String(format: "%@:%@", "e14OEo7csTh0Xjg61Vupn4B5I7oYlT1dld8F9rOE", "m5rlevcnUfs2sMaL2s4n4ELtN6t9OYPR7rRw1RCd95vuHKdU6cTTA716QDRj9J28bAZuOmlRD329P9RfgrxDO9JSJQfHqOW7yWo10OHQzIEzq4SEeeX6gSrEj9mfDP8N")
    let loginData = loginString.data(using: String.Encoding.utf8)!
    let base64LoginString = loginData.base64EncodedString()
    
    // Set request
    var request = URLRequest(url: URL(string: "http://raseup.azurewebsites.net/o/token/")!)
    request.httpMethod = "POST"
    request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
    
    // Set Data
    let post = "grant_type=password&username=" + email + "&password=" + password
    var postData = post.data(using: String.Encoding.ascii, allowLossyConversion: true)
    let postLength = "\(String(describing: postData?.count))"
    
    // format post request
    request.setValue(postLength, forHTTPHeaderField: "Content-Length")
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.httpBody = postData
    
    // Excute HTTP Request
    let _ = URLSession.shared.dataTask(with: request) { data, response, error in
        
        // Check for errors
        if error != nil {
             print("error=\(String(describing: error))")
             failure("An error occured. Please try again later")
             return
        }
        if data == nil {
            failure("Server did not return data. Please try again later.")
            return
        }
        
        // Convert server json response to NSDictionary
        do {
            if let json = try JSONSerialization.jsonObject(with: data!) as? [String: Any] {
                
                if let token = json["access_token"] as? String {
                    // Token was recieved, get user data
                    print("Token: \(token)")
                    
                    fetchUserData(token: token, success: success, failure: failure)
                }
                else if let error = json["error"] as? String {
                    print("error=\(String(describing: error))")
                    failure("An error occured. Please try again later")
                }
                else {
                    failure("Could not get information from JSON. Please try again later.")
                }
            }
            else {
                failure("Could not convert server response to JSON. Please try again later.")
                return
            }
        } catch let error as NSError {
            print(error.localizedDescription)
            failure("An error occured. Please try again later")
        }
    }.resume()
}
