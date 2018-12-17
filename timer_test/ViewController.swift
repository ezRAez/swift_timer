//
//  ViewController.swift
//  timer_test
//
//  Created by Ezra Raez on 12/16/18.
//  Copyright © 2018 TPT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var count: Int = 3
    var maxima: Int = 3
    var timer = Timer()

    @IBOutlet weak var timerText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.restartCount(_:)))
        self.view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view, typically from a nib.
    }

    @objc func restartCount(_ sender: UITapGestureRecognizer) {
        timer.invalidate()
        count = maxima
        timerText.font = timerText.font.withSize(200)
        timerText.text = "\(count)"
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
        } else {
            timerText.text = "\(count)"
        }
    }
    
}

