//
//  ViewController.swift
//  GestureRecognizerApp
//
//  Created by Musti on 16.06.2023.
//

import UIKit

class ViewController: UIViewController {
    var isFenerbahce = true

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var imageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.isUserInteractionEnabled = true
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(changePic))
        
        imageView.addGestureRecognizer(gestureRecognizer)
       
    }
    
    
    @objc func changePic(){
        
        if isFenerbahce == true{
            imageView.image = UIImage(named: "fenerbahce2")
            imageLabel.text = "Fenerbahçe 2"
            isFenerbahce = false
        }else {
            imageView.image = UIImage(named: "fenerbahce1")
            imageLabel.text = "Fenerbahçe 1"
            isFenerbahce = true
        }
    }
   


}

