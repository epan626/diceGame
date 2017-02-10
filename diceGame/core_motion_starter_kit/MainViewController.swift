//
//  MainViewController.swift
//  core_motion_starter_kit
//
//  Created by Andy Feng on 2/9/17.
//  Copyright © 2017 Andy Feng. All rights reserved.
//

import UIKit
import CoreMotion

class MainViewController: UIViewController {

    // Global Variables ::::::::::::::::::::::::::::::::::::::
    var motionManager: CMMotionManager?
    
    
    // UI Lifecycle ::::::::::::::::::::::::::::::::::::::::::
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Make an instance of CMMotionManager
        motionManager = CMMotionManager()
        
        if let manager = motionManager {
            print("We have a motion manager")
            detectMotion(manager: manager)
        } else {
            print("No manager")
        }
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    // Helper Functions ::::::::::::::::::::::::::::::::::::::::::
    func detectMotion(manager: CMMotionManager) {
        
        if !manager.isDeviceMotionAvailable {
            // This will print if running on simulator
            print("We cannot detect device motion using the simulator")
        }
        else {
            // This will print if running on iPhone
            print("We can detect device motion")
            
            // Make a custom queue in order to stay off the main queue
            let myq = OperationQueue()
            
            // Customize the update interval (seconds)
            manager.deviceMotionUpdateInterval = 1.0
            
            
            // Now we can start our updates, send it to our custom queue, and define a completion handler
            manager.startDeviceMotionUpdates(to: myq, withHandler: { (motionData: CMDeviceMotion?, error: Error?) in
                
                if let data = motionData {
                    
                    // We access motion data via the "attitude" property
                    let attitude = data.attitude
                    print("pitch: \(attitude.pitch) ----- roll: \(attitude.roll) ----- yaw: \(attitude.yaw)")
                }
                
            })
 
        }
    }
    
    
    

    
    

}











