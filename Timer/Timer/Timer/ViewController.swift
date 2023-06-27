//
//  ViewController.swift
//  Timer
//
//  Created by Musti on 16.06.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    
    var timer = Timer()
    var counter = 0 //Sayaç değişkeni oluşturduk
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        counter = 10 // Sayacı 10'dan başlattık
        timeLabel.text = "Time: \(counter)" //Sayaçta ki değeri yazdırdık
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunction), userInfo: nil, repeats: true) //Burada 'Timer.scheduledTimer' ile kaç saniyede bir azalacağını, tekrarlanacağını vb. gibi özellikleri verdik.
        
    }
    
    @objc func timerFunction(){
        timeLabel.text = "Time: \(counter)" //Fonksiyon içerisinde sayaç değerini yazdırdık.
        counter -= 1 //Sayacı her seferinde bir azalttık.
        
        if counter == 0 {
            timer.invalidate() //Timer'ı durdurur.
            timeLabel.text = "Time's Over"
        }
    }

    @IBAction func buttonClicked(_ sender: Any) {
        print("Button clicked")
    }
    
}

