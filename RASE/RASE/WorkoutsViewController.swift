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

class WorkoutsViewController: UIViewController {
    
    @IBOutlet var workoutTableView: UITableView!
    
    var workouts: Workouts?
    var workoutsViewModel: WorkoutsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /////////////////////////////////
        //  Get data from server instead of read in data to create the Dashboard object
        guard let data = dataFromFile("ServerData"), let work = Workouts(data: data) else { return }
        //
        /////////////////////////////////
        
        workouts = work
        workoutsViewModel = WorkoutsViewModel(workout: workouts!)
        
        print("Setting datasource")
        
        workoutTableView.delegate = workoutsViewModel
        workoutTableView.dataSource = workoutsViewModel
        
        workoutTableView.rowHeight = UITableViewAutomaticDimension
        workoutTableView.estimatedRowHeight = 266
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async{
            self.workoutTableView.reloadData()
        }
        print("Appeared!")
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// View Controller for the Header Cell
// - Once variable is set, it sets the views variables
class WorkoutsViewControllerHeaderCell: UITableViewCell {

    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var dueDate: UILabel!
    @IBOutlet weak var daysLeft: UILabel!
    @IBOutlet weak var drillAmount: UILabel!
    
    var item: WorkoutsViewModelItem? {
        didSet {
            // cast the WorkoutsViewModelItem to appropriate item type
            guard let item = item as? WorkoutsViewModelHeaderItem  else {
                return
            }
            
            // Prepare and set date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/mm/yy"
            dueDate.text = dateFormatter.string(from: item.completeBy)
            
            // Set other variables
            daysLeft.text = String(item.daysLeft)
            drillAmount.text = String(item.drillNumber)
            
        }
    }
    
}

// View Controller for the upgrade Cell
// - Once variable is set, it sets the views variables
class WorkoutsViewControllerUpgradeCell: UITableViewCell {
    
    @IBOutlet weak var upgradeButton: UIButton!

}

// View Controller for the Progress Cell
// - Once variable is set, it sets the views variables
//************ Will be switched to charts instead of text ************//
class WorkoutsViewControllerProgressCell: UITableViewCell {
    
    @IBOutlet weak var fundamentals: UILabel!
    @IBOutlet weak var ballHandling: UILabel!
    @IBOutlet weak var defense: UILabel!
    @IBOutlet weak var passing: UILabel!
    @IBOutlet weak var finishing: UILabel!
    @IBOutlet weak var shooting: UILabel!
    
    var progress: ProgressManager? {
        didSet {
            guard let progress = progress else {
                return
            }

            fundamentals.text = "\(progress.progress![0])/\(progress.total![0])"
            ballHandling.text = "\(progress.progress![1])/\(progress.total![1])"
            defense.text = "\(progress.progress![2])/\(progress.total![2])"
            passing.text = "\(progress.progress![3])/\(progress.total![3])"
            finishing.text = "\(progress.progress![4])/\(progress.total![4])"
            shooting.text = "\(progress.progress![5])/\(progress.total![5])"
        }
    }
}

// View Controller for the Description Cell
// - Once variable is set, it sets the views variables
class WorkoutsViewControllerDescriptionCell: UITableViewCell {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var item: WorkoutsViewModelItem? {
        didSet {
            guard let item = item as? WorkoutsViewModelDescriptionItem  else{
                return
            }
            
            descriptionLabel.text = item.description
            
            
        }
    }
}

// View Controller for Drill Cells
class WorkoutsViewControllerDrillCell: UITableViewCell {
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var completed: UIButton!
    @IBOutlet weak var setsAndReps: UILabel!
    @IBOutlet weak var title: UILabel!
    
    var drill: DrillSummary? {
        didSet {
            // Make sure drill has been set
            guard let drill = drill else {
                return
            }
            
            setsAndReps.text = "Reps: \(String(describing: drill.drillReps)) / Sets: \(String(describing: drill.drillSets))"
            title.text = drill.drillName
        }
    }
    
    var progress: ProgressManager?
    
    @IBAction func completedPressed(_ sender: Any) {
        
        if (drill?.drillCompleted == false) {
            completed.setImage(#imageLiteral(resourceName: "clicked"), for: .normal)
            drill?.drillCompleted = true
            progress?.completeADrill(type: (drill?.drillType)!)
        }
        else {
            completed.setImage(#imageLiteral(resourceName: "unclicked"), for: .normal)
            drill?.drillCompleted = false
            progress?.uncompleteADrill(type: (drill?.drillType)!)
        }
    }
}

// View Controller for the dynamic headers
class CustomTableHeader: UITableViewHeaderFooterView {
    
    @IBOutlet weak var sectionTitleLabel: UILabel!
    @IBOutlet weak var arrowLabel: UILabel!

    var section: Int = 0
    weak var delegate: customTableHeaderDelegate?
    
    var item: WorkoutsViewModelItem? {
        didSet {
            guard let item = item else {
                return
            }
            sectionTitleLabel?.text = item.sectionTitle
            collapse(collapsed: item.isCollapsed)
        }
    }
    
    func collapse(collapsed: Bool) {
        arrowLabel?.rotate(collapsed ? 0.0 : .pi)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(headerTapped)))
    }
    
    @objc private func headerTapped(gestureRecognizer: UITapGestureRecognizer) {
        delegate?.toggleSection(header: self, section: section)
    }
    
}

protocol customTableHeaderDelegate: class {
    func toggleSection(header: customTableHeader, section: Int)
}

extension UIView {
    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        self.layer.add(animation, forKey: nil)
    }
}

