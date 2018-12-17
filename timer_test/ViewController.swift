//
//  ViewController.swift
//  timer_test
//
//  Created by Ezra Raez on 12/16/18.
//  Copyright © 2018 TPT. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var count: Int = 3
    var maxima: Int = 3
    var timer = Timer()
    
    var player: AVAudioPlayer?

    @IBOutlet weak var timerText: UILabel!
    
    @IBOutlet weak var threeButton: UIButton!
    @IBOutlet weak var fiveButton: UIButton!
    @IBOutlet weak var sevenButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.restartCount(_:)))
        self.view.addGestureRecognizer(tap)
        let viewController = self
        // Do any additional setup after loading the view, typically from a nib.
        threeButton.addTarget(self ,action: #selector(viewController.resetMaxima(_:)),
                          for:.touchUpInside)
        fiveButton.addTarget(self ,action: #selector(viewController.resetMaxima(_:)),
                              for:.touchUpInside)
        sevenButton.addTarget(self ,action: #selector(viewController.resetMaxima(_:)),
                              for:.touchUpInside)
    }
    
    @objc func resetMaxima(_ sender: UIButton) {
        timer.invalidate()
        maxima = sender.tag
        resetTimerView()
    }
    
    func resetTimerView() {
        count = maxima
        timerText.font = timerText.font.withSize(200)
        timerText.text = "\(count)"
    }

    @objc func restartCount(_ sender: UITapGestureRecognizer) {
        timer.invalidate()
        resetTimerView()
        runTimer()
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(ViewController.countdownTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func countdownTimer() {
        count -= 1
        if count == 0 {
            timerText.font = timerText.font.withSize(90)
            timerText.text = "SOLD!"
            timer.invalidate()
            playSound()
        } else {
            timerText.text = "\(count)"
        }
    }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "gavel", withExtension: "wav") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
            
            guard let player = player else { return }
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

