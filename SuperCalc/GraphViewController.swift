//
//  GraphViewController.swift
//  SuperCalc
//
//  Created by Starboy on 3/30/2559 BE.
//  Copyright © 2559 Natnicha Thonket. All rights reserved.
//

import UIKit
import Charts

class GraphViewController: UIViewController {

    @IBOutlet weak var linechart: LineChartView!


    let months:[Double] = [-1,0,1]
    
    let dollars1:[Double] = [-1,0,1]
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        // 1
//        lineChartView.delegate = self
//        // 2
//        lineChartView.descriptionText = "Tap node for details"
//        // 3
//        lineChartView.descriptionTextColor = UIColor.whiteColor()
//        lineChartView.gridBackgroundColor = UIColor.darkGrayColor()
//        // 4
//        lineChartView.noDataText = "You need to provide data for the chart."
//        // 5
        setChartData(months,values: dollars1)
    }
    
    func setChartData(months : [Double],values: [Double]) {
        // 1 - creating an array of data entries
        var yVals1 : [ChartDataEntry] = [ChartDataEntry]()
        for i in 0 ..< months.count {
            yVals1.append(ChartDataEntry(value: dollars1[i], xIndex: i))
        }
        
        // 2 - create a data set with our array
        let set1: LineChartDataSet = LineChartDataSet(yVals: yVals1,label:  nil)
        set1.axisDependency = .Left // Line will correlate with left axis values
        set1.setColor(UIColor.redColor().colorWithAlphaComponent(0.5)) // our line's opacity is 50%
        //set1.setCircleColor(UIColor.redColor()) // our circle will be dark red
        set1.lineWidth = 2.0
        //set1.circleRadius = 0.0 // the radius of the node circle
        set1.fillAlpha = 65 / 255.0
        set1.fillColor = UIColor.redColor()
        set1.highlightColor = UIColor.whiteColor()
        set1.drawCirclesEnabled = false
        
        //3 - create an array to store our LineChartDataSets
        var dataSets : [LineChartDataSet] = [LineChartDataSet]()
        dataSets.append(set1)
        
        //4 - pass our months in for our x-axis label value along with our dataSets
        let data: LineChartData = LineChartData(xVals: months, dataSets: dataSets)
        data.setValueTextColor(UIColor.whiteColor())
//        data.ge
        //5 - finally set our data
        linechart.data = data
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
