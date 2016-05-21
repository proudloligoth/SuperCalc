//
//  ViewController.swift
//  SuperCalc
//
//  Created by Starboy on 4/2/2559 BE.
//  Copyright © 2559 Natnicha Thonket. All rights reserved.
//
import UIKit
class ViewController: UIViewController {

    var pageViewController: UIPageViewController!
        
    @IBOutlet public var textcal: UITextView!
    
    var labelcal = String()
    
    
    internal var toPass:String!
    
    override func viewDidLoad() {
        textcal.text = labelcal
        super.viewDidLoad()
        //textcal.text = toPass
        
        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.size.height - 5
        let textcalheight = textcal.frame.size.height
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as! UIPageViewController
        self.pageViewController.view.frame = CGRectMake(0, textcalheight+statusBarHeight, self.view.frame.size.width, self.view.frame.size.height - textcalheight - statusBarHeight)
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
        
        textcal.layer.shadowColor = UIColor.blackColor().CGColor
        textcal.layer.shadowOpacity = 1
        textcal.layer.shadowOffset = CGSize(width: 0.0, height: 10.0)
        textcal.layer.shadowRadius = 10

//        
//        textcal.layer.shadowOpacity = 1
//        textcal.layer.shadowOffset = CGSize(width: 0.0, height: 10.0)
//        textcal.layer.shadowRadius = 5
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "segueTest") {
            let svc = segue.destinationViewController as! ViewController;
            
            svc.toPass = textcal.text
            
        }
    }
    class func getnum(num:String){
        print(num)
        textcal.text
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
