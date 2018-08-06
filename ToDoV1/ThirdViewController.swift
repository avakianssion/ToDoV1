//
//  ThirdViewController.swift
//  ToDoV1
//
//  Created by Sion Avakian on 7/10/17.
//  Copyright © 2017 Son Avakian. All rights reserved.
//

// Overview

import UIKit
import CoreData
import Charts

//import Charts

class ThirdViewController: UIViewController {
  //  @IBOutlet var pieChart: PieChartView!
   
    
    @IBOutlet var background: UIView!
    @IBOutlet var pieChart: PieChartView!
    var completeTasks = PieChartDataEntry(value: UserDefaults.standard.double(forKey: "completeTask"))
    var incompleteTasks = PieChartDataEntry(value: UserDefaults.standard.double(forKey: "incompleteTask"))
    
  /*  @IBAction func segueButton(_ sender: UIButton) {
        tabBarController?.selectedIndex = 1
        
    }
    */
    var numberOfTasks = [PieChartDataEntry]()
    
    override func viewDidLoad() {
    
        pieChart.chartDescription?.text=""
        
        numberOfTasks = [completeTasks, incompleteTasks]
        updateChartData()
        background.backgroundColor = UIColor.universalBackgroundColor
        updateChartData()
        pieChart.animate(xAxisDuration: 0.6)
        pieChart.clearValues()
        updateChartData()
        
    }/*
    override func viewDidAppear(_ animated: Bool) {
        background.backgroundColor = UIColor.universalBackgroundColor
        updateChartData()
        pieChart.animate(xAxisDuration: 0.6)
        pieChart.clearValues()
        updateChartData()

    }
    */
    func updateChartData() {
        let chartDataSet = PieChartDataSet(values: numberOfTasks, label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        
        let colors = [UIColor .universalGreen, UIColor .universalRed]
        chartDataSet.colors = colors
        pieChart.holeColor = UIColor.universalBackgroundColor
        pieChart.notifyDataSetChanged()
        pieChart.data = chartData
        

    }
    
}

