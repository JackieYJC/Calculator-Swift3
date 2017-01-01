//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by JackieYJC on 12/25/16.
//  Copyright © 2016 Stanford University. All rights reserved.
//

import Foundation

class CalculatorBrain
{
    private var accumlator = 0.0
    
    func setOperand(operand: Double) {
        accumlator = operand
    }
    
    private var operations: Dictionary<String,Operation> = [
        "π" : Operation.Constant(M_PI),
        "e" : Operation.Constant(M_E),
        "+-" : Operation.UnaryOperation({ -$0 }),
        "√" : Operation.UnaryOperation(sqrt),
        "cos" : Operation.UnaryOperation(cos),
        "×" : Operation.BinaryOperation({ $0 * $1 }),
        "÷" : Operation.BinaryOperation({ $0 / $1 }),
        "+" : Operation.BinaryOperation({ $0 + $1 }),
        "−" : Operation.BinaryOperation({ $0 - $1 }),
        "=" : Operation.Equals
    ]
    
    private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
        // func
    }
    
    func performOperation(symbol: String){
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let value):
                accumlator = value
            case .UnaryOperation(let foo):
                accumlator = foo(accumlator)
            case .BinaryOperation(let foo):
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: foo, firstOperand: accumlator)
            case .Equals:
                executePendingBinaryOperation()
            }
            
        }
    }
    
    private func executePendingBinaryOperation()
    {
        if pending != nil {
            accumlator = pending!.binaryFunction(pending!.firstOperand, accumlator)
            pending = nil
        }
    }
    
    private var pending: PendingBinaryOperationInfo?
    
    private struct PendingBinaryOperationInfo{
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
    }
    
    var result: Double {
        get {
            return accumlator
        } // only get{} makes it a read-only prop
    }
    
    
}
