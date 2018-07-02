//
//  RASEDB.swift
//  RASE
//
//  Created by Sam Beaulieu on 8/8/17.
//  Copyright © 2017 RASE. All rights reserved.
//

import SQLite

class RASEDB {
    
    // Singleton Database Instance
    static let instance = RASEDB()
    let db: Connection?
    
    /////////////////////////// DRILL TABLES AND COLUMNS ///////////////////////////////
    
    // Define Drills Table Variables
    let drills = Table("drills")
    let id = Expression<Int64>("id")
    let drillName = Expression<String>("drill_name")
    let drillSetsAndReps = Expression<String>("drill_sets_and_reps")
    let videoURL = Expression<String>("url")
    let thumbnailURL = Expression<String>("drill_thumb")
    let drillType = Expression<String>("drill_type")
    let drillCode = Expression<Int>("drill_code")
    let completedOn = Expression<String>("day_completed")
    let changed = Expression<Bool>("locally_changed")
    
    /////////////////////////// USER TABLE AND COLUMNS //////////////////////////////////
    let users = Table("users")
    // let id = Expression<Int64?>("id")
    let oauthToken = Expression<String?>("oauthToken")
    let name = Expression<String>("name")
    let email = Expression<String>("email")
    let dateBirth = Expression<String?>("date_of_birth")
    let image = Expression<String>("image")
    let lastLoggedOn = Expression<String>("last_logged_on")
    let version = Expression<String?>("version")
    let workoutStart = Expression<String?>("start_date")
    let daysWorked = Expression<Int?>("days_worked")
    let targetDays = Expression<Int?>("target_days")
    let workoutCode = Expression<Int?>("workouts_code")
    
    /////////////////////////// PHONE SPECIFIC DATA //////////////////////////////////
    let deviceData = Table("deviceData")
    let key = Expression<String>("key")
    let value = Expression<String>("value")

    // Constructor
    init() {
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
            ).first!
        
        do {
            db = try Connection("\(path)/rase.sqlite3")
        } catch {
            db = nil
            print ("Unable to open database")
        }
        
        createDrillTable()
        createUserTable()
        createDeviceDataTable()
    }
}
