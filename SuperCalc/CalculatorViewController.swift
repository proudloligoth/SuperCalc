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
    var currentInput = ""
    var lastOp = ""
    var isNeg = false
    var isFunc = false
    var isNotinStack = false
    
    var numStack: [Double] = [] // Number stack
    var opStack: [String] = [] // Operator stack
    var parenCount = 0
    
    private let defaultHistoryText = " "
    var postfixString = " "
    var oper = ""
    
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
        let dictionary = ["key":str]
        NSNotificationCenter.defaultCenter().postNotificationName("passDataInView", object: nil, userInfo: dictionary)
        if str == "+" || str == "-" || str == "×" || str == "÷" || str == "^" {
            // change operator
            if currentInput == "+" || currentInput == "-" || currentInput == "×" || currentInput == "÷" || currentInput == "^" {
                // clear last operation
                userInput = String(userInput.characters.dropLast())
                opStack.removeLast()
            } else if userInput == "" {
                isNeg = true
            }  else if Double(currentInput) != nil {
                // add number
                numStack.append(Double(currentInput)!)
            } else {
                print("unexpected case")
            }
            lastOp = str                    // latest operator
            currentInput = str              // current = operator
            opStack.append(str)             // add operator to stack
            isNotinStack = false            // all inputs are in stack
            userInput += str                // update text
            textlabel.text = userInput      // update label
        } else if str == "sin(" || str == "cos(" || str == "tan(" || str == "ln(" || str == "log₁₀(" || str == "√(" {
            // must follow operator
            if currentInput == "+" || currentInput == "-" || currentInput == "×" || currentInput == "÷" || currentInput == "^" || currentInput == "" {
                currentInput = str
                opStack.append(str)
                isNotinStack = false
                parenCount += 1
                userInput += str
                textlabel.text = userInput
            }
        } else if str == "e" {
            print("press e")
            // can follow any, but number
            if Double(currentInput) == nil {
                currentInput = ""       // e value
//                numStack.append(2.71828)
                numStack.append(M_E)
                isNotinStack = false
                userInput += str                // update text
                textlabel.text = userInput      // update label
            }
        } else if str == "π" {
            print("press pi")
            // can follow any, but number
            if Double(currentInput) == nil {
                currentInput = ""       // pi value
//                numStack.append(3.14159)
                numStack.append(M_PI)
                isNotinStack = false
                userInput += str                // update text
                textlabel.text = userInput      // update label
            }
        } else if str == "x" {
            isFunc = true
        } else if str == "(" {
            if currentInput == "+" || currentInput == "-" || currentInput == "×" || currentInput == "÷" || currentInput == "^" || currentInput == "" {
                currentInput = str
                opStack.append(str)
                isNotinStack = false
                userInput += str                // update text
                textlabel.text = userInput      // update label
                parenCount += 1
            }
        } else if str == ")" {
            print(currentInput)
            if parenCount > 0 {
                if Double(currentInput) != nil {
                    numStack.append(Double(currentInput)!)
                }
                currentInput = str
                opStack.append(str)
                isNotinStack = false
                userInput += str                // update text
                textlabel.text = userInput      // update label
                parenCount -= 1
            }
        } else {
            // case number
            // follow operator, reset
            if Double(currentInput) == nil && currentInput != ")" {
                currentInput = ""
            }
            if currentInput == ")" {
                // do nothing
            } else {
                currentInput += str
                isNotinStack = true
                userInput += str                // update text
                textlabel.text = userInput      // update label
            }

        }
    }
    
    func doCalc() -> Double {
        print("\n do calc")
        print(calNumStack)
        print(calOpStack)
        
        var op = 0
        var ans = calNumStack[calNumStack.count-1]
        calNumStack.removeLast()
        for num in 0..<calNumStack.count {
            let opRev = calOpStack.count - 1
            let numRev = calNumStack.count - 1
            print("op = \(calOpStack[opRev]), \(opRev), \(numRev)")
            if calOpStack[opRev] == "+" {
                ans = numStack[numRev] + ans
                calNumStack.removeLast()
                calOpStack.removeLast()
            } else if calOpStack[opRev] == "-" {
                ans = numStack[numRev] - ans
                calNumStack.removeLast()
                calOpStack.removeLast()
            } else if calOpStack[opRev] == "×" {
                ans = numStack[numRev] * ans
                calNumStack.removeLast()
                calOpStack.removeLast()
            } else if calOpStack[opRev] == "÷" {
                ans = numStack[numRev] / ans
                calNumStack.removeLast()
                calOpStack.removeLast()
            } else if calOpStack[opRev] == "sin(" {
                ans = sin(ans)
                calOpStack.removeLast()
                break
            } else if calOpStack[opRev] == "cos(" {
                ans = cos(ans)
                calOpStack.removeLast()
                break
            } else if calOpStack[opRev] == "(" {
                calOpStack.removeLast()
                break
            } else {
                print("no operation \(opStack[opRev])")
            }
            op += 1
            print("ans = \(ans)")
        }
        if calOpStack.count == 1 {
            if calOpStack[0] == "sin(" {
                ans = sin(ans)
                calOpStack.removeLast()
            } else if calOpStack[0] == "cos(" {
                ans = cos(ans)
                calOpStack.removeLast()
            } else if calOpStack[0] == "tan(" {
                ans = tan(ans)
                calOpStack.removeLast()
            } else if calOpStack[0] == "ln(" {
                ans = log(ans)
                calOpStack.removeLast()
            } else if calOpStack[0] == "log₁₀(" {
                ans = log10(ans)
                calOpStack.removeLast()
            } else if calOpStack[0] == "√(" {
                ans = Double(sqrtf(Float(ans)))
                calOpStack.removeLast()
            }
        }
        print("ans = \(ans)")
        return ans
    }
    
    func displayAnswer() {
        print(userInput)
        print(numStack)
        print(opStack)
        var opStackNoParen = opStack.filter{$0 != "("}
        opStackNoParen = opStackNoParen.filter{$0 != "sin("}
        opStackNoParen = opStackNoParen.filter{$0 != "cos("}
        opStackNoParen = opStackNoParen.filter{$0 != "tan("}
        opStackNoParen = opStackNoParen.filter{$0 != "ln("}
        opStackNoParen = opStackNoParen.filter{$0 != "log₁₀(" }
        opStackNoParen = opStackNoParen.filter{$0 != "√("}
        opStackNoParen = opStackNoParen.filter{$0 != ")"}
        print(opStackNoParen)
        if(numStack.count <= opStackNoParen.count) {
            let diff = opStackNoParen.count - numStack.count
            // put 0 at first until n nidex, n = diff(opStack,numStack)
            for i in 0...diff {
                numStack.insert(Double(0), atIndex: i)
            }
            print(numStack)
        }
            
        // do calculate
        var ans = 0.0
        calNumStack.append(numStack[0])
        var isRightPre = ""
        var isParen = ""
        var op = 0
        var num = 0
        
        while num < numStack.count || op < opStack.count {
            print("num loop : \(num) -> \(opStack[op])")
            if opStack[op] == "+" {
                if isRightPre != "2Left" && isRightPre != "" {
                    ans = doCalc()
                    if ans >= 0 {
                        calNumStack.append(ans)
                    } else {
                        calNumStack.append(0)
                        calNumStack.append(abs(ans))
                        calOpStack.append("-")
                    }
                    isRightPre = "2Left"
                }
                calOpStack.append(opStack[op])
                calNumStack.append(numStack[num])
            } else if opStack[op] == "-" {
                if isRightPre != "2Left" && isRightPre != "" {
                    ans = doCalc()
                    if ans >= 0 {
                        calNumStack.append(ans)
                    } else {
                        calNumStack.append(0)
                        calNumStack.append(abs(ans))
                        calOpStack.append("-")
                    }
                    isRightPre = "2Left"
                }
                calOpStack.append(opStack[op])
                calNumStack.append(numStack[num])
            } else if opStack[op] == "×" {
//                if isRightPre != "3Left" && isRightPre != ""{
//                    ans = doCalc()
//                }
                isRightPre = "3Left"
                calOpStack.append(opStack[op])
                calNumStack.append(numStack[num])
            } else if opStack[op] == "÷" {
                isRightPre = "3Left"
                calOpStack.append(opStack[op])
                calNumStack.append(numStack[num])
            } else if opStack[op] == "^" {
                isRightPre = "4Right"
                calOpStack.append(opStack[op])
                calNumStack.append(numStack[num])
            } else if opStack[op] == "(" {
                isParen = "open"
                calOpStack.append(opStack[op])
//                calNumStack.append(numStack[num])
                num -= 1
            } else if opStack[op] == "sin(" {
                isParen = "open"
                calOpStack.append(opStack[op])
                num -= 1
            } else if opStack[op] == "cos(" {
                isParen = "open"
                calOpStack.append(opStack[op])
                num -= 1
            } else if opStack[op] == "tan(" {
                isParen = "open"
                calOpStack.append(opStack[op])
                num -= 1
            } else if opStack[op] == "ln(" {
                isParen = "open"
                calOpStack.append(opStack[op])
                num -= 1
            } else if opStack[op] == "log₁₀(" {
                isParen = "open"
                calOpStack.append(opStack[op])
                num -= 1
            } else if opStack[op] == "√(" {
                isParen = "open"
                calOpStack.append(opStack[op])
                num -= 1
            } else if opStack[op] == ")" {
//                if isParen == "open" {
                ans = doCalc()
                if ans >= 0 {
                    calNumStack.append(ans)
                } else {
                    calNumStack.append(0)
                    calNumStack.append(abs(ans))
                    calOpStack.append("-")
                }
//                }
            } else {
                print("no operation \(opStack[op])")
            }
            op += 1
            num += 1
        }
        
        
        print("\n do normal calc")
        print(calNumStack)
        print(calOpStack)
        if calNumStack.isEmpty {
            // do nothing
        } else if isRightPre == "3Right" {
            ans = doCalc()
            calNumStack.append(ans)
        } else {
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
                } else if calOpStack[op] == "sin(" {
                    ans = sin(ans)
                } else if calOpStack[op] == "cos(" {
                    ans = cos(ans)
                } else if calOpStack[op] == "tan(" {
                    ans = tan(ans)
                } else {
                    print("no operation \(calOpStack[op])")
                }
                op += 1
                print("ans = \(ans)")
            }
        }
        
        calNumStack.removeAll()
        calOpStack.removeAll()
        
        // display output
        let iAcc = Int(ans)
        if ans - Double(iAcc) == 0 {
//            resultlabel.text = String(iAcc)
        } else {
//            resultlabel.text = "\(ans)"
        }
    }

    
    func doEquals() {
        print(userInput)
        if isFunc {
            // change to graph page
        } else {
            if isNotinStack {
                numStack.append(Double(currentInput)!)
                currentInput = "="
                isNotinStack = false
            }
            print("parenCount : \(parenCount)")
            for i in 0..<parenCount {
                userInput += ")"
                opStack.append(")")
                textlabel.text = userInput
            }
            while Double(String(userInput[userInput.endIndex.predecessor()])) == nil && userInput[userInput.endIndex.predecessor()] != ")"{
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
        handleInput("sin(")
    }
    @IBAction func btn_cos(sender: AnyObject) {
        handleInput("cos(")
    }
    @IBAction func btn_tan(sender: AnyObject) {
        handleInput("tan(")
    }
    @IBAction func btn_ln(sender: AnyObject) {
        handleInput("ln(")
    }
    @IBAction func btn_log(sender: AnyObject) {
        handleInput("log₁₀(")
    }
    @IBAction func btn_x(sender: AnyObject) {
        handleInput("x")
    }
    @IBAction func btn_e(sender: AnyObject) {
        handleInput("e")
    }
    @IBAction func btn_pi(sender: AnyObject) {
        handleInput("π")
    }
    @IBAction func btn_square(sender: AnyObject) {
         handleInput("^")
    }
    @IBAction func btn_openparen(sender: AnyObject) {
        handleInput("(")
    }
    @IBAction func btn_closeparen(sender: AnyObject) {
        handleInput(")")
    }
    @IBAction func btn_root(sender: AnyObject) {
        handleInput("√(")
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
        handleInput("×")
    }
    @IBAction func btn_div(sender: AnyObject) {
        handleInput("÷")
//        numPadPressData("/")
    }
    @IBAction func btn_del(sender: AnyObject) {
        userInput = ""
        currentInput = ""
        numStack.removeAll()
        opStack.removeAll()
        calNumStack.removeAll()
        calOpStack.removeAll()
        textlabel.text = nil
//        resultlabel.text = nil
//        print("reset ans \(resultlabel.text)")
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
//        var destination: ViewController = segue.destinationViewController as! ViewController{
//       
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
