//
//  PomodoroVC.swift
//  PomodoroApp
//
//  Created by Musti on 22.06.2023.
//

import UIKit
import AVFoundation

class PomodoroVC: UIViewController {
    
    
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeLabelBorder: UIView!
    
    
    var timer = Timer()
    var isTimerStarted = false
    var time = 5
    var audioPlayer : AVAudioPlayer?
    
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
            if time == 0{
                time = 5
                timeLabel.text = formatTime()
            }
            startTimer()
            isTimerStarted = true
            
        }else{
            
            timer.invalidate()
            isTimerStarted = false
            sender.setImage(UIImage(named: "play"), for: .normal)
            
        }
    }
    
    @IBAction func restartButtonTapped(_ sender: Any) {
        
        restartButton.isEnabled = true
        restartButton.alpha = 1.0
        timer.invalidate()
        time = 5
        isTimerStarted = false
        timeLabel.text = "00:05"
        //Restart butonuna tıklandığında "pause" butonunu "play" olarak değiştirir.
        startButton.setImage(UIImage(named: "play"), for: .normal)
    }
    
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer(){
        if time > 0 {
            time -= 1
            timeLabel.text = formatTime()
        }
        
        if time == 0{
            
            timer.invalidate()
            isTimerStarted = false
            startButton.setImage(UIImage(named: "play"), for: .normal)
            playNotificationSound()
            
        }
        
    }
    
    @objc func formatTime() -> String{
        let minutes = Int(time) / 60 % 60
               let seconds = Int(time) % 60
               return String(format:"%02i:%02i", minutes, seconds)
    }
    
    func playNotificationSound(){
        guard let url = Bundle.main.url(forResource: "ping", withExtension: "mp3") else {
                   return
               }

               do {
                   audioPlayer = try AVAudioPlayer(contentsOf: url)
                   audioPlayer?.prepareToPlay()
                   audioPlayer?.play()
               } catch {
                   print("Error: \(error.localizedDescription)")
               }
           }
    
    
}
