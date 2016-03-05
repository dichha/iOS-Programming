//
//  ViewController.swift
//  Calculator
//
//  Created by raidi01 on 2/9/16.
//  Copyright © 2016 Luther College. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!

    @IBOutlet weak var history: UILabel!
    
    var userIsInTheMiddleOfTypingNumber: Bool = false
  
    
    var brain = CalculatorBrain()

   
    @IBAction func appendDigit(sender: UIButton) {
       
        let digit = sender.currentTitle!
       
        history.text = brain.description
        
        
        if userIsInTheMiddleOfTypingNumber{
            display.text = display.text! + digit
            
           
        }else{
            display.text = digit
            

            userIsInTheMiddleOfTypingNumber = true
        }
    }
    
    
    @IBAction func appendDecimal(sender: UIButton) {
        let decimal = sender.currentTitle!
        
        history.text = history.text!+"."
        if userIsInTheMiddleOfTypingNumber{
            display.text = display.text! + decimal
        }else{
            display.text = decimal
            
            userIsInTheMiddleOfTypingNumber = true
        }
        
    }
    
  
 
    @IBAction func backspace() {
        let enteredString = display.text!
      
        
        if (enteredString.characters.count > 0){
            let leftString = String(enteredString.characters.dropLast())
            
            
            //print(leftString)
            display.text = leftString
            let goodInput = history.text!.componentsSeparatedByString(",")
            //removing the laststring of input
            history.text = ""
            for i in 0..<(goodInput.count - 1){
                let hisElement = goodInput[i]
                history.text = history.text! + hisElement + ","
            }
            
            history.text = history.text! + display.text!
          

        }
        
    }
    

    
  /*  @IBAction func getVariable(sender: UIButton) {
        if userIsInTheMiddleOfTypingNumber{
            enter()
        }
        let variable = sender.currentTitle!
        if let result = brain.pushOperand(variable){
            displayValue = result
        }else{
            displayValue = nil
        }
    }
    
  
    
    
    
    
    
    
    
    
    @IBAction func setVariable(sender: UIButton) {
        
        let variable = sender.currentTitle!
        if displayValue != nil{
            brain.variableValues["\(variable)"] = displayValue
            if let result = brain.evaluate(){
                displayValue = result
                
            }else{
                displayValue = nil
            }
        }
        userIsInTheMiddleOfTypingNumber = false
    }
    
    */
    
    
    
    
    /*@IBAction func pushVariable(sender: UIButton) {
    
    }
    
    
    @IBAction func setVariable(sender: UIButton) {
       
    
    }*/
    
    
    
    
    @IBAction func clearStack(sender: UIButton) {
        display.text = "0"
        brain.clearOpStack()
        history.text = "0"
        
        
    }
    
   /*@IBAction func appendPi() {
        let pi = String(M_PI)
    
        //history.text = history.text!+"∏"
        history.text = brain.description
        
        if userIsInTheMiddleOfTypingNumber{
            display.text = display.text! + pi
           
        }else{
            display.text = pi
            userIsInTheMiddleOfTypingNumber = true
        }
    }*/
    
    @IBAction func operate(sender: UIButton) {
        
        //automatic entry
        if userIsInTheMiddleOfTypingNumber{
            enter()
        }
        if let operation = sender.currentTitle{
            if let result = brain.performOperation(operation){
                //let symbol = sender.currentTitle!
                //history.text = history.text! + brain.description
                history.text = brain.description + " ="
                displayValue = result
            }else{
                displayValue = nil
            }
        }
        
        
        /*if let operation = sender.currentTitle{
            switch operation{
                case "×":
                    history.text = history.text!+"×"
                    performOperation{$0 * $1}
                /* performOperation({(op1: Double, op2: Double) -> Double
                    in return op1*op2
                    }*/
            
                case "÷":
                    history.text = history.text!+"÷"
                    
                    performOperation{ $1 / $0 }
                case "+":
                    history.text = history.text!+"+"
                    performOperation{ $0 + $1 }
                case "−":
                    
                    history.text = history.text!+"−"
                    performOperation{ $1 - $0 }
                case "√":
                    history.text = history.text!+"√"
                    performOperation{ sqrt($0) }
                case "sin":
                    history.text = history.text!+"sin"
                    performOperation{ sin($0) }
                case "cos":
                    history.text = history.text!+"cos"
                    performOperation{ cos($0) }
                default: break
            }
        }*/
        
    }
    
   /*@nonobjc func performOperation(operation: (Double,Double) -> Double){
        if operandStack.count >= 2{
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            
            //autimatic entry
            enter()
        }
    }
    
    @nonobjc func performOperation(operation: Double -> Double){
        if operandStack.count >= 1{
            displayValue = operation(operandStack.removeLast())
            
            //autimatic entry
            enter()
        }
    }*/
    
   

    

    
    
    //var operandStack: Array<Double> = Array<Double>()
    //var operandStack = Array<Double>()
    //var historyStack = Array<String>()
    

    @IBAction func enter() {
        userIsInTheMiddleOfTypingNumber = false
        if let result = brain.pushOperand(displayValue!){
            displayValue = result
            //history.text = history.text! + ","
            history.text = brain.description
        }else{
            displayValue = nil
        }
        
        /*operandStack.append(displayValue)
        history.text = history.text! + ","
        print("operandStack = \(operandStack)")*/
        
    }
    
    var displayValue: Double?{
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
        
            display.text = "\(newValue!)"
            
            userIsInTheMiddleOfTypingNumber = false
        }
    }
  
}

