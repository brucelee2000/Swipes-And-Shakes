# Swipes-And-Shakes
Access resource files
---------------------
Obtain file path and change it to NSURL format

* An NSBundle object represents a location in the file system that groups code and resources that can be used in a program.

* "mainBundle" Returns the NSBundle object that corresponds to the directory where the current application executable is located

* "pathForResource" Returns the full pathname for the resource identified by the specified name and file extension.

        // Grab resource location by calling NSBundle methods
        // - An NSBundle object represents a location in the file system that groups code and resources that can be used in a program.
        // - "mainBundle" Returns the NSBundle object that corresponds to the directory where the current application executable is located
        // - "pathForResource" Returns the full pathname for the resource identified by the specified name and file extension.
        var filePath = NSBundle.mainBundle().pathForResource("prettyboy", ofType: "mp3")
        
        // Construct file path as URL format
        var fileURL = NSURL(fileURLWithPath: filePath!)

        var myError:NSError? = nil
        myPlayer = AVAudioPlayer(contentsOfURL: fileURL, error: &myError)
        
Basic elements (play/pause/stop/volume) in Audio
------------------------------------------------
* **Create Audio player**

        var myPlayer = AVAudioPlayer()
        ...
        var myError:NSError? = nil
        myPlayer = AVAudioPlayer(contentsOfURL: fileURL, error: &myError)
        
* **Audio play**

        @IBAction func playButtonPressed(sender: UIBarButtonItem) {
            myPlayer.play()
        }
        
* **Audio pause**

        @IBAction func pauseButtonPressed(sender: UIBarButtonItem) {
            myPlayer.pause()
        }
    
* **Audio stop**

        @IBAction func stopButtonPressed(sender: UIBarButtonItem) {
            myPlayer.stop()
            // Stop and reset from the beginning
            myPlayer.currentTime = 0
        }
        
* **Audio volume**

        @IBAction func changeVolume(sender: UISlider) {
            myPlayer.volume = volumeSlider.value
        }
        
Add guesture and motion recognition to ViewController 
-----------------------------------------------------
* **Guesture recognition**

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
        
* **Motion recognition**

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
