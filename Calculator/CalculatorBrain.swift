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
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)
        //computed properties
        var description: String{
            get{
                switch self{
                case .Operand(let operand):
                    return ("\(operand)")
                case .UnaryOperation(let symbol, _):
                    return symbol
                case .BinaryOperation(let symbol, _):
                    return symbol
                }
            }
        }
        
    }
    private var opStack = [Op]()
    private var knownOps = [String:Op]()
    
    init(){
        func learnOp(op: Op){
            knownOps[op.description] = op
        }
        learnOp(Op.BinaryOperation("×", *))
        learnOp(Op.BinaryOperation("÷"){$1 / $0})
        learnOp(Op.BinaryOperation("+", +))
        learnOp(Op.BinaryOperation("−"){ $1 - $0})
        learnOp(Op.UnaryOperation("√", sqrt))
        
        //knownOps["÷"] = Op.BinaryOperation("÷"){ $1 / $0 }
//        knownOps["+"] = Op.BinaryOperation("+", +)
//        knownOps["−"] = Op.BinaryOperation("−"){ $1 - $0 }
//        knownOps["√"] = Op.UnaryOperation("√", sqrt)
    }
    private func evaluate(ops: [Op])->(result: Double?,remainingOps: [Op]){
        if !ops.isEmpty{
            var remainingOps = ops //copy of ops
            let op = remainingOps.removeLast()
            switch op{
            case .Operand(let operand):
                return (operand, remainingOps)
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
                
            }

            
        }
        //default
        return (nil, ops)
    }
    func evaluate() ->Double? {
        let (result,remainder) = evaluate(opStack)
        
        
        print("\(opStack) = \(result) with \(remainder) left over")
        return result
        
    }
    
    func pushOperand(operand: Double) -> Double?{
        opStack.append(Op.Operand(operand))
        return evaluate()
    }
    func performOperation(symbol: String) ->Double?{
        if let operation = knownOps[symbol]{//dictionary always returns an optional
            opStack.append(operation)
        }
        return evaluate()
        
    }
}