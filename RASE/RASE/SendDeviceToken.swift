//
//  SendDeviceToken.swift
//  RASE
//
//  Created by Sam Beaulieu on 10/23/17.
//  Copyright © 2017 RASE. All rights reserved.
//

import UIKit

// Functions to manage account creation
func sendDeviceToken(oauthToken: String, newDeviceToken: String, oldDeviceToken: String? = nil, success: @escaping() -> Void, failure: @escaping(_ message: String) -> Void) {
    
    var body = "{"
    if oldDeviceToken != nil {
        body += "\"old_token\": \""
        body += oldDeviceToken!
        body += "\","
    }
    body += "\"new_token\": \""
    body += newDeviceToken
    body += "\"}"
    
    
    print(body)
    
    var request = URLRequest(url: URL(string: "http://raseup.azurewebsites.net/methods/update_token/")!)
    request.httpMethod = "POST"
    
    // format post request
    request.httpBody = body.data(using: String.Encoding.utf8)
    request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
    
    request.setValue(("Bearer \(oauthToken)"), forHTTPHeaderField: "Authorization")
    
    URLSession.shared.dataTask(with: request) { (data, response, error) in
        
        // Check for error
        if error != nil
        {
            print("error=\(String(describing: error))")
            failure("An error occured, please try again later.")
            return
        }
        
        if data == nil {
            failure("Server did not return data. Please try again later.")
            return
        }
        
        // Parse JSON response for user data
        do {
            // Obtain the body of the JSON response
            if let json = try JSONSerialization.jsonObject(with: data!) as? [String: Any] {
                
                if let error = json["error"] as? String {
                    print("error=\(String(describing: error))")
                    failure("An error occured, please try again later.")
                    return
                }
                print(json)
                guard let body = json["data"] as? [String: Any] else { failure("Could not get data from the json."); return }
                
                if "success" != body["message"] as? String {
                    failure("Server response did not contain user data")
                    return
                }
            }
            else {
                failure("Could not convert server response to JSON. Please try again later.")
                return
            }
        }
        catch {
            failure("Server did not return a valid response. Please try again later.")
            return
        }
    }.resume()
}
