//
//  DashboardModel.swift
//  RASE
//
//  Created by Sam Beaulieu on 7/10/17.
//  Copyright © 2017 RASE. All rights reserved.
//

import Foundation

class Dashboard {
    var fullName: String?
    var email: String?
    var quote: String?
    var drillSummaries = [drillSummary]()
    var completedDrills: allDrills?
    
    init?(data: Data) {
        do {
            if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any], let body = json["data"] as? [String: Any] {
                self.fullName = body["fullName"] as? String
                self.email = body["email"] as? String
                self.quote = body["quote"] as? String
                if let drills = body["drills"] as? [[String: Any]] {
                    self.drillSummaries = drills.map { drillSummary(json: $0) }
                }
                completedDrills = allDrills(total: drillSummaries.count)
                print("\(body)")
            }
        } catch {
            print("Error deserializing JSON: \(error)")
            return nil
        }
        print("Model Initialized")
    }
}

class allDrills {
    var totalDrills: Int?
    var currentlyCompleted: Int?
    
    init(total: Int) {
        self.totalDrills = total
        self.currentlyCompleted = 0
        print("Total Drills at: \(totalDrills)")
    }
    
    func incrementCompleted() {
        self.currentlyCompleted = self.currentlyCompleted! + 1
    }
    
    func decrementCompleted() {
        self.currentlyCompleted = self.currentlyCompleted! - 1
    }
}

class drillSummary {
    var videoURL: String?
    var drillName: String?
    var drillDescription: String?
    var drillCompleted: Bool?
    
    init(json: [String: Any]) {
        self.drillName = json["name"] as? String
        self.drillDescription = json["description"] as? String
        self.videoURL = json["url"] as? String
        self.drillCompleted = false
    }
}
