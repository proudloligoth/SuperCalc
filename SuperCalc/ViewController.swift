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
    
    @IBOutlet weak var scroll: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as! UIPageViewController
        self.pageViewController.view.frame = CGRectMake(0, scroll.frame.height+20, self.view.frame.width, self.view.frame.size.height - scroll.frame.height-20)
        
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
        
        scroll.layer.shadowOpacity = 1
        scroll.layer.shadowOffset = CGSize(width: 0.0, height: 10.0)
        scroll.layer.shadowRadius = 5
        // Do any additional setup after loading the view.
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
