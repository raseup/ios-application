//
//  File.swift
//  RASE
//
//  Created by Sam Beaulieu on 7/27/17.
//  Copyright © 2017 RASE. All rights reserved.
//

import UIKit
import Charts
/*
// View Controller for the Progress Cell
// - Once variable is set, it sets the views variables
class WorkoutsViewControllerProgressCell: UITableViewCell {

    @IBOutlet weak var ballHandlingPercentage: UILabel!
    @IBOutlet weak var defensePercentage: UILabel!
    @IBOutlet weak var passingPercentage: UILabel!
    @IBOutlet weak var finishingPercentage: UILabel!
    @IBOutlet weak var shootingPercentage: UILabel!
    
    @IBOutlet weak var shootingPieChart: PieChartView!
    @IBOutlet weak var ballHandlingPieChart: PieChartView!
    @IBOutlet weak var finishingPieChart: PieChartView!
    @IBOutlet weak var passingPieChart: PieChartView!
    @IBOutlet weak var defensePieChart: PieChartView!
    
    @IBOutlet weak var ballHandlingLabel: UILabel!
    @IBOutlet weak var shootingLabel: UILabel!
    @IBOutlet weak var finishingLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var passingLabel: UILabel!
    
    var progress: ProgressManager? {
        didSet {
            guard let progress = progress else {
                return
            }
            
            var size = ballHandlingLabel.fontSize
            if size < 12 {
                size = 10
                shootingLabel.font = shootingLabel.font.withSize(size)
                finishingLabel.font = finishingLabel.font.withSize(size)
                defenseLabel.font = defenseLabel.font.withSize(size)
                passingLabel.font = passingLabel.font.withSize(size)
                ballHandlingLabel.font = ballHandlingLabel.font.withSize(size)
            }
            
            ballHandlingPercentage.text = getPercentageString(completed: progress.weekProgress[1], total: progress.total[1])
            defensePercentage.text = getPercentageString(completed: progress.weekProgress[2], total: progress.total[2])
            passingPercentage.text = getPercentageString(completed: progress.weekProgress[3], total: progress.total[3])
            finishingPercentage.text = getPercentageString(completed: progress.weekProgress[4], total: progress.total[4])
            shootingPercentage.text = getPercentageString(completed: progress.weekProgress[5], total: progress.total[5])
            
            setChart(pieChartView: defensePieChart, completed: progress.weekProgress[2], total: progress.total[2], color: workoutOrange)
            setChart(pieChartView: ballHandlingPieChart, completed: progress.weekProgress[1], total: progress.total[1], color: workoutGreen)
            setChart(pieChartView: finishingPieChart, completed: progress.weekProgress[4], total: progress.total[4], color: workoutOrange)
            setChart(pieChartView: passingPieChart, completed: progress.weekProgress[3], total: progress.total[3], color: workoutGreen)
            setChart(pieChartView: shootingPieChart, completed: progress.weekProgress[5], total: progress.total[5], color: workoutOrange)
        }
    }
    
    func setChart(pieChartView: PieChartView, completed: Int, total: Int, color: UIColor) {
        
        // Prepare Data
        var dataEntries: [ChartDataEntry] = []
        dataEntries.append(ChartDataEntry(x: 0, y: Double(completed)))
        dataEntries.append(ChartDataEntry(x: 1, y: Double(total - completed)))
        
        // Prepare the data set
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "")
        pieChartDataSet.drawValuesEnabled = false
        pieChartDataSet.selectionShift = 0
        
        // Set up the chart itself
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChartView.data = pieChartData
        pieChartDataSet.colors = [color, .clear]
        pieChartView.holeColor = .clear
        pieChartView.backgroundColor = .clear
        pieChartView.drawEntryLabelsEnabled = false
        pieChartView.chartDescription?.enabled = false
        pieChartView.legend.enabled = false
        pieChartView.holeRadiusPercent = 0.9
    }
    
    func getPercentageString(completed: Int, total: Int) -> String {
        if total != 0 {
            let value = Double(completed)/Double(total) * 100
            return String(format:"%.0f", value) + "%"
        }
        else {
            return "N/A"
        }
    }
}
*/
