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
        
    @IBOutlet weak var textcal: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.size.height - 5
        let textcalheight = textcal.frame.size.height
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as! UIPageViewController
        self.pageViewController.view.frame = CGRectMake(0, textcalheight+statusBarHeight, self.view.frame.size.width, self.view.frame.size.height - textcalheight - statusBarHeight)
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
        
        textcal.layer.shadowColor = UIColor.blueColor().CGColor
        textcal.layer.shadowOpacity = 1
        textcal.layer.shadowOffset = CGSize(width: 0.0, height: 10.0)
        textcal.layer.shadowRadius = 5

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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
