//
//  CalculatorViewController.swift
//  SuperCalc
//
//  Created by Starboy on 3/30/2559 BE.
//  Copyright © 2559 Natnicha Thonket. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {


    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    @IBAction func btn_sine(sender: AnyObject) {
    }
    
    @IBAction func btn_cos(sender: AnyObject) {
    }
    
    @IBAction func btn_tan(sender: AnyObject) {
    }
    
    @IBAction func btn_ln(sender: AnyObject) {
    }
    @IBAction func btn_log(sender: AnyObject) {
    }
    @IBAction func btn_x(sender: AnyObject) {
    }
    @IBAction func btn_e(sender: AnyObject) {
    }
    @IBAction func btn_pi(sender: AnyObject) {
    }
    @IBAction func btn_square(sender: AnyObject) {
    }
    @IBAction func btn_openparen(sender: AnyObject) {
    }
    @IBAction func btn_closeparen(sender: AnyObject) {
    }
    @IBAction func btn_root(sender: AnyObject) {
    }
    @IBAction func btn_0(sender: AnyObject){
        numPadPressData("0")
    }
    @IBAction func btn_1(sender: AnyObject) {
    }
    @IBAction func btn_2(sender: AnyObject) {
    }
    @IBAction func btn_3(sender: AnyObject) {
    }
    @IBAction func btn_4(sender: AnyObject) {
    }
    @IBAction func btn_5(sender: AnyObject) {
    }
    @IBAction func btn_6(sender: AnyObject) {
    }
    @IBAction func btn_7(sender: AnyObject) {
    }
    @IBAction func btn_8(sender: AnyObject) {
    }
    @IBAction func btn_9(sender: AnyObject) {
    }
    @IBAction func btn_plus(sender: AnyObject) {
    }
    @IBAction func btn_minus(sender: AnyObject) {
    }
    @IBAction func btn_mul(sender: AnyObject) {
    }
    @IBAction func btn_div(sender: AnyObject) {
    }
    @IBAction func btn_del(sender: AnyObject) {
    }
    @IBAction func btn_equal(sender: AnyObject) {
    }

    @IBAction func btn_dot(sender: AnyObject) {
    }
    
    func numPadPressData(num:String) -> String{
        return num
    }
}
