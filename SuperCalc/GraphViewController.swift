//
//  GraphViewController.swift
//  SuperCalc
//
//  Created by Starboy on 3/30/2559 BE.
//  Copyright © 2559 Natnicha Thonket. All rights reserved.
//

import UIKit
import SwiftCharts

class GraphViewController: UIViewController {

    private var chart: Chart? // arc
    private var xbound:(min:Double,max:Double) = (-5,5)
    private var ybound:(min:Double,max:Double) = (-5,5)
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation){
        
        // Reload Data here
        drawgraph((-5,5), yAxisnum: (-5,5), chartPointsData: generateXY((-5,5),ybound: (-5,5)))
        removeChart()
        self.view.setNeedsDisplay()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawgraph((-5,5), yAxisnum: (-5,5), chartPointsData: generateXY((-5,5),ybound: (-5,5)))
        
    }
    
    private func generateXY(xbound:(min:Double,max:Double),ybound:(min:Double,max:Double))->[(Double,Double)]{
        
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenWidth = screenSize.width
        let resolution :Double = abs(xbound.max-xbound.min)/Double(screenWidth)
        var out:[(Double,Double)] = []
        for x:Double in (xbound.min).stride(to: xbound.max, by: resolution){
            let y:Double = sin(2*x)+sin(x)+sin(3*x)
            out.append((x,y))
        }
        return out
    }
    
    
    private func drawgraph(xAxisnum: (Double,Double),yAxisnum: (Double,Double),chartPointsData: [(Double,Double)]){
        let labelSettings = ChartLabelSettings(font: ExamplesDefaults.labelFont)
        
        let chartPoints = chartPointsData.map{ChartPoint(x: ChartAxisValueDouble($0	.0, labelSettings: labelSettings), y: ChartAxisValueDouble($0.1))}
        
        let xValues = (xAxisnum.0).stride(through: xAxisnum.1, by: ((xAxisnum.1-xAxisnum.0)/10)).map {ChartAxisValueFloat(CGFloat($0), labelSettings: labelSettings)}

        let yValues = (yAxisnum.0).stride(through: yAxisnum.1, by: ((yAxisnum.1-yAxisnum.0)/10)).map {ChartAxisValueFloat(CGFloat($0), labelSettings: labelSettings)}
        
        let xModel = ChartAxisModel(axisValues: xValues, axisTitleLabel: ChartAxisLabel(text: "x", settings: labelSettings))
        let yModel = ChartAxisModel(axisValues: yValues, axisTitleLabel: ChartAxisLabel(text: "y", settings: labelSettings.defaultVertical()))
        
        let chartFrame = ExamplesDefaults.chartFrame(self.view.bounds)
        
        let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: ExamplesDefaults.chartSettings, chartFrame: chartFrame, xModel: xModel, yModel: yModel)
        let (xAxis, yAxis, innerFrame) = (coordsSpace.xAxis, coordsSpace.yAxis, coordsSpace.chartInnerFrame)
        
        let lineModel = ChartLineModel(chartPoints: chartPoints, lineColor: UIColor.redColor(), animDuration: 1, animDelay: 0)
        let chartPointsLineLayer = ChartPointsLineLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, lineModels: [lineModel])
        
        
        let trackerLayerSettings = ChartPointsLineTrackerLayerSettings(thumbSize: Env.iPad ? 30 : 20, thumbCornerRadius: Env.iPad ? 16 : 10, thumbBorderWidth: Env.iPad ? 4 : 2, infoViewFont: ExamplesDefaults.fontWithSize(Env.iPad ? 26 : 16), infoViewSize: CGSizeMake(Env.iPad ? 400 : 160, Env.iPad ? 70 : 40), infoViewCornerRadius: Env.iPad ? 30 : 15)
        let chartPointsTrackerLayer = ChartPointsLineTrackerLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, chartPoints: chartPoints, lineColor: UIColor.blackColor(), animDuration: 1, animDelay: 2, settings: trackerLayerSettings)
        
        let settings = ChartGuideLinesDottedLayerSettings(linesColor: UIColor.blackColor(), linesWidth: ExamplesDefaults.guidelinesWidth)
        let guidelinesLayer = ChartGuideLinesDottedLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, settings: settings)
        
        let chart = Chart(
            frame: chartFrame,
            layers: [
                xAxis,
                yAxis,
                guidelinesLayer,
                chartPointsLineLayer,
                chartPointsTrackerLayer
            ]
        )
        chart.view.tag = 100
        self.view.addSubview(chart.view)
        self.chart = chart
    }
    
    private func removeChart(){
        if let viewWithTag = self.view.viewWithTag(100){
            viewWithTag.removeFromSuperview()
        }
    }
    
    
}
