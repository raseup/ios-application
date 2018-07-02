//
//  DateHelperFunctions.swift
//  RASE
//
//  Created by Sam Beaulieu on 8/11/17.
//  Copyright © 2017 RASE. All rights reserved.
//

import Foundation

func dateToString(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd" // Date format
    dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00") // Current time zone, will likely need to be changed
    return dateFormatter.string(from: date)
}

func dateToStringReadable(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM d, yyyy" // Date format
    dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00") // Current time zone, will likely need to be changed
    return dateFormatter.string(from: date)
}

func dateToStringReadableNoYear(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMMM d" // Date format
    dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00") // Current time zone, will likely need to be changed
    return dateFormatter.string(from: date)
}

// Formats the date properly for the notifications
func dateToStringNotifications(date: Date) -> String {
    
    // Get passed date and current as calendar objects
    let currentCalendar = Calendar.current
    let difference = currentCalendar.dateComponents([.day, .hour, .minute], from: date, to: Date())
    
    // If the date is more than a day ago, simply return the number of days
    if difference.day! > 1 {
        return "\(difference.day!) days ago"
    }
    // If the date is from the day before, return yesterday at the time
    else if difference.day == 1 {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a" // Date format
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00") // Current time zone, will likely need to be changed
        return "Yesterday at " + dateFormatter.string(from: date)
    }
    // If the date is from today, first check to see if it was more than 3 hours ago
    else {
    
        // If it was three or more hours ago
        if difference.hour! > 3 {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "h:mm a" // Date format
            dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00") // Current time zone, will likely need to be changed
            return "Today at " + dateFormatter.string(from: date)
        }
        // If the date was 1 or more hours ago
        else if difference.hour! > 0 {
            return "\(difference.hour!) hours ago"
        }
        // Else the date is within the hour, make sure its longer than a minute than return
        else {
            
            // If more than a minute, return that numnber of minutes
            if difference.minute! > 0 {
                return "\(difference.minute!) minutes ago"
            }
            // Finally if none of the above, must be within the last minute
            else {
                return "Less than a minute ago"
            }
        }
    }
}

func dateToStringMessaging(date: Date) -> String {
    let currentCalendar = Calendar.current
    let messageDate = currentCalendar.ordinality(of: .weekOfYear, in: .era, for: date)!
    let currentDate = currentCalendar.ordinality(of: .weekOfYear, in: .era, for: Date())!
    
    // If it was over a week ago, use the full date (two digits for year)
    if currentDate - messageDate > 0 {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/d/yy" // Date format
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00") // Current time zone, will likely need to be changed
        return dateFormatter.string(from: date)
    }
    // Else the date was within the week -> Check the day
    else {
        let messageDateDay = currentCalendar.ordinality(of: .day, in: .era, for: date)!
        let currentDateDay = currentCalendar.ordinality(of: .day, in: .era, for: Date())!
        
        // If it was more than yesterday, return the day of the week
        if currentDateDay - messageDateDay > 1 {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE" // Date format
            dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00") // Current time zone, will likely need to be changed
            return dateFormatter.string(from: date)
        }
        // Else if it was yesterday return yesterday
        if currentDateDay - messageDateDay == 1 {
            return "Yesterday"
        }
        // Else it was the same day so just return the time
        else{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "h:mm a" // Date format
            dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00") // Current time zone, will likely need to be changed
            return dateFormatter.string(from: date)
        }
    }
    
}

func dateToStringWithTime(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'" // Date format
    dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00") // Current time zone, will likely need to be changed
    return dateFormatter.string(from: date)
}

func dateFromString(string: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd" // Date format
    dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00") // Current time zone, will likely need to be changed
    return dateFormatter.date(from: string)!
}

func dateFromStringWithTime(string: String) -> Date {
    
    // Try to get it with fractions of a second
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.S'Z'" // Date format
    dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00") // Current time zone, will likely need to be changed
    if let returnString = dateFormatter.date(from: string) {
        return returnString
    }
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    if let returnString = dateFormatter.date(from: string) {
        return returnString
    }
    return dateFormatter.date(from: string)!
}

func timeToString(seconds: Double) -> String {
    
    var returnString: String!
    
    if seconds < 60 {
        returnString = String(format: "%.2f", seconds) + " secs"
    }
    else {
        let mins: Int = Int(floor(seconds/60.0))
        let sec = seconds.truncatingRemainder(dividingBy: 60.0)
        returnString = "\(mins)." + String(format: "%.2f", sec) + " mins"
    }
    
    return returnString
}
