//
//  ViewController.swift
//  Flashlight
//
//  Created by Minseo Kwon on 2017-11-21.
//  Copyright © 2017 MinKwon. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var onBtn: UIButton!
    @IBOutlet weak var strBtn: UIButton!
    @IBOutlet weak var lightBtn: UIButton!
    @IBOutlet weak var powSlider: UISlider!
    @IBOutlet weak var timeSlider: UISlider!
    
    var clickCheck = false
    var powerCheck = false
    var timeCheck = false
    var currentPower: Float = 1.0
    var currentTime: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func modeOn(_ sender: Any) {
        if clickCheck == false {
            clickCheck = true
            print ("Torch is ON!")
        } else {
            clickCheck = false
            toggleTorch(on: false)
            print ("Torch is OFF!")
        }
    }
    
    @IBAction func modeLight(_ sender: Any) {
    }

    @IBAction func modeStrobe(_ sender: Any) {
        
    }
    
    func toggleTorch(on: Bool) {
        guard let device = AVCaptureDevice.default(for: .video) else {return}
        
        if device.hasTorch {
            do {
                try device.lockForConfiguration()
                
                if on == true {
                    //device.torchMode = .on
                    try! device.setTorchModeOn(level: currentPower)
                } else {
                    device.torchMode = .off
                }
                device.unlockForConfiguration()
                
            } catch {
                print ("Torch could not be used!!")
            }
 
        } else {
            print ("Torch is not available!")
        }
    }
    
    @IBAction func powSliderValue(_ sender: UISlider) {
        currentPower = sender.value
        print ("Current Power is \(currentPower)")
        // toggleTorch(on: clickCheck)
        powerCheck = true
    }
    
    @IBAction func timeSliderValue(_ sender: UISlider) {
        currentTime = Int(sender.value)
        print ("Current Time is \(currentTime)")
        timeCheck = true
    
    }
    
   
    
    
    
}

