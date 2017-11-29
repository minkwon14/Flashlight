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
    
    // Declaring IBOutlets
    @IBOutlet weak var onBtn: UIButton!
    @IBOutlet weak var powSlider: UISlider!
    @IBOutlet weak var timeSlider: UISlider!
    
    // Declaring all of variables
    var clickCheck = false
    var powerCheck = true
    var timeCheck = false
    var currentPower: Float = 1.0
    var currentTime: Double = 0.0
    var delayTime: Double = 0.0
    var blinkTimer = Timer()
    var offTimer = Timer()
    var onTimer = Timer()

    let device = AVCaptureDevice.default(for: AVMediaType.video)
    var image01 = UIImage(named: "powerBtn01.png")
    var image02 = UIImage(named: "powerBtn02.png")
    
    // IBAction for on Button.
    @IBAction func modeOn(_ sender: Any) {
        if clickCheck == false {
            clickCheck = true
            // Change image when taped.
            self.onBtn.setImage(image02, for: .normal)
            alwaysOn()
        } else {
            clickCheck = false
            self.onBtn.setImage(image01, for: .normal)
            blinkTimer.invalidate()
            offTimer.invalidate()
            onTimer.invalidate()
            alwaysOff()
        }
    }
    
    // IBAction of power slider.
    @IBAction func powSliderValue(_ sender: UISlider) {
        currentPower = sender.value
        powerCheck = true
        if ( clickCheck == true){
            alwaysOn()
        }
    }
    
    // IBAction of tiem slider.
    @IBAction func timeSliderValue(_ sender: UISlider) {
        // Get and set time from Float to Double
        currentTime = Double (round(10*sender.value)/100)
        delayTime = currentTime
        blinkTimer.invalidate()

        if (currentTime == 0.0){
            timeCheck = false
            if clickCheck == true {
                alwaysOn()
            }
        } else {
            timeCheck = true
            if clickCheck == true {
                // When time has set, make torch blink with set time.
                // Timer has been used with time inverval of currentTime.
                blinkTimer = Timer.scheduledTimer(timeInterval: currentTime, target: self, selector: #selector(ViewController.blink), userInfo: nil, repeats: true)
            } else {
                alwaysOff()
            }
        }
    }

    // Obj-C function that torch blink.
    @objc func blink() {
        offTimer.invalidate()
        onTimer.invalidate()
        if (device?.hasTorch)! {
            do {
                try device?.lockForConfiguration()
                alwaysOff()
                blinkOn()
                device?.unlockForConfiguration()
            } catch {
                print ("E.blicnkOn: Torch could not be used!!")
            }
        } else {
            print ("E.blickOn: Torch is not available!")
        }
    }
    
    // Obj-C function that torch be always on.
    @objc func alwaysOn() {
        if (device?.hasTorch)! {
            do {
                try device?.lockForConfiguration()
                // Torch will be on with currentPower.
                try! device?.setTorchModeOn(level: currentPower)
                device?.unlockForConfiguration()
            } catch {
                print ("E.alwaysOn: Torch could not be used!!")
            }
        } else {
            print ("E.alwaysOn: Torch is not available!")
        }
    }

    // Obj-C funtion that torch be always off.
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
    
    // Function that make torch blink with Timer.
    func blinkOn() {
        
        onTimer = Timer.scheduledTimer(timeInterval: delayTime/2, target: self, selector: #selector(ViewController.alwaysOn), userInfo: nil, repeats: false)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    
}

