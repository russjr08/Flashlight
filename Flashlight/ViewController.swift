//
//  ViewController.swift
//  Flashlight
//
//  Created by Russell Richardson on 6/4/14.
//  Copyright (c) 2014 Russell Richardson. All rights reserved.
//

import UIKit

import AVFoundation


class ViewController: UIViewController {
    
    
    @IBOutlet var progressBar : UIProgressView
    
    @IBOutlet var toggleFlash : UISwitch
    
    var progDown = false
    
    var progress: Float = 0.0
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Spawns this in a new thread.
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            while(true){
//                println(self.progress)
                if(self.progress >= 1.0){
                    self.progDown = true
                }
                
                if(self.progress <= 0){
                    self.progDown = false
                }
                
                if(self.progDown){
                    self.progress -= 0.1
                }else{
                    self.progress += 0.1
                }
                // Run this code on the main/UI thread so that the progress bar actually updates.
                dispatch_async(dispatch_get_main_queue(), {
                    self.progressBar.setProgress(self.progress, animated: true)
                })
                
                
                sleep(1)
            }
            
        })
//        println("We've scheduled the thread!")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnFlash(sender : UISwitch) {        
        
        var device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        if(device){
            if(device.hasFlash && device.hasTorch){
                if(toggleFlash.on){
                    device.setTorchModeOnWithLevel(1, error: nil)
                    println("Activated Torch")
                } else {
                    device.setTorchModeOnWithLevel(0, error: nil)
                    println("Deactivated Torch")
                }
            } else {
                noFlashAvailable()
            }
        } else {
            noFlashAvailable()
        }
        
        
    }
    
    func noFlashAvailable() {
        
        var alert = UIAlertController(title: "Unsupported Device", message: "Your device does not have a torch/flash!", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
}

