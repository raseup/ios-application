//
//  DashboardModel.swift
//  RASE
//
//  Created by Sam Beaulieu on 7/10/17.
//  Copyright © 2017 RASE. All rights reserved.
//

import Foundation

// Enum to keep track of different drill types
enum DrillType {
    case fundamentals
    case ballHandling
    case defense
    case passing
    case finishing
    case shooting
}

// Enum to keep track of different version types
enum Version {
    case lite
    case basic
    case premium
}

class Workouts {
    
    // Workout variables - holds all data required for a week's workout
    var description: String?
    var currentVersion: Version?
    var drillSummaries = [DrillSummary]()
    var completeBy: Date?
    var daysLeft: Int?
    var drillNumber: Int?
    var completedDrills: ProgressManager?
    
    // Initialize a Workout from JSON data
    // @param Data: Takes in JSON data and parses it for a description, version, and drills
    // - Use for generating a new workout each week and storing it in storage
    init?(data: Data) {
        do {
            if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any], let body = json["data"] as? [String: Any] {
                
                // Get description, version, and drills from JSON input
                self.description = body["description"] as? String
                if let version = body["version"] as? String {
                    switch version {
                        case "lite":
                            self.currentVersion = .lite
                        case "basic":
                            self.currentVersion = .basic
                        case "premium":
                            self.currentVersion = .premium
                        default: break
                    }
                }
                if let drills = body["drills"] as? [[String: Any]] {
                    self.drillSummaries = drills.map { DrillSummary(json: $0) }
                }
                
                // Set the complete by date to be exactly one week into the future
                self.completeBy = Calendar.current.date(byAdding: .day, value: 7, to: Date())
                
                // Set the days left variable to 7
                self.daysLeft = 7
                
                // Set the total number of drills to the amount loaded from JSON and the completed drills to zero
                self.drillNumber = drillSummaries.count
                self.completedDrills = ProgressManager(allDrills: drillSummaries)
            }
        } catch {
            print("Error deserializing JSON: \(error)")
            return nil
        }
        print("Model Initialized")
    }
}

// Class object to hold a summary of a specific drill
// - Each drill has a name, sets, reps, urls, type, and completed value
// - Is maintained in an array by an instance of the workout class (above)
class DrillSummary {
    var drillName: String?
    var drillSets: Int?
    var drillReps: Int?
    var videoURL: String?
    var thumbnailURL: String?
    var drillType: DrillType?
    var drillCompleted: Bool?
    
    // Initialize a drill in a workout
    // @params json: an array of json data that can be parsed to get a workout
    // - Each workout should have a name, sets, reps, video_url, and image_url
    init(json: [String: Any]) {
        // Get name, sets, reps, and url data directly from JSON
        self.drillName = json["name"] as? String
        self.drillSets = json["sets"] as? Int
        self.drillReps = json["reps"] as? Int
        self.videoURL = json["video_url"] as? String
        self.thumbnailURL = json["image_url"] as? String
        self.drillCompleted = false
        
        // Parse JSON for the drill type
        if let type = json["type"] as? String {
            switch type {
                case "fundamentals":
                    self.drillType = .fundamentals
                case "ball_handling":
                    self.drillType = .ballHandling
                case "defense":
                    self.drillType = .defense
                case "passing":
                    self.drillType = .passing
                case "finishing":
                    self.drillType = .finishing
                case "shooting":
                    self.drillType = .shooting
                default: break
            }
        }
    }
}

// Keeps track of the workouts current progress throughout the week
class ProgressManager {
    var progress: [Int]?
    var total: [Int]?
    
    // Initializes the local variable to an array of each of the drill types with no drills completed
    // - Order of array is in the same as the enum DrillType
    // - Initalizes the total amount of drills per type as well
    init(allDrills: [DrillSummary]) {
        
        // Initialize both progress and totals to zeros
        progress = [0, 0, 0, 0, 0, 0]
        total = [0, 0, 0, 0, 0, 0]
        
        // Initialize the drill sections to the right values
        for drills in allDrills {
            switch drills.drillType! {
                case .fundamentals:
                    total![0] = total![0] + 1
                case .ballHandling:
                    total![1] = total![1] + 1
                case .defense:
                    total![2] = total![2] + 1
                case .passing:
                    total![3] = total![3] + 1
                case .finishing:
                    total![4] = total![4] + 1
                case .shooting:
                    total![5] = total![5] + 1
            }
        }
    }
    
    // Function to finish a drill
    // - Takes the type so it knows which to increment
    func completeADrill(type: DrillType) {
        switch type {
            case .fundamentals:
                progress![0] = progress![0] + 1
            case .ballHandling:
                progress![1] = progress![1] + 1
            case .defense:
                progress![2] = progress![2] + 1
            case .passing:
                progress![3] = progress![3] + 1
            case .finishing:
                progress![4] = progress![4] + 1
            case .shooting:
                progress![5] = progress![5] + 1
        }
    }
    
    // Function to unfinish a drill
    // - Takes the type so it knows which to decrement
    func uncompleteADrill(type: DrillType) {
        switch type {
            case .fundamentals:
                progress![0] = progress![0] - 1
            case .ballHandling:
                progress![1] = progress![1] - 1
            case .defense:
                progress![2] = progress![2] - 1
            case .passing:
                progress![3] = progress![3] - 1
            case .finishing:
                progress![4] = progress![4] - 1
            case .shooting:
                progress![5] = progress![5] - 1
        }
    }
}
