//
//  UserModel.swift
//  RASE
//
//  Created by Sam Beaulieu on 8/17/17.
//  Copyright © 2017 RASE. All rights reserved.
//

import UIKit

enum Version: String {
    case solo = "solo_training_package"
    case coach = "coach_training_package"
}

class User {
    
    // Read-only user variables
    public private(set) var name: String!
    public private(set) var email: String!
    public private(set) var dateBirth: Date!
    
    // Mutable user variables (with observers for automatic saving)
    var oauthToken: String? { didSet { if updateDBAutomatically { updateDatabase() } } }
    var image: UIImage?     { didSet { if updateDBAutomatically { updateDatabase() } } }
    var lastLoggedOn: Date? { didSet { if updateDBAutomatically { updateDatabase() } } }
    var version: Version!   { didSet { if updateDBAutomatically { updateDatabase() } } }
    var workoutStart: Date? { didSet { if updateDBAutomatically { updateDatabase() } } }
    var daysWorked: Int?    { didSet { if updateDBAutomatically { updateDatabase() } } }
    var targetDays: Int?    { didSet { if updateDBAutomatically { updateDatabase() } } }
    var workoutCode: Int?   { didSet { if updateDBAutomatically { updateDatabase() } } }
    
    // Mutable member variable to enable/disable automatic database updating
    var updateDBAutomatically: Bool = false
    
    // User initializer
    init(oauthToken: String? = nil, name: String, email: String, dateBirth: Date, image: UIImage?, lastLogged: Date?, version: Version, workoutStart: Date? = nil, daysWorked: Int? = nil, targetDays: Int? = nil, workoutCode: Int? = nil, autoUpdate: Bool = true) {
        
        // Set all member variables
        self.oauthToken = oauthToken
        self.name = name
        self.email = email
        self.dateBirth = dateBirth
        self.image = image
        self.lastLoggedOn = lastLogged
        self.version = version
        self.workoutStart = workoutStart
        self.daysWorked = daysWorked
        self.targetDays = targetDays
        self.workoutCode = workoutCode
        
        // Enable/disable automatic updates (enabled by default)
        self.updateDBAutomatically = autoUpdate
    }
    
    // Log the user on
    func loggedOn() {
        self.lastLoggedOn = Date()
    }
    
    // Update the current user in the database asynchronously with a background thread
    func updateDatabase() {
        DispatchQueue.global(qos: .background).async {
            if !RASEDB.instance.updateUser(user: self) {
                _ = RASEDB.instance.updateUser(user: self)
            }
        }
    }
}
