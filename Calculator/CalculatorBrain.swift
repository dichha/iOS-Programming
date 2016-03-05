//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by raidi01 on 2/15/16.
//  Copyright © 2016 Luther College. All rights reserved.
//

import Foundation


class CalculatorBrain{
    //var opStack: Array<Op>()
    //CustomStringPrintable is a protocol
    
    private enum Op: CustomStringConvertible{
        case Operand(Double)
        case Variable(String)
        case PiOperation(String, () ->Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)
        //computed properties read only
        var description: String{
            get{
                switch self{
                case .Operand(let operand):
                    return ("\(operand)")
                case .UnaryOperation(let symbol,_):
                    return symbol
                case .BinaryOperation(let symbol, _):
                    return symbol
                case .Variable(let symbol):
                    return symbol
                case .PiOperation(let symbol, _):
                    return symbol
                
                }
                
                
            }
        }
//        var infix :String{
//            get{
//            }
//        }
        
    }
    private var opStack = [Op]()
    private var knownOps = [String:Op]()
    var variableValues = [String:Double]()
    
    init(){
        func learnOp(op: Op){
            knownOps[op.description] = op
        }
        learnOp(Op.BinaryOperation("×", *))
        learnOp(Op.BinaryOperation("÷"){$1 / $0})
        learnOp(Op.BinaryOperation("+", +))
        learnOp(Op.BinaryOperation("−"){ $1 - $0})
        learnOp(Op.UnaryOperation("√", sqrt))
        learnOp(Op.UnaryOperation("sin", sin))
        learnOp(Op.UnaryOperation("cos", cos))
        learnOp(Op.PiOperation("∏", {M_PI}))
        
        
//        knownOps["×"] = Op.BinaryOperation("×",*)
//        knownOps["÷"] = Op.BinaryOperation("÷"){ $1 / $0 }
//        knownOps["+"] = Op.BinaryOperation("+", +)
//        knownOps["−"] = Op.BinaryOperation("−"){ $1 - $0 }
//        knownOps["√"] = Op.UnaryOperation("√", sqrt)
//        knownOps["sin"] = Op.UnaryOperation("sin",sin)
//        knownOps["cos"] = Op.UnaryOperation("cos",cos)
        
    }
    
    
//    var program: AnyObject{ //guaranteed to be a PropertyList
//        get{
//            //var returnValue = Array<String>()//Array is a PropertyList
//            //                for op in opStack{
//            //                    returnValue.append(op.description)
//            //                }
//            //                return returnValue
//            return opStack.map {$0.description }
//            
//        }set{
//            if let opSymbols = newValue as? Array<String>{
//                var newOpStack  = [Op]()
//                for opSymbol in opSymbols{
//                    if let op = knownOps[opSymbol]{
//                        newOpStack.append(op)
//                    }else if let operand = NSNumberFormatter().numberFromString(opSymbol)?.doubleValue{
//                        newOpStack.append(.Operand(operand))
//                        
//                    }
//                    opStack = newOpStack
//                }
//            }
//            
//        }
//    }

    
    
    private func evaluate(ops: [Op])->(result: Double?,remainingOps: [Op]){
        if !ops.isEmpty{
            var remainingOps = ops //copy of ops
            let op = remainingOps.removeLast()
            switch op{
            case .Operand(let operand):
                return (operand, remainingOps)
            case .PiOperation(_, let operation):
                return (operation(), remainingOps)
                
            case .UnaryOperation(_,let operation):
                let operandEvaluation = evaluate(remainingOps)
                  //op1Evaluation is a tuple of result and remaining ops
                if let operand = operandEvaluation.result{
                    return(operation(operand), operandEvaluation.remainingOps)
                }
            case .BinaryOperation(_,let operation):
                let op1Evaluation = evaluate(remainingOps)
                //op1Evaluation is a tuple of result and remaining ops
                if let operand1 = op1Evaluation.result{
                    //getting the value of tuple we use . operation and the names in the tuple
                    let op2Evaluation = evaluate(op1Evaluation.remainingOps)
                    if let operand2 = op2Evaluation.result{
                        return(operation(operand1,operand2), op2Evaluation.remainingOps)
                    }
                }
            case .Variable(let symbol):
                if let value = variableValues[symbol]{
                    return (value, remainingOps)
                }
                return(nil, remainingOps)
            }

            
        }
        //default
        return (nil, ops)
    }
    
    func evaluate() ->Double? {
        let (result,remainder) = evaluate(opStack)
        
        
        //print("\(opStack) = \(result!) with \(remainder) left over")
        return result
        
    }
   
    
    
    
    private func description(ops:[Op]) ->(result: String?, remainingOps: [Op]){
        if !ops.isEmpty{
            var remainingOps = ops
            let op = remainingOps.removeLast()
            switch op{
            case .Operand(let operand):
                return("\(operand)", remainingOps)
            case .PiOperation(let symbol, _):
                return(symbol, remainingOps)
            case .UnaryOperation(let symbol, _):
                let operandEvaluation = description(remainingOps)
                if var operand = operandEvaluation.result{
                    operand = "\(operand)"
                    return("\(symbol) (\(operand))",operandEvaluation.remainingOps)
                }
                
                
            case .BinaryOperation(let symbol, _):
                let op1Evaluation = description(remainingOps)
                if var operand1 = op1Evaluation.result{
                    operand1 = "\(operand1)"
                    let op2Evaluation = description(op1Evaluation.remainingOps)
                    if var operand2 = op2Evaluation.result{
                        operand2 = "\(operand2)"
                        return ("(\(operand2)\(symbol)\(operand1))", op2Evaluation.remainingOps)
                    }
                   
                }
            case .Variable(let symbol):
                return (symbol, remainingOps)
                
            }
            
        }
        return (nil, ops)
        
    }
    
    var description: String{
        get{
            var (result, ops) = ("", opStack)
            while ops.count > 0 {
                var currentResult: String?
                (currentResult, ops) = description(ops)//returns string and ops
                result = (result == "" ? currentResult! : "\(currentResult!), \(result)")
                
            }
            return result
        }
    }
    
    func pushOperand(operand: Double) -> Double?{
        opStack.append(Op.Operand(operand))
        return evaluate()
    }
    func pushOperand(symbol:String) ->Double?{
        opStack.append(Op.Variable(symbol))
        return evaluate()
        
    }
    func performOperation(symbol: String) ->Double?{
        if let operation = knownOps[symbol]{//dictionary always returns an optional
            opStack.append(operation)
        }
        return evaluate()
        
    }
    func clearOpStack(){
        opStack.removeAll()
    }
}