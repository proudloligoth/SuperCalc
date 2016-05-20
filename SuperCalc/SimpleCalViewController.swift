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
        if str == "-" {
            if userInput.hasPrefix(str) {
                // Strip off the first character (a dash)
                userInput = userInput.substringFromIndex(userInput.startIndex.successor())
            } else {
                userInput = str + userInput
            }
        } else {
            userInput += str
        }
        accumulator = Double((userInput as NSString).doubleValue)
        updateDisplay()
    }
    
    func updateDisplay() {
        // If the value is an integer, don't show a decimal point
        let iAcc = Int(accumulator)
        if accumulator - Double(iAcc) == 0 {
            label.text = "\(iAcc)"
        } else {
            label.text = "\(accumulator)"
        }
    }
    
    func doMath(newOp: String) {
        if userInput != "" && !numStack.isEmpty {
            let stackOp = opStack.last
            if !((stackOp == "+" || stackOp == "-") && (newOp == "*" || newOp == "/")) {
                let oper = ops[opStack.removeLast()]
                accumulator = oper!(numStack.removeLast(), accumulator)
                doEquals()
            }
        }
        opStack.append(newOp)
        numStack.append(accumulator)
        userInput = ""
        updateDisplay()
    }
    
    func doEquals() {
        if userInput == "" {
            return
        }
        if !numStack.isEmpty {
            let oper = ops[opStack.removeLast()]
            accumulator = oper!(numStack.removeLast(), accumulator)
            if !opStack.isEmpty {
                doEquals()
            }
        }
        updateDisplay()
        userInput = ""
    }

    
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
        if hasIndex(stringToSearch: userInput, characterToFind: ".") == false {
            handleInput(".")
        }
    }
    @IBAction func btn_equal(sender: AnyObject) {
         doEquals()
    }
    @IBAction func btn_dev(sender: AnyObject) {
        doMath("/")
    }
    @IBAction func btn_mul(sender: AnyObject) {
        doMath("*")
    }
    @IBAction func btn_minus(sender: AnyObject) {
        doMath("-")
    }
    @IBAction func btn_plus(sender: AnyObject) {
        doMath("+")
    }
    @IBAction func btn_del(sender: AnyObject) {
        userInput = ""
        accumulator = 0
        updateDisplay()
        numStack.removeAll()
        opStack.removeAll()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}