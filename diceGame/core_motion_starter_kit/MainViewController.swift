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
    
    var results = [String]()
    var game = [Array<Int>]()
    var players = 1
    var wager = Int()
    var player = 0
    var player1 = Int()
    var player2 = Int()
    
    
    @IBOutlet weak var diceView: UIView!
    @IBOutlet weak var playButtonOutlet: UIButton!
    @IBOutlet weak var playerSliderOutlet: UISlider!
    @IBOutlet weak var diceOneLabel: UILabel!
    @IBOutlet weak var diceTwoLabel: UILabel!
    @IBOutlet weak var diceThreeLabel: UILabel!
    @IBOutlet weak var playersLabel: UILabel!
    @IBOutlet weak var wagerLabel: UILabel!
    
    @IBOutlet weak var wagerSliderOutlet: UISlider!
    
//    @IBOutlet weak var currentPlayerLabel: UILabel!
    
    
    @IBOutlet weak var bidView: UIStackView!
    
    
    @IBAction func testButtonPressed(_ sender: UIButton) {
        diceOneLabel.text = String(Int(arc4random_uniform(6))+1)
        diceTwoLabel.text = String(Int(arc4random_uniform(6))+1)
        diceThreeLabel.text = String(Int(arc4random_uniform(6))+1)
        
        results.append(diceOneLabel.text!)
        results.append(diceTwoLabel.text!)
        results.append(diceThreeLabel.text!)
        
    }
    
    @IBAction func playButtonPressed(_ sender: Any) {
        if bidView.isHidden == true {
            bidView.isHidden = false
            playerSliderOutlet.isHidden = true
            playersLabel.isHidden = true
            playButtonOutlet.setTitle("Player \(player+1)", for: .normal)
            playButtonOutlet.isEnabled = false
            
        }
        
    }
    
    @IBAction func bidButtonPressed(_ sender: UIButton) {
        if player > players-1 {
            player = 0
            diceView.isHidden = false
            bidView.isHidden = true
            wagerSliderOutlet.isHidden = true
            wagerLabel.isHidden = true
            playButtonOutlet.isHidden = true
        } else {
        game.append([player, wager])
        player += 1
    }
       playButtonOutlet.setTitle("Player \(player+1)", for: .normal)
    }
    
    
    func playerSlider(_ sender: UISlider) {
        players = Int(sender.value)
        playersLabel.text = "Number of players: \(players)"
    }
    
    func wageSlider(_ sender: UISlider) {
        wager = Int(sender.value)
        wagerLabel.text = "Wager: \(wager)"
        
    }
    
    
    // UI Lifecycle ::::::::::::::::::::::::::::::::::::::::::
    override func viewDidLoad() {
        super.viewDidLoad()
//        playersLabel.text? = "Number Of Players: 1"
        // Make an instance of CMMotionManager
        bidView.isHidden = true
        diceView.isHidden = true
        
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
            manager.deviceMotionUpdateInterval = 0.5
            
            
            // Now we can start our updates, send it to our custom queue, and define a completion handler
            manager.startDeviceMotionUpdates(to: myq, withHandler: { (motionData: CMDeviceMotion?, error: Error?) in
                
                if let data = motionData {
                    
                    // We access motion data via the "attitude" property
                    let attitude = data.userAcceleration
//                    print(attitude)
//                    print("pitch: \(attitude.pitch) ----- roll: \(attitude.roll) ----- yaw: \(attitude.yaw)")
                }
                
            })
 
        }
    }
    
    
    


}



