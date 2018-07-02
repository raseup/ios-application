//
//  AccountManagement.swift
//  RASE
//
//  Created by Sam Beaulieu on 7/6/17.
//  Copyright © 2017 RASE. All rights reserved.
//

import UIKit

// Functions to manage account creation
func createUser(user: [String: String], success: @escaping() -> Void, failure: @escaping(_ message: String) -> Void) {
    
    if let email = user["email"],
        let password = user["password"],
        let first = user["first"],
        let last = user["last"],
        let dateBirth = user["dateBirth"],
        let days = user["days"],
        let recieve = user["recieve"] {
    
        var request = URLRequest(url: URL(string: "http://raseup.azurewebsites.net/anonymous_methods/create_athlete/")!)
        request.httpMethod = "POST"
        
        // Prepare JSON Body
        var body = "{\"email\": \""
        body += email
        body += "\", \"password\": \""
        body += password
        body += "\", \"first_name\": \""
        body += first
        body += "\", \"last_name\": \""
        body += last
        body += "\", \"date_of_birth\": \""
        body += dateBirth
        body += "\", \"days_a_week\": "
        body += days
        body += ", \"get_newsletters\": "
        if recieve == "true" {
            body += "1"
        }
        else {
            body += "0"
        }
        body += "}"
     
        print(body)
     
        // format post request
        request.httpBody = body.data(using: String.Encoding.utf8)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // Check for error
            if error != nil {
                print("error=\(String(describing: error))")
                failure("An error occured. Please try again later")
                return
            }
            
            // Print out response string
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("responseString = \(String(describing: responseString))")
        
            do {
                if let json = try JSONSerialization.jsonObject(with: data!) as? [String: Any] {
                    if let error = json["error"] as? String {
                        print("error=\(String(describing: error))")
                        failure("An error occured. Please try again later")
                    }
                    else if let detail = json["detail"] as? String {
                        failure(detail)
                    }
                    else {
                        // Once the account is made, log the user in
                        login(email: email, password: password, success: success, failure: failure)
                    }
                }
                else {
                    failure("Could not convert server response to JSON. Please try again later.")
                }
            }
            catch let error as NSError {
                print("error=\(String(describing: error))")
                failure("An error occured. Please try again later")
            }
        }.resume()
    }
    else {
        failure("Could not pull user information, please try again.")
    }
}

