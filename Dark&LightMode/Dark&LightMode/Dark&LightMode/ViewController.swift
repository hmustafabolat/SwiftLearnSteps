//
//  ViewController.swift
//  Dark&LightMode
//
//  Created by Musti on 5.07.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var changeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Burada belirtilen temayı kullanır sadece değişmez.
        //overrideUserInterfaceStyle = .dark
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let userInterfaceStyle = traitCollection.userInterfaceStyle
        if userInterfaceStyle == .dark{
            changeButton.tintColor = UIColor.white
        }else{
            changeButton.tintColor = UIColor.black
        }
    }
    
    //Anlık olarak temayı güncellemek için kullanılabilecek fonksiyon.
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        let userInterfaceStyle = traitCollection.userInterfaceStyle
        
        if userInterfaceStyle == .dark{
            changeButton.tintColor = UIColor.white
        }else{
            changeButton.tintColor = UIColor.blue
        }
    }


}

//Eğer uygulamanın değişmeden tamamen bir tema da kalmasını istiyorsak, Info kısmından userInterFace ayarı ekleyip dark diye belirtmemiz gerekir.

