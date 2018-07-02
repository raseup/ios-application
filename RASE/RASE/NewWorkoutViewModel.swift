//
//  NewWorkoutViewModel.swift
//  RASE
//
//  Created by Sam Beaulieu on 11/13/17.
//  Copyright © 2017 RASE. All rights reserved.
//


import UIKit
/*
// Class to model the new athlete view by adding whatever items are necessary to an array
// - The list of items will contain data for each of the sections to be added
// - This class initializes all the item classes and puts them in the right order
class NewWorkoutViewModel: HomeViewModel {
    
    // References to all the drills, the current progress, and the sections to be implemented
    var items = [NewWorkoutViewModelItem]()
    
    var parent: HomeViewController!
    
    init(parent: HomeViewController) {
        super.init()
        
        self.parent = parent
        
        // Add each section to the list of items
        let bufferItem2 = NewWorkoutViewModelBufferItem()
        items.append(bufferItem2)
        
        let welcomeItem = NewWorkoutViewModelWelcomeItem()
        items.append(welcomeItem)
        
        let bufferItem1 = NewWorkoutViewModelBufferItem()
        items.append(bufferItem1)
        
        let tutorialItem = NewWorkoutViewModelTutorialtItem()
        items.append(tutorialItem)
    }
    
    // Returns the number of sections to the table
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    // Returns the number of rows per section of the table
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].rowCount
    }
    
    // Returns the cell to be displayed at a certain row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = items[indexPath.section]
        
        switch section.type {
        // Add the header cells to the list
        case .welcome:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "newWelcomeItem", for: indexPath) as? NewWorkoutViewControllerWelcomeCell {
                cell.parent = parent
                return cell
            }
            
        case .tutorial:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "newTutorialItem", for: indexPath) as? NewWorkoutViewControllerTutorialCell {
                return cell
            }
            
        case .buffer:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "newBufferItem", for: indexPath) as? NewWorkoutViewBufferCell {
                let height = (UIScreen.main.bounds.height - 250 - 200 - 64 - 44) / 2
                cell.height.constant = height
                return cell
            }
        }
        
        // return the default cell if none of above succeed
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}*/
