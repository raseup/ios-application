//
//  DeviceRASEDB.swift
//  RASE
//
//  Created by Sam Beaulieu on 10/21/17.
//  Copyright © 2017 RASE. All rights reserved.
//

import SQLite

extension RASEDB {
    
    // Creator For Device Data Table
    func createDeviceDataTable() {
        do {
            try db!.run(deviceData.create(ifNotExists: true) { table in
                table.column(id, primaryKey: true)
                table.column(key, unique: true)
                table.column(value)
            })
        } catch {
            print("Unable to create device table: \(error)")
        }
    }
    
    // Add device data to the Table
    // - Create the insert command and run it for the given key value pair
    func addDeviceData(nkey: String, nvalue: String) -> Int64? {
        do {
            let insert = deviceData.insert(
                key <- nkey,
                value <- nvalue)
            let id = try db!.run(insert)
            return id
        } catch {
            print("Insert device data failed: \(error)")
            return nil
        }
    }
    
    // Get the requested value for the key-value pair
    func getDeviceData(nkey: String) -> String? {
        do {
            for each in try db!.prepare(self.deviceData) {
                if nkey == each[key] {
                    return each[value]
                }
            }
        } catch {
            return nil
        }
        return nil
    }
    
    // Delete the requested key-value pair
    func deleteDeviceData(nkey: String) -> Bool {
        do {
            let data = deviceData.filter(key == nkey)
            try db!.run(data.delete())
            return true
        } catch {
            return false
        }
    }
    
    // Update requested key-value pair
    func updateDeviceData(nkey: String, nvalue: String) -> Bool {
        do {
            let new = deviceData.filter(key == nkey)
            let update = new.update([
                key <- nkey,
                value <- nvalue
                ])
            if try db!.run(update) > 0 {
                return true
            }
        } catch {
            return false
        }
        return false
    }
}
