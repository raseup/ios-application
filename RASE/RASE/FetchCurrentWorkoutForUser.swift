//
//  FetchCurrentWorkoutForUser.swift
//  RASE
//
//  Created by Sam Beaulieu on 9/19/17.
//  Copyright © 2017 RASE. All rights reserved.
//

import UIKit
import AVFoundation

// Prepare request and get data from the server
func fetchCurrentWorkoutFromServer(oauthToken: String, code: Int, success: @escaping(_ workout: Workouts) -> Void, failure: @escaping(_ message: String) -> Void) {
    
    print("Fetching current workouts from server")
    
    // Prepare request header info
    var request = URLRequest(url: URL(string: "http://raseup.azurewebsites.net/methods/\(code)/get_existing_workout/")!)
    request.httpMethod = "GET"
    request.setValue(("Bearer \(oauthToken)"), forHTTPHeaderField: "Authorization")
    
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
        
        // print(String(data: data!, encoding: String.Encoding.utf8) as String!)
        
        // Parse JSON response for user data
        do {
            
            if let json = try JSONSerialization.jsonObject(with: data!) as? [String: Any] {
                
                // print(json)
                
                if let error = json["error"] as? String {
                    print("error=\(String(describing: error))")
                    failure("An error occured. Please try again later")
                    return
                }
                
                // Get the data and make sure the request was a success
                guard let body = json["data"] as? [String: Any] else { failure("Server response did not contain user data"); return }
                
                // Make sure the right workout was recieved
                guard let new_code = body["workout_code"] as? Int else { failure("Server response did not contain a valid workout."); return }
                if code != new_code { failure("Server response returned the wrong workout."); return }
                
                // Get the days of the week to be worked out
                var daysWorkedOut = body["days_a_week"] as? Int
                if daysWorkedOut == nil {
                    daysWorkedOut = 3 // Default to 3, can be changed
                }
                
                // Get the start date of the workout
                var startDate = Date()
                if let startString = body["date"] as? String {
                    startDate = dateFromStringWithTime(string: startString)
                }
                
                // Get the drills for the workout
                var drills = [DrillSummary]()
                if let tempDrills = body["drills"] as? [[String: Any]] {
                    
                    // Iterate through drills to create them
                    for each in tempDrills {
                        if  let name = each["name"] as? String,
                            let setsAndReps = each["sets_reps"] as? String,
                            let url_raw = each["url"] as? String,
                            let type = each["category"] as? String,
                            let code = each["code"]  as? Int,
                            let drillType = DrillType(rawValue: type.trimmingCharacters(in: .whitespacesAndNewlines)) {
                            
                            // Add the url prefix
                            var url: String
                            if let prefix = fromPropertyList(text: "Video URL Path") as? String {
                                url = prefix + url_raw
                            }
                            else {
                                url = url_raw
                            }
                            
                            let thumbImage = #imageLiteral(resourceName: "Thumbnail-Temp")
                            
                            let temp = DrillSummary(name: name, setsAndReps: setsAndReps, url: url, thumbnail: thumbImage, type: drillType, code: code)
                            
                            if let daysCompleted = each["completed_on"] as? [String] {
                                
                                let today = dateToString(date: Date())
                                for eachDay in daysCompleted {
                                    temp.daysCompleted.append(eachDay)
                                    if eachDay == today {
                                        temp.drillCompleted = true
                                    }
                                }
                            }
                            
                            // Add the drill to the drill array
                            drills.append(temp)
                        }
                    }
                }
                else {
                    failure("Server returned an invalid workout without any drills.")
                    return
                }
                
                // Get the equipment for the workout
                var equip = [EquipmentSummary]()
                if let equipmentData = body["equipment"] as? [[String: Any]] {
                    
                    // Iterate through equipment to create them
                    for each in equipmentData {
                        if  let name = each["name"] as? String,
                            let quantity = each["quantity"] as? Int {
                            
                            // Add the new equipment item to the array
                            equip.append(EquipmentSummary(name: name, quantity: quantity))
                        }
                    }
                }
                
                // Create the workout
                success(Workouts(startDate: startDate, daysAWeek: daysWorkedOut!, code: code, drills: drills, equipment: equip)!)
                return
            }
            else {
                failure("Could not convert server response to JSON. Please try again later.")
                return
            }
        }
        catch {
            print("Error deserializing JSON: \(error)")
            failure("An error occured. Please try again later")
            return
        }
    }.resume()
}
