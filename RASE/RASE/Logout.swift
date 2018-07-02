//
//  Logout.swift
//  RASE
//
//  Created by Sam Beaulieu on 9/13/17.
//  Copyright © 2017 RASE. All rights reserved.
//

import UIKit

func logout(token: String, success: @escaping() -> Void, failure: @escaping(_ message: String) -> Void) {
    
    // Prepare request
    print("Logging out (revoking token)")
    let client_id = "e14OEo7csTh0Xjg61Vupn4B5I7oYlT1dld8F9rOE"
    let client_secret = "m5rlevcnUfs2sMaL2s4n4ELtN6t9OYPR7rRw1RCd95vuHKdU6cTTA716QDRj9J28bAZuOmlRD329P9RfgrxDO9JSJQfHqOW7yWo10OHQzIEzq4SEeeX6gSrEj9mfDP8N"

    // Set request
    var request = URLRequest(url: URL(string: "http://raseup.azurewebsites.net/o/revoke_token/")!)
    request.httpMethod = "POST"
    
    // Set Data
    let post = "token=" + token + "&client_id=" + client_id + "&client_secret=" + client_secret
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
        
        let statusCode = (response as! HTTPURLResponse).statusCode
        
        if statusCode == 200 {
            success()
            return
        }
        else  {
            failure("Could not revoke token. HTTP error: \(statusCode)")
            return
        }
        
    }.resume()
}

