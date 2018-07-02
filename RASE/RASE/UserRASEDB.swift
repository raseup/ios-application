//
//  File.swift
//  RASE
//
//  Created by Sam Beaulieu on 8/15/17.
//  Copyright © 2017 RASE. All rights reserved.
//

import UIKit
import SQLite

extension RASEDB {
    
    // Creator For User Table
    func createUserTable() {
        do {
            try db!.run(users.create(ifNotExists: true) { table in
                table.column(id, primaryKey: true)
                table.column(oauthToken)
                table.column(name)
                table.column(email, unique: true)
                table.column(dateBirth)
                table.column(image)
                table.column(lastLoggedOn)
                table.column(version)
                table.column(workoutStart)
                table.column(daysWorked)
                table.column(targetDays)
                table.column(workoutCode)
            })
        } catch {
            print("Unable to create user table: \(error)")
        }
    }
    
    // Add a User to the Table, failure (same email, or db issue returns nil)
    func addUser(user: User) -> Int64? {
        do {
            var nimage: String = ""
            if let temp = user.image {
                nimage = imageToString64(image: temp)
            }
            
            var logOn: String = ""
            if let temp = user.lastLoggedOn {
                logOn = dateToStringWithTime(date: temp)
            }
            
            var startDate: String? = nil
            if let date = user.workoutStart {
                startDate = dateToString(date: date)
            }
            
            // Next add the user
            let insert = users.insert(
                oauthToken <- user.oauthToken,
                name <- user.name,
                email <- user.email,
                dateBirth <- dateToString(date: user.dateBirth),
                image <- nimage,
                lastLoggedOn <- logOn,
                version <- user.version.rawValue,
                workoutStart <- startDate,
                daysWorked <- user.daysWorked,
                targetDays <- user.targetDays,
                workoutCode <- user.workoutCode)
            let id = try db!.run(insert)
            
            return id
        } catch {
            return nil
        }
    }
    
    // Get all users from the database
    func getAllUsers() -> [User] {
        
        // Prepare variables to gather user data
        var tempUsers = [User]()
        
        do {
            // Gather all the users
            for each in try db!.prepare(self.users) {
                
                // Caste the right variables
                if  let versionType = Version(rawValue: each[version]!) {
                    
                    var startDate: Date? = nil
                    if let start = each[workoutStart] {
                        startDate = dateFromString(string: start)
                    }
                    
                    // Create and add the user
                    tempUsers.append(User(
                        oauthToken: each[oauthToken],
                        name: each[name],
                        email: each[email],
                        dateBirth: dateFromString(string: each[dateBirth]!),
                        image: imageFromString64(string: each[image]),
                        lastLogged: dateFromStringWithTime(string: each[lastLoggedOn]),
                        version: versionType,
                        workoutStart: startDate,
                        daysWorked: each[daysWorked],
                        targetDays: each[targetDays],
                        workoutCode: each[workoutCode]))
                }
            }
        } catch {
            print("Select all users failed: \(error)")
        }
        return tempUsers
    }
    
    // Get the primary user from the database
    func getPrimaryUser() -> User? {
        do {
            // Gather all the users
            for each in try db!.prepare(self.users) {
                
                // Caste the right variables
                if let oauthToken = each[oauthToken],
                    let versionType = Version(rawValue: each[version]!) {
                    
                    var startDate: Date? = nil
                    if let start = each[workoutStart] {
                        startDate = dateFromString(string: start)
                    }
                    
                    // Create and return the user
                    return User(
                        oauthToken: oauthToken,
                        name: each[name],
                        email: each[email],
                        dateBirth: dateFromString(string: each[dateBirth]!),
                        image: imageFromString64(string: each[image]),
                        lastLogged: dateFromStringWithTime(string: each[lastLoggedOn]),
                        version: versionType,
                        workoutStart: startDate,
                        daysWorked: each[daysWorked],
                        targetDays: each[targetDays],
                        workoutCode: each[workoutCode])
                }
            }
        } catch {
            print("Select all users failed: \(error)")
            return nil
        }
        return nil
    }
    
    // Delete user with specific email
    func deleteUser(nemail: String) -> Bool {
        do {
            // Search for the contact by email
            let user = users.filter(email == nemail)
            
            // Try to delete the user
            try db!.run(user.delete())
            return true
        } catch {
            print("Delete user failed: \(error)")
            return false
        }
    }
    
    // Update a user
    func updateUser(user: User) -> Bool {
        let tempUser = users.filter(email == user.email)
        do {
            var nimage: String = ""
            if let temp = user.image {
                nimage = imageToString64(image: temp)
            }
            
            var logOn: String = ""
            if let temp = user.lastLoggedOn {
                logOn = dateToStringWithTime(date: temp)
            }
            
            var startDate: String? = nil
            if let date = user.workoutStart {
                startDate = dateToString(date: date)
            }
            
            // Update the user
            let update = tempUser.update([
                oauthToken <- user.oauthToken,
                name <- user.name,
                email <- user.email,
                dateBirth <- dateToString(date: user.dateBirth),
                image <- nimage,
                lastLoggedOn <- logOn,
                version <- user.version.rawValue,
                workoutStart <- startDate,
                daysWorked <- user.daysWorked,
                targetDays <- user.targetDays,
                workoutCode <- user.workoutCode])
            if try db!.run(update) > 0 {
                return true
            }
        } catch {
            print("Update user failed: \(error)")
            return false
        }
        return false
    }
}

