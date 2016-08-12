//
//  ViewController.swift
//  Retro Calculator
//
//  Created by KarnageKnight on 15/06/16.
//  Copyright © 2016 KarnageKnight. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var outputLbl: UILabel!
    
    enum Operation:String{
        case Divide="/"
        case Multiply="*"
        case Subract="-"
        case Add="+"
        case Empty = "Empty"
    }
    @IBAction func clearButtonPressed(sender: AnyObject) {
        runningNumber=""
        leftValStr=""
        rightValStr=""
        result=""
        currentOperation=Operation.Empty
        outputLbl.text=""
    }
    
    var runningNumber=""
    var leftValStr=""
    var rightValStr=""
    var currentOperation = Operation.Empty
    var result=""

    var btnSound: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path=NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundURL=NSURL.fileURLWithPath(path!)
        do{
            
        
        try btnSound = AVAudioPlayer(contentsOfURL: soundURL)
            btnSound.prepareToPlay()
        }catch let err as NSError{
            print(err.debugDescription)
        }
    }
    
    @IBAction func numberPressed(button: UIButton!){
        playSound()
        runningNumber+="\(button.tag)"
        outputLbl.text=runningNumber
    }
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }

    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }

    @IBAction func onSubractPressed(sender: AnyObject) {
        processOperation(Operation.Subract)
    }
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }

    func processOperation(op: Operation){
        playSound()
        
        if currentOperation != Operation.Empty{
            if runningNumber != ""{
            rightValStr=runningNumber
            runningNumber=""
            
            if currentOperation==Operation.Multiply{
                result="\(Double(leftValStr)! * Double(rightValStr)!)"
            }else if currentOperation==Operation.Divide{
                result="\(Double(leftValStr)! / Double(rightValStr)!)"
            }else if currentOperation==Operation.Subract{
                result="\(Double(leftValStr)! - Double(rightValStr)!)"
            }else if currentOperation==Operation.Add{
                result="\(Double(leftValStr)! +  Double(rightValStr)!)"
            }
            leftValStr=result
            outputLbl.text=result
            }
            currentOperation=op
            
        }else{
            leftValStr=runningNumber
            runningNumber=""
            currentOperation = op
            
        }
    }
    
    func playSound(){
        if btnSound.playing{
            btnSound.stop()
        }
        btnSound.play()
    }
}

