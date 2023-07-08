//
//  UploadViewController.swift
//  InstagramCloneFirebase
//
//  Created by Musti on 7.07.2023.
//

import UIKit

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var commentText: UITextField!
    
    @IBOutlet weak var uploadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Kullanıcının resmi tıklanabilir hale getirmesini sağlıyoruz öncelikle.
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage) )
        imageView.addGestureRecognizer(gestureRecognizer)
        
    }
    
    //Resim seçici fonksiyon
    @objc func chooseImage(){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    
    //Resmi seçtikten sonra ne olacağını belirleyen fonksiyon.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func actionButtonClicked(_ sender: Any) {
    }
    
   

}
