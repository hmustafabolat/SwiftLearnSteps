//
//  ViewController.swift
//  PomodoroApp
//
//  Created by Musti on 22.06.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textLabelBorder: UIView!
    @IBOutlet weak var appNameLabel: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appNameLabel.layer.cornerRadius = 30
        appNameLabel.layer.masksToBounds = true
        textLabelBorder.layer.cornerRadius = 30
        textLabelBorder.layer.masksToBounds = true
       
    }

    @IBAction func forwardButton(_ sender: Any) {
    }
    
}

