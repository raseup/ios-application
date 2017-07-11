//
//  DashboardViewController.swift
//  RASE
//
//  Created by Sam Beaulieu on 6/12/17.
//  Copyright © 2017 RASE. All rights reserved.
//

import UIKit

///// To be replaced with a function to get data from the server /////////
public func dataFromFile(_ filename: String) -> Data? {
    @objc class TestClass: NSObject { }
    let bundle = Bundle(for: TestClass.self)
    if let path = bundle.path(forResource: filename, ofType: "json") {
        return (try? Data(contentsOf: URL(fileURLWithPath: path)))
    }
    return nil
}

class DashboardViewController: UIViewController {
    
    @IBOutlet var dashboardTableView: UITableView!
    
    var dashboard: Dashboard?
    var dashboardViewModel: DashboardViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /////////////////////////////////
        //  Get data from server instead of read in data to create the Dashboard object
        guard let data = dataFromFile("ServerData"), let dash = Dashboard(data: data) else { return }
        //
        /////////////////////////////////
        
        dashboard = dash
        dashboardViewModel = DashboardViewModel(dashboard: dashboard!)
        
        print("Setting datasource")
        
        dashboardTableView.delegate = dashboardViewModel
        dashboardTableView.dataSource = dashboardViewModel
        
        dashboardTableView.rowHeight = UITableViewAutomaticDimension
        dashboardTableView.estimatedRowHeight = 266
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async{
            self.dashboardTableView.reloadData()
        }
        print("Appeared!")
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

class DashboardViewControllerProfileCell: UITableViewCell {

    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var quoteLabel: UILabel!
    
    var cell: DashboardViewModelItem? {
        didSet {
            // cast the ProfileViewModelItem to appropriate item type
            guard let cell = cell as? DashboardViewModelProfileItem  else {
                return
            }
            
            fullNameLabel.text = cell.fullName
            emailLabel.text = cell.email
            quoteLabel.text = cell.quote
        }
    }
    
}

class DashboardViewControllerCompletionCell: UITableViewCell {
    
    @IBOutlet weak var completionAmountLabel: UILabel!
    
    var cell: DashboardViewModelItem? {
        didSet {
            // cast the ProfileViewModelItem to appropriate item type
            guard let cell = cell as? DashboardViewModelCompletedItem  else {
                return
            }
            
            completionAmountLabel.text = "\(cell.completed) of \(cell.total) completed."
        }
    }
}

class DashboardViewControllerDrillCell: UITableViewCell {
    
    @IBOutlet weak var videoView: UIWebView!
    @IBOutlet weak var drillNameLabel: UILabel!
    @IBOutlet weak var drillDescriptionLabel: UITextView!
    @IBOutlet weak var completionSwitch: UISwitch!
    
    var drill: drillSummary? {
        didSet {
            // cast the ProfileViewModelItem to appropriate item type
            guard let drill = drill else {
                return
            }
            
            videoView.loadRequest(URLRequest(url: URL(string: drill.videoURL!)!))
            videoView.scalesPageToFit = true
            drillNameLabel.text = drill.drillName
            drillDescriptionLabel.text = drill.drillDescription
            completionSwitch.isOn = drill.drillCompleted!
        }
    }
    
}

