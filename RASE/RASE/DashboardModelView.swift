//
//  DashboardModelView.swift
//  RASE
//
//  Created by Sam Beaulieu on 7/10/17.
//  Copyright © 2017 RASE. All rights reserved.
//

import Foundation
import UIKit

enum DashboardViewModelItemType {
    case name
    case completed
    case drills
}

protocol DashboardViewModelItem {
    var type: DashboardViewModelItemType { get }
    var rowCount: Int { get }
    var sectionTitle: String  { get }
}

extension DashboardViewModelItem {
    var rowCount: Int {
        return 1
    }
}

class DashboardViewModelProfileItem: DashboardViewModelItem {
    var type: DashboardViewModelItemType {
        return .name
    }
    var sectionTitle: String {
        return "Profile"
    }
    
    var fullName: String
    var email: String
    var quote: String
    
    init(fullName: String, email: String, quote: String) {
        self.fullName = fullName
        self.email = email
        self.quote = quote
    }
}

class DashboardViewModelCompletedItem: DashboardViewModelItem {
    var type: DashboardViewModelItemType {
        return .completed
    }
    var sectionTitle: String {
        return "Completed Drills"
    }
    
    var total: Int
    var completed: Int
    
    init(completionInfo: allDrills) {
        self.total = completionInfo.totalDrills!
        self.completed = completionInfo.currentlyCompleted!
    }
    
    func update(completionInfo: allDrills) {
        self.total = completionInfo.totalDrills!
        self.completed = completionInfo.currentlyCompleted!
    }
}

class DashboardViewModeldrillsItem: DashboardViewModelItem {
    var type: DashboardViewModelItemType {
        return .drills
    }
    var sectionTitle: String {
        return "Today's Drills"
    }
    var rowCount: Int {
        return drills.count
    }
    
    var drills: [drillSummary]
    
    init(drills: [drillSummary]) {
        self.drills = drills
    }
}

class DashboardViewModel: NSObject {
    
    var cells = [DashboardViewModelItem]()
    var drills = [drillSummary]()
    
    init(dashboard: Dashboard) {
        print("Initializing view model")
        super.init()
        
        // Add the profile cell to the list of cells
        if let name = dashboard.fullName, let email = dashboard.email, let quote = dashboard.quote {
            let profileItem = DashboardViewModelProfileItem(fullName: name, email: email, quote: quote)
            cells.append(profileItem)
        }
        
        // Add the completion status cell to the list of cells
        if let completed = dashboard.completedDrills {
            let completionItem = DashboardViewModelCompletedItem(completionInfo: completed)
            cells.append(completionItem)
        }
        
        // Add the drills cells to the list
        drills = dashboard.drillSummaries
        if !drills.isEmpty {
            let drillsItem = DashboardViewModeldrillsItem(drills: drills)
            cells.append(drillsItem)
        }
        
        print("View model initalized with \(cells.count) cells and \(drills.count) drills")
    }
}

extension DashboardViewModel: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        print("Section count is: \(cells.count)")
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Row count is: \(cells[section].rowCount) for section \(section)")
        return cells[section].rowCount
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return cells[section].sectionTitle
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        view.tintColor = UIColor(red: 218/255, green: 194/255, blue: 0, alpha: 1)
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.black
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = cells[indexPath.section]
        
        print("cell at row....")
        switch cell.type {
        case .name:
            if let newCell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath) as? DashboardViewControllerProfileCell {
                newCell.cell = cell
                return newCell
            }
        case .completed:
            if let newCell = tableView.dequeueReusableCell(withIdentifier: "completionCell", for: indexPath) as? DashboardViewControllerCompletionCell {
                newCell.cell = cell
                return newCell
            }
        case .drills:
            if let newCell = tableView.dequeueReusableCell(withIdentifier: "drillCell", for: indexPath) as? DashboardViewControllerDrillCell {
                newCell.drill = drills[indexPath.row]
                return newCell
            }
        }
        
        // return the default cell if none of above succeed
        return UITableViewCell()
    }
}
