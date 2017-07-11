//
//  ViewController.swift
//  RetroCalculatorXcodeCourse
//
//  Created by Pragun Sharma on 11/07/17.
//  Copyright © 2017 Pragun Sharma. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var outputLabel: UILabel!
    
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    var btnSound: AVAudioPlayer!
    var runningNumber = ""
    var currentOperation = Operation.Empty
    var leftValString = ""
    var rightValString = ""
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Grab path to sound file
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err)
        }
        
        outputLabel.text = "0"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func numberPressed(_ sender: UIButton) {
        runningNumber += "\(sender.tag)"
        outputLabel.text = runningNumber
        playSound()
    }
    
    @IBAction func onDividePressed(_ sender: UIButton) {
        processOperation(operation: Operation.Divide)
    }
    
    @IBAction func onMultiplyPressed(_ sender: UIButton) {
        processOperation(operation: Operation.Multiply)
    }
    
    @IBAction func onAddPressed(_ sender: UIButton) {
        processOperation(operation: Operation.Add)
    }
    
    @IBAction func onSubtractPressed(_ sender: UIButton) {
        processOperation(operation: Operation.Subtract)
    }
    
    @IBAction func onEqualsPressed(_ sender: UIButton) {
        processOperation(operation: currentOperation)
    }
    
    func playSound() {
        if(btnSound.isPlaying) {
            btnSound.stop()
        }
        btnSound.play()
    }
    
    func processOperation(operation: Operation) {
        playSound()
        if(currentOperation != Operation.Empty) {
            
            if(runningNumber != "") {
                print("\(runningNumber)")
                rightValString = runningNumber
                runningNumber = ""
                
                if(currentOperation == Operation.Multiply) {
                    result = "\(Double(leftValString)! * Double(rightValString)!)"
                } else if(currentOperation == Operation.Divide) {
                    result = "\(Double(leftValString)! / Double(rightValString)!)"
                } else if(currentOperation == Operation.Subtract) {
                    result = "\(Double(leftValString)! - Double(rightValString)!)"
                } else if(currentOperation == Operation.Add) {
                    result = "\(Double(leftValString)! + Double(rightValString)!)"
                }
                
                leftValString = result
                outputLabel.text = result
            }
            currentOperation = operation
        } else {
            //This is the first time an operator is pressed
            leftValString = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
        
    }
    
}

