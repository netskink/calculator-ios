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
}

