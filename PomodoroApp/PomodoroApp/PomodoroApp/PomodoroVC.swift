//
//  PomodoroVC.swift
//  PomodoroApp
//
//  Created by Musti on 22.06.2023.
//

import UIKit

class PomodoroVC: UIViewController {
    
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeLabelBorder: UIView!
    
    
    var timer = Timer()
    var isTimerStarted = false
    var time = 1500
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeLabelBorder.layer.cornerRadius = 50
        timeLabelBorder.layer.masksToBounds = true
        startButton.setImage(UIImage(named: "play"), for: .normal)
        
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        startButton.isEnabled = true
        startButton.alpha = 1.0
        
        if !isTimerStarted || sender.currentImage == UIImage(named: "play"){
            sender.setImage(UIImage(named: "pause"), for: .normal)
            startTimer()
            isTimerStarted = true
            
        }else{
            
            timer.invalidate()
            isTimerStarted = false
            sender.setImage(UIImage(named: "play"), for: .normal)
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        cancelButton.isEnabled = true
        cancelButton.alpha = 0.5
        timer.invalidate()
        time = 1500
        isTimerStarted = false
        timeLabel.text = "25:00"
    }
    
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer(){
        time -= 1
        timeLabel.text = formatTime()
        
    }
    
    @objc func formatTime() -> String{
        let minutes = Int(time) / 60 % 60
               let seconds = Int(time) % 60
               return String(format:"%02i:%02i", minutes, seconds)
    }
    
    
}
