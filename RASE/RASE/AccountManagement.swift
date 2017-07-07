//
//  AccountManagement.swift
//  RASE
//
//  Created by Sam Beaulieu on 7/6/17.
//  Copyright © 2017 RASE. All rights reserved.
//

// Functions to manage account creation, logging in and out, and modification
import Foundation

func createUser(user: Athlete, success: @escaping() -> Void, failure: @escaping() -> Void) {
    
    var request = URLRequest(url: URL(string: "https://raseup.azurewebsites.net/user/")!)
    request.httpMethod = "POST"
    
    var body = "{\"email\": \""
    body += user.email
    body += "\", \"username\": \""
    body += "username"
    body += "\", \"password\": \""
    body += user.password
    body += "\", \"first_name\": \""
    body += user.first_name
    body += "\", \"last_name\": \""
    body += user.last_name
    body += "\", \"age\": "
    body += String(Int(user.age))
    body += ", \"position\": "
    body += user.position
    body += ", \"recieve_latest\": "
    body += String(Int(user.recieve_latest))
    body += "}"
    
    print(body)
    
    // format post request
    request.httpBody = body.data(using: String.Encoding.utf8)
    request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
    
    URLSession.shared.dataTask(with: request) { (data, response, error) in
        
        // Check for error
        if error != nil
        {
            print("error=\(String(describing: error))")
            failure()
            return
        }
        // Print out response string
        let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
        print("responseString = \(String(describing: responseString))")
        login(user: user, success: success, failure: failure)
    }.resume()
}

func login(user: Athlete, success: @escaping() -> Void, failure: @escaping() -> Void) {
   
    // Set user
    let loginString = String(format: "%@:%@", "nLiOWGY1DuXoGmF2YXBWBujm9rBYVPJ7P5qZyCSI", "JVEagxSti7coCd39roLgdKPmdNJ4tM7xfnOhnjpZKVPJCIVlVfxsIlqaFq064xF67CgmtZv78NivjMk4dtHuz8scv1j3erKadpgJk1HybLPGIGiDmpBXwOjRixmaiA64")
    let loginData = loginString.data(using: String.Encoding.utf8)!
    let base64LoginString = loginData.base64EncodedString()
    
    // Set request
    var request = URLRequest(url: URL(string: "https://raseup.azurewebsites.net/o/token/")!)
    request.httpMethod = "POST"
    request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
    
    // Set Data
    let post = "grant_type=password&username=" + user.email + "&password=" + user.password
    var postData = post.data(using: String.Encoding.ascii, allowLossyConversion: true)
    let postLength = "\(String(describing: postData?.count))"
    
    // format post request
    request.setValue(postLength, forHTTPHeaderField: "Content-Length")
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.httpBody = postData
    
    // fire off the request
    // Excute HTTP Request
    let task = URLSession.shared.dataTask(with: request) {
        data, response, error in
        
        // Check for error
        if error != nil {
            print("error=\(String(describing: error))")
            failure()
            return
        }
        
        // Print out response string
        // let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
        // print("responseString = \(String(describing: responseString))")
        
        // Convert server json response to NSDictionary
        do {
            if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                
                // Print out dictionary
                print(convertedJsonIntoDict)
                // Get value by key
                let tokenValue = convertedJsonIntoDict["access_token"] as? String
                if tokenValue == nil {
                    print("Could not get token")
                    failure()
                    return
                }
                print("Token: \(tokenValue!)")
            }
        } catch let error as NSError {
            print(error.localizedDescription)
            failure()
        }
    }
    task.resume()
}


