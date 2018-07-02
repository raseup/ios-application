//
//  SubmitWorkoutFeedback.swift
//  RASE
//
//  Created by Sam Beaulieu on 9/11/17.
//  Copyright © 2017 RASE. All rights reserved.
//


import UIKit
import AWSS3
import AWSCore
import AWSCognito

/*
// Function to submit feedback
func submitWorkoutFeedback(feedback: Feedback, token: String, success: @escaping() -> Void, failure: @escaping(_ message: String) -> Void) {
    
    // Once a video has been successfully uploaded if it has to be, generate JSON for put request
    var body = ""
    var count = 0
    body += "{\n"
    body += "\"workout_code\": "
    body += String(feedback.work.workoutCode)
    
    // Start by adding all the drills to the JSON along with lists of when they were completed
    if !feedback.work.drillSummaries.isEmpty {
        body += ",\n"
        
        // Prepare json for all drills
        body += "\"drill_completion\": ["
        for (index_drills, eachDrill) in feedback.work.drillSummaries.enumerated() {
            
            // Add the drill code to the json
            body += "{\n"
            body += "\"drill_code\": \""
            body += String(eachDrill.drillCode)
            body += "\""
            
            // If the drill has any days its been completed on, add those too
            if !eachDrill.daysCompleted.isEmpty {
                body += ",\n"
                body += "\"completed_on\": ["
                
                // Add all the days completed to an array
                for (index_days, eachDay) in eachDrill.daysCompleted.enumerated() {
                    body += "\""
                    body += eachDay
                    body += "\""
                    
                    // If its not the last day, add a comma
                    if index_days != eachDrill.daysCompleted.count - 1 {
                        body += ", "
                    }
                }
                
                body += "]\n}"
            }
            // If the drill has not been completed, simply close out the drill
            else {
                body += "\n}"
            }
            
            // If there are more drills in the list, add a comma
            if index_drills != feedback.work.drillSummaries.count - 1 {
                body += ",\n"
            }
        }
        body += "]"
    }
    
    // Then add any drill types that have been reviewed to the JSON
    count = 1
    if !feedback.drillTypes.isEmpty {
        body += ",\n"
        body += "\"drill_feedback\": {\n"
        for each in feedback.drillTypes {
            if each.value != 0 {
                body += "\""
                body += each.key.rawValue
                body += "\": "
                body += String(each.value)
                if count != feedback.drillTypes.count {
                    body += ",\n"
                }
                else {
                    body += "\n"
                }
                count += 1
            }
        }
        body += "}"
    }
    
    // Next add any coaches that have been reviewed to the JSON
    count = 1
    if !feedback.coachRating.isEmpty {
        body += ",\n"
        body += "\"coach_feedback\": [\n"
        for each in feedback.coachRating {
            body += "["
            body += String(each.key)
            body += ", "
            body += String(format: "%.3f", each.value)
            if count != feedback.coachRating.count {
                body += "], "
            }
            else {
                body += "]\n"
            }
            count += 1
        }
        body += "]"
    }
    
    // Finally, if there is a video thumbnail, add that to the JSON
    if feedback.videoThumbnail != nil {
        body += ",\n"
        body += "\"path\": \""
        body += feedback.videoPath!
        body += "\",\n"
        body += "\"thumbnail\": \""
        body +=  imageToString64(image: feedback.videoThumbnail!)
        body += "\"\n"
    }
    body += "}"
    

    // JSON Should be ready to submit the feedback to the server in a put request
    print(body)
    
    // Prepare the request itself
    var request = URLRequest(url: URL(string: "http://raseup.azurewebsites.net/methods/update_workout/")!)
    request.httpMethod = "PUT"
        
    // Format post request
    request.httpBody = body.data(using: String.Encoding.utf8)
    request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
    
    // Prepare request authorization
    request.setValue(("Bearer \(token)"), forHTTPHeaderField: "Authorization")
    
    // Send request
    URLSession.shared.dataTask(with: request) { (data, response, error) in
     
        // Check for error
        if error != nil
        {
            print("error=\(String(describing: error))")
            failure("Unable to submit workout feedback.")
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
            if let json = try JSONSerialization.jsonObject(with: data!) as? [String: Any] {
                
                if let body = json["data"] as? [String: Any] {
                    if "success" == body["message"] as? String {
                        success()
                        return
                    }
                    else {
                        failure("Server did not return a success message.")
                        return
                    }
                }
                else if let error = json["error"] as? String {
                    print("error=\(String(describing: error))")
                    failure("An error occured. Please try again later")
                    return
                }
                else {
                    failure("Server returned invalid response")
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
