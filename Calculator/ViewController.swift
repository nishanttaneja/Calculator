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
    
    // IBActions
    @IBAction func numberSelected(_ sender: UIButton!) {
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
        didFinishEnteringNumber = true
        if sender.currentTitle == "C" {allClearButton.setTitle("AC", for: .normal); numberLabel.text = "0"}
    }
}

