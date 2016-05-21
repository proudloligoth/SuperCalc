//
//  SimpleCalViewController.swift
//  SuperCalc
//
//  Created by beauty on 5/20/2559 BE.
//  Copyright © 2559 Natnicha Thonket. All rights reserved.
//

import UIKit
//// Basic math functions
//func add(a: Double, b: Double) -> Double {
//    let result = a + b
//    return result
//}
//func sub(a: Double, b: Double) -> Double {
//    let result = a - b
//    return result
//}
//func mul(a: Double, b: Double) -> Double {
//    let result = a * b
//    return result
//}
//func div(a: Double, b: Double) -> Double {
//    let result = a / b
//    return result
//}
//
//typealias Binop = (Double, Double) -> Double
//let ops: [String: Binop] = [ "+" : add, "-" : sub, "*" : mul, "÷" : div ]

class SimpleCalViewController: UIViewController {
    
    var accumulator: Double = 0.0 // Store the calculated value here
    var userInput = "" // User-entered digits
    var currentInput = ""
    var lastOp = ""
    var isNeg = false
    var isNotinStack = false
    
    var numStack: [Double] = [] // Number stack
    var opStack: [String] = [] // Operator stack
    
    var calNumStack: [Double] = []
    var calOpStack: [String] = []
    
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
        if str == "+" || str == "-" || str == "×" || str == "÷" {
            if currentInput == "+" || currentInput == "-" || currentInput == "×" || currentInput == "÷" {
                // clear last operation
                userInput = String(userInput.characters.dropLast())
                opStack.removeLast()
            } else if userInput == "" {
                isNeg = true
            } else if Double(currentInput) != nil {
                // add number
                numStack.append(Double(currentInput)!)
            } else {
                print("unexpected case")
            }
            lastOp = str
            currentInput = str
            opStack.append(str)
            isNotinStack = false
        } else {
            if currentInput == "+" || currentInput == "-" || currentInput == "×" || currentInput == "÷" {
                currentInput = ""
            }
            currentInput += str
            isNotinStack = true
        }
        userInput += str
        textlabel.text = userInput
    }

    func doCalc() -> Double {
        print("\n do calc")
        print(calNumStack)
        print(calOpStack)
        
        var op = 0
        var ans = calNumStack[calNumStack.count-1]
        for num in 2..<calNumStack.count {
            let opRev = calOpStack.count - 1
            let numRev = calNumStack.count - 2
            print("op = \(calOpStack[opRev]), \(opRev), \(numRev)")
            if calOpStack[opRev] == "+" {
                ans = numStack[numRev] + ans
                calNumStack.removeLast()
                calOpStack.removeLast()
                calNumStack.append(ans)
            } else if calOpStack[opRev] == "-" {
                ans = numStack[numRev] - ans
                calNumStack.removeLast()
                calOpStack.removeLast()
                calNumStack.append(ans)
            } else if calOpStack[opRev] == "×" {
                ans = numStack[numRev] * ans
                calNumStack.removeLast()
                calOpStack.removeLast()
                calNumStack.append(ans)
            } else if calOpStack[opRev] == "÷" {
                ans = numStack[numRev] / ans
                calNumStack.removeLast()
                calOpStack.removeLast()
                calNumStack.append(ans)
            } else {
                print("no operation \(opStack[opRev])")
            }
            op += 1
            print("ans = \(ans)")
        }
        return ans
    }
    
    func displayAnswer() {
        print("\n display answer")
        print(userInput)
        print(numStack)
        print(opStack)
        if(numStack.count <= opStack.count) {
            let diff = opStack.count - numStack.count
            // put 0 at first until n nidex, n = diff(opStack,numStack)
            for i in 0...diff {
                numStack.insert(Double(0), atIndex: i)
            }
            print(numStack)
        }
        
        // do calculate
        var ans = 0.0
        calNumStack.append(numStack[0])
        var isRightPre = false
        var op = 0
        
        for num in 1..<numStack.count {
            print(op)
            print("num loop : \(num) -> \(opStack[op])")
            if opStack[op] == "+" {
                if isRightPre {
                    ans = doCalc()
                    calNumStack.removeLast()
                    if ans >= 0 {
                        calNumStack.append(ans)
                    } else {
                        calNumStack.append(0)
                        calNumStack.append(abs(ans))
                        calOpStack.append("-")
                    }
                    isRightPre = false
                }
                calOpStack.append(opStack[op])
                calNumStack.append(numStack[num])
            } else if opStack[op] == "-" {
                if isRightPre {
                    ans = doCalc()
                    calNumStack.removeLast()
                    if ans >= 0 {
                        calNumStack.append(ans)
                    } else {
                        calNumStack.append(0)
                        calNumStack.append(abs(ans))
                        calOpStack.append("-")
                    }
                    isRightPre = false
                }
                calOpStack.append(opStack[op])
                calNumStack.append(numStack[num])
            } else if opStack[op] == "×" {
                isRightPre = true
                calOpStack.append(opStack[op])
                calNumStack.append(numStack[num])
            } else if opStack[op] == "÷" {
                isRightPre = true
                calOpStack.append(opStack[op])
                calNumStack.append(numStack[num])
            } else {
                print("no operation \(opStack[op])")
            }
            op += 1
        }

        print("\n do normal calc")
        print(calNumStack)
        print(calOpStack)
        op = 0
        ans = calNumStack[0]
        for num in 1..<calNumStack.count {
            if calOpStack[op] == "+" {
                ans = ans + calNumStack[num]
            } else if calOpStack[op] == "-" {
                ans = ans - calNumStack[num]
            } else if calOpStack[op] == "×" {
                ans = ans * calNumStack[num]
            } else if calOpStack[op] == "÷" {
                ans = Double(ans) / calNumStack[num]
            } else {
                print("no operation \(calOpStack[op])")
            }
            op += 1
            print("ans = \(ans)")
        }
        
        calNumStack.removeAll()
        calOpStack.removeAll()
        
        // display output
        let iAcc = Int(ans)
        if ans - Double(iAcc) == 0 {
            resultlabel.text = String(iAcc)
        } else {
            resultlabel.text = "\(ans)"
        }
    }
    
    func doEquals() {
        if isNotinStack {
            numStack.append(Double(currentInput)!)
            currentInput = "="
            isNotinStack = false
        }
        if currentInput == "+" || currentInput == "-" || currentInput == "×" || currentInput == "÷" {
            userInput = String(userInput.characters.dropLast())
            currentInput = "="
            opStack.removeLast()
            textlabel.text = userInput
        }
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
        handleInput("÷")
    }
    @IBAction func btn_mul(sender: AnyObject) {
        handleInput("×")
    }
    @IBAction func btn_minus(sender: AnyObject) {
        handleInput("-")
    }
    @IBAction func btn_plus(sender: AnyObject) {
        handleInput("+")
    }
    @IBAction func btn_del(sender: AnyObject) {
        userInput = ""
        currentInput = ""
        numStack.removeAll()
        opStack.removeAll()
        calNumStack.removeAll()
        calOpStack.removeAll()
        textlabel.text = ""
        resultlabel.text = nil
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