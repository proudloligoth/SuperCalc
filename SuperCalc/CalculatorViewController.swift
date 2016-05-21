//
//  CalculatorViewController.swift
//  SuperCalc
//
//  Created by Starboy on 3/30/2559 BE.
//  Copyright © 2559 Natnicha Thonket. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    
    var accumulator: Double = 0.0 // Store the calculated value here
    var userInput = "" // User-entered digits
    var lastOp = ""
    
    var numStack: [Double] = [] // Number stack
    var opStack: [String] = [] // Operator stack
    
    var postfixString = " "
    var  oper = ""
    
    // Looks for a single character in a string.
    func hasIndex(stringToSearch str: String, characterToFind chr: Character) -> Bool {
        for c in str.characters {
            if c == chr {
                return true
            }
        }
        return false
    }
    
    func handleInput(str: String) {
        print("new input \(userInput)")
        ViewController.getnum(str)
        if(str == "+" || str == "-" || str == "*" || str == "/") {
            lastOp = str
        }
        //        if str == "-" {
        //            if userInput.hasPrefix(str) {
        //                // Strip off the first character (a dash)
        //                userInput = userInput.substringFromIndex(userInput.startIndex.successor())
        //            } else {
        //                userInput = str + userInput
        //            }
        //        } else {
        //            userInput += str
        //        }
        userInput += str
        
        textlabel.text = userInput
    }
    
    
    func displayAnswer() {
        // If the value is an integer, don't show a decimal point
        print(userInput)
        if userInput[userInput.endIndex.predecessor()] == lastOp[lastOp.endIndex.predecessor()] {
            userInput = String(userInput.characters.dropLast())
        }
        let exp: NSExpression = NSExpression(format: userInput)
        var result: Double = exp.expressionValueWithObject(nil, context: nil) as! Double
        print(result)
        var iAcc = Int(result)
        if result - Double(iAcc) == 0 {
            textlabel.text = String(iAcc)
        } else {
            textlabel.text = "\(result)"
        }
        result = 0
        iAcc = 0
    }
    
    func doEquals() {
        print("ans of \(userInput)")
        if userInput == "" {
            return
        }
        displayAnswer()
    }
    
//    func InToPost(infixString: String){
//        
//        // infixString += " "
//        for c in infixString.characters{
//            var chValue = infixString.
//        }
//    }


    
    @IBOutlet weak var textlabel: UILabel!
    
    
   

   
    
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
        handleInput("0")
    }
    @IBAction func btn_1(sender: AnyObject) {
        handleInput("1")
    }
    @IBAction func btn_2(sender: AnyObject) {
        handleInput("2")
    }
    @IBAction func btn_3(sender: AnyObject) {
        handleInput("3")
    }
    @IBAction func btn_4(sender: AnyObject) {
        handleInput("4")
    }
    @IBAction func btn_5(sender: AnyObject) {
        handleInput("5")
    }
    @IBAction func btn_6(sender: AnyObject) {
        handleInput("6")
    }
    @IBAction func btn_7(sender: AnyObject) {
        handleInput("7")
    }
    @IBAction func btn_8(sender: AnyObject) {
        handleInput("8")
    }
    @IBAction func btn_9(sender: AnyObject) {
        handleInput("9")
    }
    @IBAction func btn_plus(sender: AnyObject) {
        handleInput("+")
    }
    @IBAction func btn_minus(sender: AnyObject) {
        handleInput("-")
    }
    @IBAction func btn_mul(sender: AnyObject) {
        handleInput("x")
    }
    @IBAction func btn_div(sender: AnyObject) {
        handleInput("/")
        numPadPressData("/")
    }
    @IBAction func btn_del(sender: AnyObject) {
        textlabel.text = ""
        
        
    }
    @IBAction func btn_equal(sender: AnyObject) {
        doEquals()
    }

    @IBAction func btn_dot(sender: AnyObject) {
        var allNum = userInput.componentsSeparatedByString(lastOp)
        let latestNum = allNum[allNum.count-1]
        if hasIndex(stringToSearch: latestNum, characterToFind: ".") == false {
            handleInput(".")
        }
    }
    
    func numPadPressData(num:String) -> String{
        return num
    }
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        var destination: ViewController = segue.destinationViewController as ViewController
//       
//        if let vc = destination as? ViewController {
//            destination?.labelcal = textlabel.text
//        }
//        let DestViewController : ViewController = segue.destinationViewController as! ViewController
//        DestViewController.labelcal = textlabel.text!
//        
//        
//    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}
