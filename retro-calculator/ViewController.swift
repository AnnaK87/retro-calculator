//
//  ViewController.swift
//  retro-calculator
//
//  Created by Anna Kaukh on 7/7/16.
//  Copyright © 2016 Anna Kaukh. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    enum Operation: String {
        case Devide = "/"
        case Multiply = "*"
        case Substract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLbl: UILabel!
    var btnSound: AVAudioPlayer!
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
        } catch let err as NSError {
          print(err.debugDescription)
        }
        
    }

    @IBAction func numberPressed(btn: UIButton!) {
     playSound()
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
    }

    
    @IBAction func clearBtn(sender: AnyObject) {
        playSound()
        outputLbl.text = "0"
        currentOperation = Operation.Empty
    }
    
    
    @IBAction func onDevidePressed(sender: AnyObject) {
        proccessOperation(Operation.Devide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        proccessOperation(Operation.Multiply)
    }
    
    @IBAction func onSubstractPressed(sender: AnyObject) {
        proccessOperation(Operation.Substract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        proccessOperation(Operation.Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        proccessOperation(currentOperation)
    }
    
    func proccessOperation (op: Operation) {
        playSound()
        
        if currentOperation != Operation.Empty {
            
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Float(leftValStr)! * Float(rightValStr)!)"
                } else if currentOperation == Operation.Devide {
                    result = "\(Float(leftValStr)! / Float(rightValStr)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Float(leftValStr)! + Float(rightValStr)!)"
                } else if currentOperation == Operation.Substract {
                    result = "\(Float(leftValStr)! - Float(rightValStr)!)"
                }
                
                
                leftValStr = result
                outputLbl.text = result
            }
            
            currentOperation = op
        
        } else {
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
        }
    }
    
    func playSound() {
        if btnSound.playing {
            btnSound.stop()
        }
        btnSound.play()
    }
}

