//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Cody LaRont on 12/7/16.
//  Copyright © 2016 Cody LaRont. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var btnSound: AVAudioPlayer!
    
    var leftHandValue = ""
    var rightHandValue = ""
    var result = ""
    var runningNum = ""
    
    var currentOperation = Operation.Empty
    

    @IBOutlet weak var outputLabel: UILabel!
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        outputLabel.text = "0"
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
    
    @IBAction func numberPressed(sender: UIButton) {
        playSound()
        
        runningNum += "\(sender.tag)"
        outputLabel.text = runningNum
    }
    
    @IBAction func onDivide(sender: UIButton) {
        processOperation(operation: .Divide)
    }
    @IBAction func onMultiply(sender: UIButton) {
        processOperation(operation: .Multiply)
    }
    @IBAction func onAdd(sender: UIButton) {
        processOperation(operation: .Add)
    }
    @IBAction func onSubtract(sender: UIButton) {
        processOperation(operation: .Subtract)
    }
    @IBAction func onEqualPressed(sender: UIButton) {
        processOperation(operation: currentOperation)
    }
    @IBAction func onClearPressed(sender: UIButton) {
        leftHandValue = ""
        rightHandValue = ""
        result = "0"
        runningNum = ""
        outputLabel.text = "0"
        currentOperation = Operation.Empty
    }
    
    
    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        btnSound.play()
    }
    
    func processOperation(operation: Operation) {
        playSound()
        if currentOperation != Operation.Empty {
            if runningNum != "" {
                rightHandValue = runningNum
                runningNum = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftHandValue)! * Double(rightHandValue)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftHandValue)! / Double(rightHandValue)!)"
                } else if currentOperation == Operation.Subtract{
                    result = "\(Double(leftHandValue)! - Double(rightHandValue)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftHandValue)! + Double(rightHandValue)!)"
                }
                
                leftHandValue = result
                outputLabel.text = result
            }
            currentOperation = operation
        } else {
            leftHandValue = runningNum
            runningNum = ""
            currentOperation = operation
        }
    }


}

