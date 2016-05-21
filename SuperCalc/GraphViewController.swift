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

    @IBOutlet weak var xMin: UITextField!
    @IBOutlet weak var xMax: UITextField!
    @IBOutlet weak var yMin: UITextField!
    @IBOutlet weak var yMax: UITextField!
    
    @IBOutlet weak var boundsetting: UIStackView!
    private var chart: Chart? // arc
    private var xbound:(min:Double,max:Double) = (-5,5)
    private var ybound:(min:Double,max:Double) = (-5,5)
    
    @IBAction func xMinEdited(sender: AnyObject) {
        if let Min = xMin.text where !xMin.text!.isEmpty {
            if let Max = xMax.text where !xMax.text!.isEmpty{
                if(Double(Min) >= Double(Max)!){
                    xMin.textColor = UIColor.redColor()
                }
                else{
                    xMin.textColor = UIColor.blueColor()
                    xMax.textColor = UIColor.blueColor()
            
                    xbound = (Double(Min)!,Double(Max)!)
                    updategraph()
                }
            }
        }
    }
    @IBAction func xMaxEdited(sender: AnyObject) {
        if let Min = xMin.text where !xMin.text!.isEmpty {
            if let Max = xMax.text where !xMax.text!.isEmpty{
                if(Double(Max) <= Double(Min)){
                xMin.textColor = UIColor.redColor()
            }
            else{
                xMin.textColor = UIColor.blueColor()
                xMax.textColor = UIColor.blueColor()
                
                xbound = (Double(Min)!,Double(Max)!)
                updategraph()
            }
        }
        }
    }
    @IBAction func yMinEdited(sender: AnyObject) {
        if let Min = yMin.text where !yMin.text!.isEmpty {
            if let Max = yMax.text where !yMax.text!.isEmpty{
                
                if(Double(Min) >= Double(Max)!){
                    yMin.textColor = UIColor.redColor()
                }
                else{
                    yMin.textColor = UIColor.blueColor()
                    yMax.textColor = UIColor.blueColor()
                    
                    ybound = (Double(Min)!,Double(Max)!)
                    updategraph()
                }
            }
        }
    }
    @IBAction func yMaxEdited(sender: AnyObject) {
        if let Min = yMin.text where !yMin.text!.isEmpty {
            if let Max = yMax.text where !yMax.text!.isEmpty{
                if(Double(Max) <= Double(Min)){
                    yMin.textColor = UIColor.redColor()
                }
                else{
                    yMin.textColor = UIColor.blueColor()
                    yMax.textColor = UIColor.blueColor()
                    
                    ybound = (Double(Min)!,Double(Max)!)
                    updategraph()
                }
            }
        }
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        if(size.height < size.width){
            if(!Env.iPad){
                boundsetting.hidden = true
            }
        }
    }

    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation){
        
        // Reload Data here
        updategraph()
        
        self.view.setNeedsDisplay()
        
    }
    
    private func updategraph(){
        removeChart()
        drawgraph(self.xbound, yAxisnum: self.ybound, chartPointsData: generateXY(self.xbound,ybound:self.ybound))
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        xMin.text = "\(self.xbound.min)"
        xMax.text = "\(xbound.max)"
        yMin.text = "\(ybound.min)"
        yMax.text = "\(ybound.max)"
        
        xMin.textColor = UIColor.blueColor()
        xMax.textColor = UIColor.blueColor()
        yMin.textColor = UIColor.blueColor()
        yMax.textColor = UIColor.blueColor()
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        drawgraph(xbound, yAxisnum: ybound, chartPointsData: generateXY(xbound,ybound:ybound))
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
        
        let xValues = (xAxisnum.0).stride(through: xAxisnum.1, by: ceil((xAxisnum.1-xAxisnum.0)/10)).map {ChartAxisValueFloat(CGFloat($0), labelSettings: labelSettings)}

        let yValues = (yAxisnum.0).stride(through: yAxisnum.1, by: ceil((yAxisnum.1-yAxisnum.0)/10)).map {ChartAxisValueFloat(CGFloat($0), labelSettings: labelSettings)}
        
        let xModel = ChartAxisModel(axisValues: xValues, axisTitleLabel: ChartAxisLabel(text: "x", settings: labelSettings))
        let yModel = ChartAxisModel(axisValues: yValues, axisTitleLabel: ChartAxisLabel(text: "y", settings: labelSettings.defaultVertical()))
        
        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.size.height - 5
        let textcalheight = boundsetting.frame.size.height
        
        let chartFrame = CGRectMake(-7, textcalheight+statusBarHeight-7, self.view.frame.size.width, (self.view.frame.size.height - textcalheight - statusBarHeight+14))
        
        let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: ExamplesDefaults.chartSettings, chartFrame: chartFrame, xModel: xModel, yModel: yModel)
        let (xAxis, yAxis, innerFrame) = (coordsSpace.xAxis, coordsSpace.yAxis, coordsSpace.chartInnerFrame)
        
        let lineModel = ChartLineModel(chartPoints: chartPoints, lineColor: UIColor.redColor(), animDuration: 1, animDelay: 0)
        let chartPointsLineLayer = ChartPointsLineLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, lineModels: [lineModel])
        
        // tracker layer
