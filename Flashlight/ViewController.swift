//
//  ViewController.swift
//  Flashlight
//
//  Created by Russell Richardson on 6/4/14.
//  Copyright (c) 2014 Russell Richardson. All rights reserved.
//

import UIKit
import Agent

class ViewController: UIViewController {
    
    
    @IBOutlet var progressBar : UIProgressView
    
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
        println("YOU TOGGLED THE FUCKING BUTTON")
//        var alert = new UIAlertView(title: "FLASH ALL THE LIGHTS", message: "Flash toggled", cancelButtonTitle: "Okay")
        
        let req = Agent.get("http://api.kronosad.com/Modpacks/TMPI.json")
        req.end({ (error: NSError?, response: NSHTTPURLResponse?, data: AnyObject?) -> () in
            // react to the result of your request
            println(data as? String)
            var alert = UIAlertController(title: "The Damn Button", message: data as String, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "GET OUT OF MY FUCKING FACE!", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        })
        
        
        
        
        
        
        
    }
}

