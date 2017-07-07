//
//  AthleteClass.swift
//  RASE
//
//  Created by Sam Beaulieu on 7/7/17.
//  Copyright © 2017 RASE. All rights reserved.
//

import Foundation

class Athlete {
    var email: String
    var password: String
    var first_name: String
    var last_name: String
    var age: Int64
    var position: String
    var recieve_latest: Int64
    var token: String
    
    init (email: String, password: String, first_name: String, last_name: String, age: Int64, position: String, recieve_latest: Int64, token: String) {
        self.email = email
        self.password = password
        self.first_name = first_name
        self.last_name = last_name
        self.age = age
        self.position = position
        self.recieve_latest = recieve_latest
        self.token = token
    }
}
