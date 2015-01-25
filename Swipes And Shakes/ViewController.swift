//
//  ViewController.swift
//  Swipes And Shakes
//
//  Created by Yosemite on 1/24/15.
//  Copyright (c) 2015 Yosemite. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var files = ["kid", "laughter", "party", "pingas", "running", "silly", "superman"]
    
    var myPlayer:AVAudioPlayer = AVAudioPlayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Add swipe regonizer to the view
        var swipeRight = UISwipeGestureRecognizer(target: self, action: "swipeAction:")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
        
        var swipeUp = UISwipeGestureRecognizer(target: self, action: "swipeAction:")
        swipeUp.direction = UISwipeGestureRecognizerDirection.Up
        self.view.addGestureRecognizer(swipeUp)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Add respond function of swipe
    func swipeAction(guesture:UIGestureRecognizer) {
        // Check if guesture is a swipe guesture
        if let swipeGuesture = guesture as? UISwipeGestureRecognizer {
            switch swipeGuesture.direction {
            case UISwipeGestureRecognizerDirection.Right:
                println("Swiped right")
            case UISwipeGestureRecognizerDirection.Up:
                println("Swiped up")
            default:
                println("AHHHH what have you swipe!")
                break
            }
            
        }
        
    }
    
    // Adding shake
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent) {
        if event.subtype == UIEventSubtype.MotionShake {
          
            var randomNumber = Int(arc4random_uniform(UInt32(files.count)))
            println("Shaked...\(randomNumber)")
            
            // Get sound files
            var filePath = NSBundle.mainBundle().pathForResource(files[randomNumber], ofType: "mp3")
            var fileURL = NSURL(fileURLWithPath: filePath!)
            var myPlayerError:NSError? = nil
            
            myPlayer = AVAudioPlayer(contentsOfURL: fileURL, error: &myPlayerError)
            myPlayer.play()
        }
    }
    
}

