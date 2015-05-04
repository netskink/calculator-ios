//
//  ViewController.swift
//  calculator-ios
//
//  Created by John Fred Davis on 5/2/15.
//  Copyright (c) 2015 Netskink Computing. All rights reserved.
//
// The controller. Main.storyboard is the View

import UIKit

class ViewController: UIViewController {

    // @IBOutle - Xcode puts this here, so that a little circle in gutter 
    // appears that links to the Widget.
    // 
    // weak is for garbage collection
    // var display: UILabel! - objs always live in heap. 
    // var is a variable
    // display is the name
    // :UILabel! is the type
    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTypingANumber: Bool = false
    
    // Function with only one arg
    // sender is the arg and UIButton is the type.
    // this function does not have a return type.
    @IBAction func appendDigit(sender: UIButton) {
        // This uses the optional string? type.
        //let digit = sender.currentTitle
        // This uses the String extraction type.
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
            
        } else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
//        println("digit = \(digit)")
        
    }
    
    var operandStack = Array<Double>()

    // this function has a single argument which
    // is a function with two double parms and returns a double
    // Unless this noted as private it will generate an error.  In swift
    // available at time of standford video this was ok, but now it fails
    // since the class is inherited from view controller and it is objective-C w
    // which can not handle this.  If you mark the function as private it 
    // will not expose the routine to the objective c superclass?
    //
    // more info here:
    // http://stackoverflow.com/questions/29457720/compiler-error-method-with-objective-c-selector-conflicts-with-previous-declara/29670644#29670644
    //
    // and here
    // http://stackoverflow.com/questions/29457720/compiler-error-method-with-objective-c-selector-conflicts-with-previous-declara
    private func performOperation(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation( operandStack.removeLast(), operandStack.removeLast() )
            pressEnter()
        }
    }
    // this function has a single argument which
    // is a function with one double parm and returns a double
    private func performOperation(operation: Double -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation( operandStack.removeLast() )
            pressEnter()
        }
    }
    
    @IBAction func pressOperator(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            pressEnter()
        }
        switch operation {
            case "×": performOperation{ $0 * $1 }
            case "÷": performOperation{ $1 / $0 }
            case "+": performOperation{ $0 * $1 }
            case "−": performOperation{ $1 - $0 }
            case "√": performOperation{ sqrt($0) }
            default: break
            
            
        }
        
    }
    
    @IBAction func pressEnter() {
        userIsInTheMiddleOfTypingANumber = false
        operandStack.append(displayValue)
        println("operandStack = \(operandStack)")
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            // newValue is the value when someone sets it.
            display.text = "\(newValue)" // Convert a double to string
            userIsInTheMiddleOfTypingANumber = false
        }
    }
}

