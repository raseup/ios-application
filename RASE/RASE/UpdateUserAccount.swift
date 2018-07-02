//
//  AccountManagement.swift
//  RASE
//
//  Created by Sam Beaulieu on 7/6/17.
//  Copyright © 2017 RASE. All rights reserved.
//

import UIKit

// Functions to manage account creation
func updateUser(newData: [String: String], success: @escaping() -> Void, failure: @escaping(_ message: String) -> Void) {
    /*
    var body = ""
    var numAddedToJSON = 0
    
    if let type = newData["userType"] {
        if type == "coach" {
            
            body += "{\n"
            
            if let newPassword = newData["newPassword"] {
                body += "\"new_password\": \""
                body += newPassword + "\""
                
                // Add comma if necessary
                numAddedToJSON += 1
                if numAddedToJSON != newData.count {
                    body += ","
                }
                body += "\n"
            }
            if let newDescription = newData["newDescription"] {
                body += "\"new_description\": \""
                body += newDescription + "\""
                
                // Add comma if necessary
                numAddedToJSON += 1
                if numAddedToJSON != newData.count {
                    body += ","
                }
                body += "\n"
            }
            if let newAvailability = newData["newAvailability"] {
                body += "\"new_availability\": \""
                body += newAvailability + "\""
                
                // Add comma if necessary
                numAddedToJSON += 1
                if numAddedToJSON != newData.count {
                    body += ","
                }
                body += "\n"
            }
            if let newImage = newData["newImage"] {
                body += "\"new_image\": \""
                body += newImage + "\""
                
                // Add comma if necessary
                numAddedToJSON += 1
                if numAddedToJSON != newData.count {
                    body += ","
                }
                body += "\n"
            }
            
            guard let oldPassword = newData["oldPassword"] else { failure("Could not find old password."); return }
            body += "\"old_password\": \""
            body += oldPassword
            body += "\"\n}"
        }
        else if type == "athlete" {
            
            body += "{\n"
            
            if let newPassword = newData["newPassword"] {
                body += "\"new_password\": \""
                body += newPassword + "\""
                
                // Add comma if necessary
                numAddedToJSON += 1
                if numAddedToJSON != newData.count {
                    body += ","
                }
                body += "\n"
            }
            if let newPosition = newData["newPosition"] {
                body += "\"new_position\": \""
                body += newPosition + "\""
                
                // Add comma if necessary
                numAddedToJSON += 1
                if numAddedToJSON != newData.count {
                    body += ","
                }
                body += "\n"
            }
            if let newDays = newData["newDays"] {
                body += "\"new_days_a_week\": "
                body += newDays
                
                // Add comma if necessary
                numAddedToJSON += 1
                if numAddedToJSON != newData.count {
                    body += ","
                }
                body += "\n"
            }
            if let newImage = newData["newImage"] {
                body += "\"new_image\": \""
                body += newImage + "\""
                
                // Add comma if necessary
                numAddedToJSON += 1
                if numAddedToJSON != newData.count {
                    body += ","
                }
                body += "\n"
            }
            guard let oldPassword = newData["oldPassword"] else { failure("Could not find old password."); return }
            body += "\"old_password\": \""
            body += oldPassword
            body += "\"\n}"
        }
    }
    
    print(body)
    
    if body != "" {
        var request = URLRequest(url: URL(string: "http://raseup.azurewebsites.net/methods/update_user/")!)
        request.httpMethod = "PUT"
        
        // format post request
        request.httpBody = body.data(using: String.Encoding.utf8)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        guard let local = localDataManager.sharedInstance.localUser else { failure("Could not get local user."); return }
        request.setValue(("Bearer \(local.token!)"), forHTTPHeaderField: "Authorization")

        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
        
            // Check for error
            if error != nil
            {
                print("error=\(String(describing: error))")
                failure("An error occured. Please try again later")
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
                        failure("An error occured. Please try again later")
                        return
                    }
                    
                    guard let body = json["data"] as? [String: Any] else { failure("Could not get data from the json."); return }

                    if "success" != body["message"] as? String {
                        failure("Server response did not contain user data")
                        return
                    }

                    // Update the days a week, position, and image of a player as needed
                    if newData["userType"] == "athlete",
                        let athlete = local as? Athlete {
                        
                        if let newPosition = newData["newPosition"],
                            let position = PositionType(rawValue: newPosition) {
                            athlete.position = position
                        }
                        if let newDays = newData["newDays"] {
                            athlete.days = Int(newDays)
                        }
                        if let newImage = newData["newImage"] {
                            athlete.image = imageFromString64(string: newImage)
                        }
                        success()
                        return
                    }
                    // Update the description, availability and image of a coach as needed
                    else if newData["userType"] == "coach", let coach = local as? Coach {
                        
                        if let newDescription = newData["newDescription"] {
                            coach.description = newDescription
                        }
                        if let newAvailability = newData["newAvailability"] {
                            coach.availability = newAvailability
                        }
                        if let newImage = newData["newImage"] {
                            coach.image = imageFromString64(string: newImage)
                        }
                        success()
                        return

                    }
                    else {
                        failure("Invalid user type for account updating.")
                        return
                    }
                }
                else {
                    failure("Could not convert server response to JSON. Please try again later.")
                    return
                }
            }
            catch {
                failure("An error occured. Please try again later")
                return
            }
        }.resume()
    }*/
}
