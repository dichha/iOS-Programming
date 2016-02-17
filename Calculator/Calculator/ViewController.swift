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
    var userIsInTheMiddleOfTypingNumber: Bool = false
    
    var brain = CalculatorBrain()

   
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingNumber{
            display.text = display.text! + digit
           
        }else{
            display.text = digit
            
            userIsInTheMiddleOfTypingNumber = true
        }
    }
    
    
    @IBAction func appendDecimal(sender: UIButton) {
        let decimal = sender.currentTitle!
        if userIsInTheMiddleOfTypingNumber{
            display.text = display.text! + decimal
        }else{
            display.text = decimal
            
            userIsInTheMiddleOfTypingNumber = true
        }
        
    }
    
    
    @IBAction func appendPi() {
        let pi = String(M_PI)
        if userIsInTheMiddleOfTypingNumber{
            display.text = display.text! + pi
           
        }else{
            display.text = pi
            userIsInTheMiddleOfTypingNumber = true
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        
        //automatic entry
        if userIsInTheMiddleOfTypingNumber{
            enter()
        }
        if let operation = sender.currentTitle{
            if let result = brain.performOperation(operation){
                displayValue = result
            }else{
                displayValue = 0
            }
        }
        
        /*
        if let operation = sender.currentTitle!{
            switch operation{
                case "×":performOperation{$0 * $1}
                /* performOperation({(op1: Double, op2: Double) -> Double
                    in return op1*op2
                    }*/
            

            
            
                case "÷":performOperation{ $1 / $0 }
                case "+":performOperation{ $0 + $1 }
                case "−":performOperation{ $1 - $0 }
                case "√":performOperation{ sqrt($0) }
                case "sin":performOperation{ sin($0) }
                case "cos":performOperation{ cos($0) }
            
           
            
          
            
                default: break
            }
        }*/
        
    }
    
   /* @nonobjc func performOperation(operation: (Double,Double) -> Double){
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
    

    @IBAction func enter() {
        userIsInTheMiddleOfTypingNumber = false
        if let result = brain.pushOperand(displayValue){
            displayValue = result
        }else{
            displayValue = 0
        }
        
    }
    var displayValue: Double{
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingNumber = false
        }
    }
  
}

