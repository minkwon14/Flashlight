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
    @IBOutlet weak var powSlider: UISlider!
    @IBOutlet weak var timeSlider: UISlider!
    
    
    var clickCheck = false
    var powerCheck = true
    var timeCheck = false
    var currentPower: Float = 1.0
    var currentTime: Double = 0.0
    var timer: Timer?

    let device = AVCaptureDevice.default(for: AVMediaType.video)
    var image01 = UIImage(named: "powerBtn01.png")
    var image02 = UIImage(named: "powerBtn02.png")
    
    @IBAction func modeOn(_ sender: Any) {
        if clickCheck == false {
            timer?.invalidate()
            clickCheck = true
            alwaysOn()
            self.onBtn.setImage(image02, for: .normal)
        } else {
            timer?.invalidate()
            clickCheck = false
            alwaysOff()
            self.onBtn.setImage(image01, for: .normal)
        }
    }
    
    @IBAction func powSliderValue(_ sender: UISlider) {
        currentPower = sender.value
        powerCheck = true
        if clickCheck == true {
            alwaysOn()
        }
    }
    
    @IBAction func timeSliderValue(_ sender: UISlider) {
        currentTime = Double (sender.value)
        if (currentTime == 0.0){
            timeCheck = false
        } else {
            timeCheck = true
            if clickCheck == true {
                
            } else {
                timer?.invalidate()
                alwaysOff()
            }
        }
    }
    
    
    @objc func blinkOn() -> Void {
        
        if (device?.hasTorch)! {
            do {
                try device?.lockForConfiguration()
                
                 //alwaysOn()
                
                
                Timer.scheduledTimer(timeInterval: currentTime, target: self, selector: #selector(ViewController.alwaysOn), userInfo: nil, repeats: false)
                
                
                Timer.scheduledTimer(timeInterval: currentTime, target: self, selector: #selector(ViewController.alwaysOff), userInfo: nil, repeats: false)
                
                
                //alwaysOff()
                
                device?.unlockForConfiguration()
            } catch {
                print ("E.blicnkOn: Torch could not be used!!")
            }
            
        } else {
            print ("E.blickOn: Torch is not available!")
        }
        
    
    }
    
    @objc func alwaysOn() -> Void {
        if (device?.hasTorch)! {
            do {
                try device?.lockForConfiguration()
                try! device?.setTorchModeOn(level: currentPower)
                device?.unlockForConfiguration()
            } catch {
                print ("E.alwaysOn: Torch could not be used!!")
            }
        } else {
            print ("E.alwaysOn: Torch is not available!")
        }
    }
    

    @objc func alwaysOff () {
        if (device?.hasTorch)! {
            do {
                try device?.lockForConfiguration()
                device?.torchMode = .off
                device?.unlockForConfiguration()
            } catch {
                print ("E.alwaysOff: Torch could not be used!!")
            }
        } else {
            print ("E.alwaysOff: Torch is not available!")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func toggleTorch(on: Bool, power: Bool, time: Bool) {
        if (device?.hasTorch)! {
            do {
                try device?.lockForConfiguration()
                
                if on == true {
                    
                    if (power == true && time == true) {
                        
                        timer = Timer.scheduledTimer(timeInterval: currentTime, target: self, selector: #selector(ViewController.blinkOn), userInfo: nil, repeats: true)
                        
                        print ("Timer needs to be fixed!!")
                        
                    } else if (power == true && time == false){
                        
                        try! device?.setTorchModeOn(level: currentPower)
                        // device.torchMode = .on
                        print ("Torch is ON!!")
                        
                    } else {
                        
                    }
                } else {
                    device?.torchMode = .off
                    timer?.invalidate()
                    print ("Torch is OFF!!")
                }
                device?.unlockForConfiguration()
                
            } catch {
                print ("Torch could not be used!!")
            }
            
        } else {
            print ("Torch is not available!")
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    
}

