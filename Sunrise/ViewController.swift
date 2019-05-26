//
//  ViewController.swift
//  Sunrise
//
//  Created by Indah Fitriany on 20/05/19.
//  Copyright © 2019 Indah Fitriany. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
   
    var player : AVAudioPlayer!
//    var temp = 0
    var counter = 0

    
    let melody : [Int] = [
        2, 2, 3,
        4, 4, 3,
        2, 1, 0,
        0, 1, 2,
        2, 1, 1,
        2, 2, 3,
        4, 4, 3,
        2, 1, 0,
        0, 1, 2,
        1, 0, 0,
        1, 1, 2,
        0, 1, 2,
        3, 2, 0,
        1, 2, 3,
        2, 1, 0,
        1, 4,
        2, 2, 3,
        4, 4, 3,
        2, 1, 0,
        0, 1, 2,
        1, 0, 0
    ]

    
    @IBOutlet weak var sunriseView: UIImageView!
    @IBOutlet weak var landDark: UIImageView!
    @IBOutlet weak var landLight: UIImageView!


    
    let soundArray = [
        "note1", "note2", "note3",
        "note4", "note5", "note6",
        "note7"]
    
    var selectedSoundFileName = ""
    

   
    @IBOutlet var noteButtons: [UIButton]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        self.noteButtons[melody[counter]].alpha = 1

    }

    @IBAction func noteButtonPressed(_ sender: UIButton) {
        
        
        if counter < 61 {
            
            selectedSoundFileName = soundArray[sender.tag]
            
            noteButtons[sender.tag].alpha = 0.5
            print("button sender \(sender.tag)")
            counter += 1
            
            noteButtons[melody[counter]].alpha = 1
            print("button note \(melody[counter])")
            
            playSound()
            
        }else {
            stopSound()
            showAlert()
            counter = 0
            
            
        }
        
        

        if sunriseView.center.y >= 0 {
            UIView.animate(withDuration: 0.5, animations: {
            self.sunriseView.center.y += -30
            })
        }
        
        if self.sunriseView.center.y <= 500 {
            UIView.animate(withDuration: 3) {
                self.landDark.alpha = 0
                self.landLight.alpha = 1

            
            }
        }
        
    }
    
    
    func playSound() {
        
        guard let url = Bundle.main.url(forResource: selectedSoundFileName, withExtension: "wav", subdirectory: "SoundFile") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
            
            /* iOS 10 and earlier require the following line:
             player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
            
            guard let player = player else { return }
            
            player.play()
            
            
        } catch let error {
            print(error.localizedDescription)
        }
        
       
    }
    
    func stopSound() {
        
        player.stop()
    }
    
    
    func showAlert() {
        
        let alert = UIAlertController(title: "Title", message: "Message", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

