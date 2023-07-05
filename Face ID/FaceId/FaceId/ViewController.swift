//
//  ViewController.swift
//  FaceId
//
//  Created by Musti on 5.07.2023.
//

import UIKit
import LocalAuthentication
class ViewController: UIViewController {
    @IBOutlet weak var myLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func signInClicked(_ sender: Any) {
        let authContext = LAContext()
        
        var error: NSError?
        
        if authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            authContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Is it you?") {
                (succes,error) in
                if succes == true{
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "toSignedVc", sender: nil)
                    }
                    
                }else{
                    DispatchQueue.main.async {
                        self.myLabel.text = "Error!"
                    }
                }
            }
    }
    
    
    }
}