//        let trackerLayerSettings = ChartPointsLineTrackerLayerSettings(thumbSize: Env.iPad ? 30 : 20, thumbCornerRadius: Env.iPad ? 16 : 10, thumbBorderWidth: Env.iPad ? 4 : 2, infoViewFont: ExamplesDefaults.fontWithSize(Env.iPad ? 26 : 16), infoViewSize: CGSizeMake(Env.iPad ? 400 : 160, Env.iPad ? 70 : 40), infoViewCornerRadius: Env.iPad ? 30 : 15)
//        let chartPointsTrackerLayer = ChartPointsLineTrackerLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, chartPoints: chartPoints, lineColor: UIColor.blackColor(), animDuration: 1, animDelay: 2, settings: trackerLayerSettings)
        
        let showCoordsTextViewsGenerator = {(chartPointModel: ChartPointLayerModel, layer: ChartPointsLayer, chart: Chart) -> UIView? in
            let (chartPoint, screenLoc) = (chartPointModel.chartPoint, chartPointModel.screenLoc)
            let w: CGFloat = 70
            let h: CGFloat = 30
            
            let text = "(\(chartPoint.x.text), \(chartPoint.y.text))"
            let font = ExamplesDefaults.labelFont
            let textSize = ChartUtils.textSize(text, font: font)
            let x = min(screenLoc.x + 5, chart.bounds.width - textSize.width - 5)
            let view = UIView(frame: CGRectMake(x, screenLoc.y - h, w, h))
            let label = UILabel(frame: view.bounds)
            label.text = "(\(chartPoint.x.text), \(chartPoint.y.text))"
            label.font = ExamplesDefaults.labelFont
            view.addSubview(label)
            view.alpha = 0
            UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                view.alpha = 1
                }, completion: nil)
            return view
        }
        
        let showCoordsLinesLayer = ChartShowCoordsLinesLayer<ChartPoint>(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, chartPoints: chartPoints)
        let showCoordsTextLayer = ChartPointsSingleViewLayer<ChartPoint, UIView>(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, chartPoints: chartPoints, viewGenerator: showCoordsTextViewsGenerator)
        
        let touchViewsGenerator = {(chartPointModel: ChartPointLayerModel, layer: ChartPointsLayer, chart: Chart) -> UIView? in
            let (chartPoint, screenLoc) = (chartPointModel.chartPoint, chartPointModel.screenLoc)
            let s: CGFloat = 30
            let view = HandlingView(frame: CGRectMake(screenLoc.x - s/2, screenLoc.y - s/2, s, s))
            view.touchHandler = {
                showCoordsLinesLayer.showChartPointLines(chartPoint, chart: chart)
                showCoordsTextLayer.showView(chartPoint: chartPoint, chart: chart)
            }
            return view
        }
        let touchLayer = ChartPointsViewsLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, chartPoints: chartPoints, viewGenerator: touchViewsGenerator)
        
        
        let settings = ChartGuideLinesDottedLayerSettings(linesColor: UIColor.blackColor(), linesWidth: ExamplesDefaults.guidelinesWidth)
        let guidelinesLayer = ChartGuideLinesDottedLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, settings: settings)
        
        let chart = Chart(
            frame: chartFrame,
            layers: [
                xAxis,
                yAxis,
                guidelinesLayer,
                showCoordsLinesLayer,
                chartPointsLineLayer,
                showCoordsTextLayer,
                touchLayer,
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
