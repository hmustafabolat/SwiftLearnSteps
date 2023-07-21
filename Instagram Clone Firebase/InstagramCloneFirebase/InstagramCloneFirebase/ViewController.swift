//
//  ViewController.swift
//  InstagramCloneFirebase
//
//  Created by Musti on 7.07.2023.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    
    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        //View yüklendiğinde yapılacak işlemler buraya yazılır.
        super.viewDidLoad()
    }

    
    //Giriş yap butonuna basıldığında çağırılan metod.
    @IBAction func signInClicked(_ sender: Any) {
        
        if emailText.text != "" && passwordText.text != ""{
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!){(authdata, error) in
                if error != nil{
                    self .alertFunc(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error")
                }else{
                    self.performSegue(withIdentifier: "toFeedVc", sender: nil)
                }
                
            }
        }else{
            alertFunc(titleInput: "Error!", messageInput: "Username/Password?")
        }
    }
    
    
    //Kayıt ol butonuna basıldığında çağırılan metod.
    @IBAction func signUpClicked(_ sender: Any) {
        
        //Eğer kullanıcı adı ve parola boş değilse kullanıcı oluşturma işlemini gerçekleştir.
        if emailText.text != "" && passwordText.text != "" {
            // Firebase Authentication kullanarak e-posta ve şifre ile kullanıcı oluşturma işlemi yapılır.
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!){(authdata, error) in
                
                if error != nil {
                    //Hata oluştuğunda hata mesajını kullanıcıya göstermek için bir uyarı mesajı oluşturulur.
                    self.alertFunc(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error")
                }else {
                    //Kullanıcı başarı ile oluşturulduysa "toFeedVc" adlı segue'i çalıştırarak feed ekranına geçiş yapılır.
                    self.performSegue(withIdentifier: "toFeedVc", sender: nil)
                }
            }
        }else{
            // E-posta veya şifre alanlarından biri boşsa, kullanıcıya hata mesajını göstermek için bir uyarı penceresi oluşturulur.
            alertFunc(titleInput: "Error", messageInput: "Email/Password")
        }
        
    }
    
    //Her yerde sürekli aynı kodları yazmamak için fonksiyon oluşturduk ve bu fonksiyonu çağırarak her yerde kullanacağız.
    @objc func alertFunc(titleInput: String, messageInput: String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
}

