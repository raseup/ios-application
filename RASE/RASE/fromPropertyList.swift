//
//  fromPropertyList.swift
//  RASE
//
//  Created by Sam Beaulieu on 1/19/18.
//  Copyright © 2018 RASE. All rights reserved.
//

import Foundation

func fromPropertyList(text: String) -> Any? {
    if let path = Bundle.main.path(forResource: "RASE Settings", ofType: "plist") {
        if let dictRoot = NSDictionary(contentsOfFile: path) {
            if let val = dictRoot[text] {
                return val
            }
        }
    }
    return nil
}

