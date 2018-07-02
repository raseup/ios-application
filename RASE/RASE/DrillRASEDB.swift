//
//  DrillRASEDB.swift
//  RASE
//
//  Created by Sam Beaulieu on 8/9/17.
//  Copyright © 2017 RASE. All rights reserved.
//

import SQLite

extension RASEDB {
    
    // Creator For Drill Table
    func createDrillTable() {
        do {
            try db!.run(drills.create(ifNotExists: true) { table in
                table.column(id, primaryKey: true)
                table.column(drillName)
                table.column(drillSetsAndReps)
                table.column(videoURL)
                table.column(thumbnailURL)
                table.column(drillType)
                table.column(drillCode, unique: true)
                table.column(completedOn)
                table.column(changed)
            })
        } catch {
            print("Unable to create drill table: \(error)")
        }
    }
    
    // Add a Drill to the Drill Table
    func addDrill(newDrill: DrillSummary) -> Int64? {
        do {
            // Prepare the date completed string
            var daysCompleted = ""
            for (index, eachDay) in newDrill.daysCompleted.enumerated() {
                daysCompleted += eachDay
                
                if index != newDrill.daysCompleted.count - 1 {
                    daysCompleted += " "
                }
            }
            
            let insert = drills.insert(
                drillName <- newDrill.drillName,
                drillSetsAndReps <- newDrill.drillSetsAndReps,
                videoURL <- newDrill.videoURL,
                thumbnailURL <- imageToString64(image: newDrill.thumbnail),
                drillType <- newDrill.drillType.rawValue,
                drillCode <- newDrill.drillCode,
                completedOn <- daysCompleted,
                changed <- newDrill.locallyChanged)
            let id = try db!.run(insert)
            
            return id
        } catch {
            print("Insert drill failed: \(error)")
            return nil
        }
    }
    
    // Get all drills for a workouts ID from the database
    func getDrills() -> [DrillSummary] {
        
        // Prepare variables to gather workout data
        var drills = [DrillSummary]()
        
        do {
            // Gather all the drills associated with the workout
            for eachDrill in try db!.prepare(self.drills) {
                if let drillType = DrillType(rawValue: eachDrill[drillType]) {
                    
                    var completed = [String]()
                    if eachDrill[completedOn] != "" {
                        completed = eachDrill[completedOn].components(separatedBy: " ")
                    }
                    
                    drills.append(DrillSummary(
                        name: eachDrill[drillName],
                        setsAndReps: eachDrill[drillSetsAndReps],
                        url: eachDrill[videoURL],
                        thumbnail: imageFromString64(string: eachDrill[thumbnailURL])!,
                        type: drillType,
                        code: eachDrill[drillCode],
                        daysCompleted: completed,
                        locallyChanged: eachDrill[changed]))
                }
            }
        } catch {
            print("Select drill by workout failed: \(error)")
        }
        
        return drills
    }
    
    // Delete drills with specific drill id
    func deleteDrill(code: Int) -> Bool {
        do {
            let drill = drills.filter(drillCode == code)
            try db!.run(drill.delete())
            return true
        } catch {
            print("Delete drill failed: \(error)")
            return false
        }
    }
    
    
    // Update drill
    func updateDrill(drill: DrillSummary) -> Bool {
        let newDrill = drills.filter(drillCode == drill.drillCode)
        do {
            // Prepare the date completed string
            var daysCompleted = ""
            for (index, eachDay) in drill.daysCompleted.enumerated() {
                daysCompleted += eachDay
                
                if index != drill.daysCompleted.count - 1 {
                    daysCompleted += " "
                }
            }
            
            if drill.imagesChanged {
                let update = newDrill.update([
                    drillName <- drill.drillName,
                    drillSetsAndReps <- drill.drillSetsAndReps,
                    videoURL <- drill.videoURL,
                    thumbnailURL <- imageToString64(image: drill.thumbnail),
                    drillType <- drill.drillType.rawValue,
                    drillCode <- drill.drillCode,
                    completedOn <- daysCompleted,
                    changed <- drill.locallyChanged
                    ])
                if try db!.run(update) > 0 {
                    return true
                }
                drill.imagesChanged = false
            }
            else {
                let update = newDrill.update([
                    drillName <- drill.drillName,
                    drillSetsAndReps <- drill.drillSetsAndReps,
                    videoURL <- drill.videoURL,
                    drillType <- drill.drillType.rawValue,
                    drillCode <- drill.drillCode,
                    completedOn <- daysCompleted,
                    changed <- drill.locallyChanged
                    ])
                if try db!.run(update) > 0 {
                    return true
                }
            }
        } catch {
            print("Update drill failed: \(error)")
        }
        
        return false
    }
}
