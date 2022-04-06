//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation





class ViewController: UIViewController {
    
    let eggTimes  =  [
        "Soft": 5,
        "Medium": 7,
        "Hard": 12]
    var secondsRemaining: Int = 0
    var progressPercent: Float = 0.2
    var ourTimer = Timer.init()
    var result = 0
    var audioPlayer: AVAudioPlayer?
    
    
    @IBOutlet weak var mainLabel: UILabel!
    
    @IBOutlet weak var mainProgressBar: UIProgressView!
    
    override func viewDidLoad() {
        mainProgressBar.isHidden = true
        mainProgressBar.progress = 0.00
        
    }
    
    
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        let hardness = sender.currentTitle!
        result = eggTimes[hardness]!
        
        
        
        secondsRemaining = result
        ourTimer.invalidate()
        
        
        mainLabel.text = "result after \(secondsRemaining) seconds"
        
        print("\(hardness) - \(result)")
        
        ourTimer = Timer.scheduledTimer(timeInterval: 1.0, target:self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
    }
    @objc func updateTimer() {
        if secondsRemaining > 0 {
            mainProgressBar.isHidden = false
            mainProgressBar.progress = (Float(result) - Float(secondsRemaining)) /  Float(result)
            print (mainProgressBar.progress)
            print ("\(secondsRemaining) seconds")
            mainLabel.text = "\(secondsRemaining) seconds"
            secondsRemaining -= 1
        } else {
            print ("\(secondsRemaining) seconds")
            mainLabel.text = "Done!"
            mainProgressBar.progress = 1.00
            ourTimer.invalidate()
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
                self.mainLabel.text = "Well done!"
                self.mainProgressBar.isHidden = true
                self.playFinSound()
            }
            Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { (timer) in
                self.mainLabel.text = "How do you like your eggs?"
            }
            
        
        }
    }
    func playFinSound() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            
            audioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            

            guard let audioPlayer = audioPlayer else { return }

            audioPlayer.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    

}
