//
//  ViewController.swift
//  Calculator
//
//  Created by Nishant Taneja on 21/08/20.
//  Copyright © 2020 nishanttaneja. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // IBOutlet
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var allClearButton: UIButton!
    
    // Variables
    private var didFinishEnteringNumber: Bool = true
    private var currentValue: Double? {
        get {
            let value = Double(numberLabel.text!)!
            return value
        }
        set {
            if newValue!.canBeInt() {numberLabel.text = String(newValue!.getIntValue())}
            else {numberLabel.text = String(newValue!)}
        }
    }
    private var previousValue: Double?
    private var hasPreviousValue: Bool {
        get {
            if let _ = previousValue {return true}
            return false
        }
    }
    private var operation: String?
    
    // IBActions
    @IBAction func numberSelected(_ sender: UIButton!) {
        // .,0,1,2,3,4,5,6,7,8,9
        if allClearButton.currentTitle == "AC" {allClearButton.setTitle("C", for: .normal)}
        if sender.currentTitle == "." {
            if didFinishEnteringNumber {numberLabel.text = "0."; didFinishEnteringNumber=false; return}
            if !numberLabel.text!.contains(".") {numberLabel.text! += "."}
        } else {
            if didFinishEnteringNumber {numberLabel.text = sender.currentTitle; didFinishEnteringNumber=false}
            else {numberLabel.text! += sender.currentTitle!}
        }
    }
    @IBAction func operationSelected(_ sender: UIButton!) {
        // =,+,-,x,÷,%,±,AC/C
        if allClearButton.currentTitle == "AC" {
            allClearButton.setTitle("C", for: .normal)
            currentValue = nil
            previousValue = nil
            operation = nil
        }
        didFinishEnteringNumber = true
        if sender.currentTitle == "±" {
            didFinishEnteringNumber = false     // Continue editing number till a mathematical operation is applied again
            let numInDouble = Double(numberLabel.text!)! * (-1)
            if numInDouble.canBeInt() {numberLabel.text = String(numInDouble.getIntValue())}
            else {numberLabel.text = String(numInDouble)}
            return
        }
        else if sender.currentTitle == "C" {allClearButton.setTitle("AC", for: .normal); numberLabel.text = "0"; return}
        else if sender.currentTitle == "%" {currentValue! /= 100}
        else {
            if previousValue == nil {
                previousValue = currentValue
                operation = sender.currentTitle
            } else {
                if hasPreviousValue {
                    perform()
                    operation = sender.currentTitle
                    previousValue = currentValue
                }
            }
        }
    }
    
    private func perform() {
        if let prevVal = previousValue, let curVal = currentValue {
            if operation == "+" {currentValue = prevVal+curVal}
            else if operation == "-" {currentValue = prevVal-curVal}
            else if operation == "x" {currentValue = prevVal*curVal}
            else if operation == "÷" {currentValue = prevVal/curVal}
        }
    }
}

//MARK: - DoubleIsInt | Operations
extension Double {
    func canBeInt() -> Bool {
        // Returns true if Double is equal to Int
        let numInInt = Int(self)
        if Double(numInInt) == self {return true}
        return false
    }
    func getIntValue() -> Int {
        // Returns Int value
        return Int(self)
    }
}

