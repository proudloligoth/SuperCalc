//
//  SimpleCalViewController.swift
//  SuperCalc
//
//  Created by beauty on 5/20/2559 BE.
//  Copyright © 2559 Natnicha Thonket. All rights reserved.
//

import UIKit
// Basic math functions
func add(a: Double, b: Double) -> Double {
    let result = a + b
    return result
}
func sub(a: Double, b: Double) -> Double {
    let result = a - b
    return result
}
func mul(a: Double, b: Double) -> Double {
    let result = a * b
    return result
}
func div(a: Double, b: Double) -> Double {
    let result = a / b
    return result
}

typealias Binop = (Double, Double) -> Double
let ops: [String: Binop] = [ "+" : add, "-" : sub, "*" : mul, "/" : div ]

class SimpleCalViewController: UIViewController {
    
    
    var accumulator: Double = 0.0 // Store the calculated value here
    var userInput = "" // User-entered digits
    var lastOp = ""
    
    var numStack: [Double] = [] // Number stack
    var opStack: [String] = [] // Operator stack
    
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
            resultlabel.text = String(iAcc)
        } else {
            resultlabel.text = "\(result)"
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

    
    @IBOutlet weak var textlabel: UITextView!
    @IBOutlet weak var resultlabel: UILabel!
    @IBOutlet weak var label: UILabel!
    
    @IBAction func btn_0(sender: AnyObject) {
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
    @IBAction func btn_dot(sender: AnyObject) {
        var allNum = userInput.componentsSeparatedByString(lastOp)
        let latestNum = allNum[allNum.count-1]
        if hasIndex(stringToSearch: latestNum, characterToFind: ".") == false {
            handleInput(".")
        }
    }
    @IBAction func btn_equal(sender: AnyObject) {
         doEquals()
    }
    @IBAction func btn_dev(sender: AnyObject) {
        handleInput("/")
    }
    @IBAction func btn_mul(sender: AnyObject) {
        handleInput("*")
    }
    @IBAction func btn_minus(sender: AnyObject) {
        handleInput("-")
    }
    @IBAction func btn_plus(sender: AnyObject) {
        handleInput("+")
    }
    @IBAction func btn_del(sender: AnyObject) {
        userInput = ""
        textlabel.text = ""
        resultlabel.text = ""
        print("reset ans \(resultlabel.text)")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}