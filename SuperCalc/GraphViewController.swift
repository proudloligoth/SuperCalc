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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let chartPointsData:[(Double,Double)] = [(-2, -2), (-1.1, -100.1), (4.5, 4),(4.3,9), (7, 1), (8, 100), (12, 3)]
        drawgraph((-10,10), yAxisnum: (-10,10), chartPointsData: chartPointsData)
        
        
    }
    
    private func generateXY()->[(Double,Double)]{
        var out:[(Double,Double)] = []
        for var x:Double = -5;x<=5;x+=0.01{
            let y = 10*sin(x)
            out.append((x,y))
        }
        return out
    }
    
    
    private func drawgraph(xAxisnum: (Double,Double),yAxisnum: (Double,Double),chartPointsData: [(Double,Double)]){
        let labelSettings = ChartLabelSettings(font: ExamplesDefaults.labelFont)
        
        let chartPoints = chartPointsData.map{ChartPoint(x: ChartAxisValueDouble($0	.0, labelSettings: labelSettings), y: ChartAxisValueDouble($0.1))}
        
        let xValues = ChartAxisValuesGenerator.generateXAxisValuesWithChartPoints(chartPoints, minSegmentCount: -20, maxSegmentCount:xAxisnum.1, multiple: ceil(xAxisnum.1/10), axisValueGenerator: {ChartAxisValueDouble($0, labelSettings: labelSettings)}, addPaddingSegmentIfEdge: true)
        
        let yValues = ChartAxisValuesGenerator.generateYAxisValuesWithChartPoints(chartPoints, minSegmentCount: yAxisnum.0-10, maxSegmentCount: yAxisnum.1+10, multiple: ceil(yAxisnum.1/15), axisValueGenerator: {ChartAxisValueDouble($0, labelSettings: labelSettings)}, addPaddingSegmentIfEdge: true)
        
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
        
        self.view.addSubview(chart.view)
        self.chart = chart
    }
    
    
}
