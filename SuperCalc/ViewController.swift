//
//  ViewController.swift
//  SuperCalc
//
//  Created by Starboy on 4/2/2559 BE.
//  Copyright © 2559 Natnicha Thonket. All rights reserved.
//
import UIKit
class ViewController: UIViewController{

    var pageViewController: UIPageViewController!
        
    @IBOutlet var textcal: UITextView!
    
    var labelcal = String()
    
    internal var toPass:String!
    
    func writeValueBack(value: String) {
        // Or any other function you need to transport data
        textcal.text = value
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        textcal.text = labelcal
        //textcal.text = toPass
        
        loadPageSwitch()
        
        textcal.layer.shadowColor = UIColor.blackColor().CGColor
        textcal.layer.shadowOpacity = 1
        textcal.layer.shadowOffset = CGSize(width: 0.0, height: 10.0)
        textcal.layer.shadowRadius = 10

//        
//        textcal.layer.shadowOpacity = 1
//        textcal.layer.shadowOffset = CGSize(width: 0.0, height: 10.0)
//        textcal.layer.shadowRadius = 5
        // Do any additional setup after loading the view.
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector:"myMethod:", name: "passDataInView", object: nil)
    }
    func myMethod(notification: NSNotification){
        
        
        let x = notification.userInfo!
        print(x["key"])
        
    }
    
    private func removePageSwitch(){
        if let viewWithTag = self.view.viewWithTag(10){
            viewWithTag.removeFromSuperview()
        }
    }
    
//    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation){
//        
//        // Reload Data here
//        removePageSwitch()
//        loadPageSwitch()
//        self.view.setNeedsDisplay()
//        
//    }
    
    private func loadPageSwitch(){
        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.size.height - 5
        let textcalheight = textcal.frame.size.height
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as! UIPageViewController
        self.pageViewController.view.frame = CGRectMake(0, textcalheight+statusBarHeight, self.view.frame.size.width, self.view.frame.size.height - textcalheight - statusBarHeight)
        self.addChildViewController(self.pageViewController)
        self.pageViewController.view.tag = 10
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
    }
    
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    class func getnum(num:String){
        print(num)
        
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
