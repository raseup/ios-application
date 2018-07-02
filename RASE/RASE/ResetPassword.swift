//
//  ResetPassword.swift
//  RASE
//
//  Created by Sam Beaulieu on 9/20/17.
//  Copyright © 2017 RASE. All rights reserved.
//

import UIKit

func resetPassword(email: String, success: @escaping() -> Void, failure: @escaping(_ message: String) -> Void) {

    print("Requesting a password reset.")
    
    // Prepare JSON Body
    var body = "{\"email\": \""
    body += email
    body += "\"}"
    print(body)
    
    // Create the request
    var request = URLRequest(url: URL(string: "http://raseup.azurewebsites.net/anonymous_methods/reset_password/")!)
    request.httpMethod = "POST"
    
    // Format post request
    request.httpBody = body.data(using: String.Encoding.utf8)
    request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
    
    // Send the request
    URLSession.shared.dataTask(with: request) { (data, response, error) in
        
        // Check for error
        if error != nil {
            print("error=\(String(describing: error))")
            failure("An error occured. Please try again later")
            return
        }
        
        if data == nil {
            failure("Server did not return data. Please try again later.")
            return
        }
        
        // Print out response string
        let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
        print("responseString = \(String(describing: responseString))")
        
        // Parse JSON response for user data
        do {
            // Obtain the body of the JSON response
            if let json = try JSONSerialization.jsonObject(with: data!) as? [String: Any], let body = json["data"] as? [String: Any] {
                
                if "success" == body["message"] as? String {
                    success()
                    return
                }
                else if let error = json["error"] as? String {
                    print("error=\(String(describing: error))")
                    failure("An error occured. Please try again later")
                    return
                }
                else {
                    failure("There was an issue sending your request. Please try again later.")
                    return
                }
            }
        }
        catch {
            failure("There was an issue sending your request. Please try again later.")
            return
        }
    }.resume()
}

