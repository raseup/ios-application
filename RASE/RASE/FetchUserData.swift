//
//  FetchUserData.swift
//  RASE
//
//  Created by Sam Beaulieu on 8/19/17.
//  Copyright © 2017 RASE. All rights reserved.
//

import UIKit

func fetchUserData(token: String, success: @escaping() -> Void, failure: @escaping(_ message: String) -> Void) {
    
    // Prepare request header info
    print("Fetching user data from server using this token: \(token)")
    
    var request = URLRequest(url: URL(string: "http://raseup.azurewebsites.net/methods/get_user_data/")!)
    request.httpMethod = "GET"
    request.setValue(("Bearer \(token)"), forHTTPHeaderField: "Authorization")
    
    // Make the request
    URLSession.shared.dataTask(with: request) { (data, response, error) in
        
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
        
        //print(String(data: data!, encoding: String.Encoding.utf8) as String!)
        
        // Parse JSON response for user data
        do {
            // Obtain the body of the JSON response
            if let json = try JSONSerialization.jsonObject(with: data!) as? [String: Any] {
            
                if let error = json["error"] as? String {
                    print("error=\(String(describing: error))")
                    failure("An error occured. Please try again later")
                    return
                }
                
                guard let body = json["data"] as? [String: Any] else { failure("Server response did not contain user data"); return }
                
                print(body)
                        
                // Get the primary user data thats common for both athletes and coaches
                if let name = body["name"] as? String,
                    let email = body["email"] as? String,
                    let dateBirth = body["date_of_birth"] as? String,
                    let versionTemp = body["version"] as? String,
                    let version = Version(rawValue: versionTemp) {
                    
                    let workoutCode = body["workout_code"] as? Int
                    
                    let user = User(oauthToken: token, name: name, email: email, dateBirth: dateFromString(string: dateBirth), image: nil, lastLogged: Date(), version: version, workoutCode: workoutCode)
                    
                    // Save
                    DispatchQueue.main.async {
                        _ = RASEDB.instance.addUser(user: user)
                    }
                    // Request profile picture
                    DispatchQueue.main.async {
                        fetchProfilePicture(token: token, user: user)
                    }
                    // Send device token to RASE if it exists
                    DispatchQueue.main.async {
                        if let deviceToken = RASEDB.instance.getDeviceData(nkey: "device_token") {
                            sendDeviceToken(oauthToken: token, newDeviceToken: deviceToken, success: successSubFetch, failure: failureSubFetch)
                        }
                    }
                    
                    success()
                    return
                }
                // Could not extract users info from JSON
                else {
                    failure("Could not find any valid users in returned user data.")
                    return
                }
            }
            // Could not extract data from JSON
            else {
                failure("Could not convert server response to JSON. Please try again later.")
                return
            }
        }
        catch let error as NSError {
            print("error=\(String(describing: error))")
            failure("An error occured. Please try again later")
        }
    }.resume()
}

func successSubFetch() -> Void {}
func failureSubFetch(message: String) -> Void {print(message)}
