//
//  ViewController.swift
//  Calculator
//
//  Created by JackieYJC on 12/22/16.
//  Copyright © 2016 Stanford University. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet private var display: UILabel! // implicit unwrapping
    
    private var userIsInTheMiddleOfTyping = false
    
    
    @IBAction private func touchDigit(_ sender: UIButton){
        
        let digit = sender.currentTitle! // unwrap the optional
        
        if userIsInTheMiddleOfTyping {
            let textCurrenlyInDisplay = display.text!
            
            display.text = textCurrenlyInDisplay + digit // String
        }
        else
        {
            display.text = digit
        }
        userIsInTheMiddleOfTyping = true
    }
    
    private var displayValue: Double // computed property
        {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue) // keyword "newValue"
        }
    }
    
    private var brain = CalculatorBrain()
    
    
    @IBAction private func performOperation(_ sender: UIButton){
        if userIsInTheMiddleOfTyping{
            brain.setOperand(operand: displayValue)
            userIsInTheMiddleOfTyping = false
        }
        userIsInTheMiddleOfTyping = false
        if let mathematicalSymbol = sender.currentTitle
            // unwrap only if the optional is set
        {
            brain.performOperation(symbol: mathematicalSymbol)
        }
        displayValue = brain.result
        
        
    }
    
}

