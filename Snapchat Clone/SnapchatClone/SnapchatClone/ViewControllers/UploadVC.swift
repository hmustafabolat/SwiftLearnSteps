//
//  UploadVC.swift
//  SnapchatClone
//
//  Created by Musti on 24.07.2023.
//

import UIKit
import Firebase
import FirebaseStorage


class UploadVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var uploadImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        uploadImageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        uploadImageView.addGestureRecognizer(gestureRecognizer)
    }
    
    @IBAction func uploadClicked(_ sender: Any) {
        //Storage
                
                let storage = Storage.storage()
                let storageReference = storage.reference()
                
                let mediaFolder = storageReference.child("media")
                
                
                if let data = uploadImageView.image?.jpegData(compressionQuality: 0.5) {
                    
                    let uuid = UUID().uuidString
                    
                    let imageReference = mediaFolder.child("\(uuid).jpg")
                    
                    imageReference.putData(data, metadata: nil) { (metadata, error) in
                        if error != nil {
                            self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                        } else {
                            
                            imageReference.downloadURL { (url, error) in
                                if error == nil {
                                    
                                    let imageUrl = url?.absoluteString
                                    
                                    //Firestore
                                    
                                    let fireStore = Firestore.firestore()
                                    
                                    fireStore.collection("Snaps").whereField("snapOwner", isEqualTo: UserSingleton.sharedUserInfo.username).getDocuments { (snapshot, error) in
                                        if error != nil {
                                            self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                                        } else {
                                            if snapshot?.isEmpty == false && snapshot != nil {
                                                for document in snapshot!.documents {
                                                    
                                                    let documentId = document.documentID
                                                    
                                                    if var imageUrlArray = document.get("imageUrlArray") as? [String] {
                                                        imageUrlArray.append(imageUrl!)
                                                        
                                                        let additionalDictionary = ["imageUrlArray" : imageUrlArray] as [String : Any]
                                                        
                                                        fireStore.collection("Snaps").document(documentId).setData(additionalDictionary, merge: true) { (error) in
                                                            if error == nil {
                                                                self.tabBarController?.selectedIndex = 0
                                                                self.uploadImageView.image = UIImage(named: "selectimage.png")
                                                            }
                                                        }
                                                        
                                                        
                                                    }
                                                    
                                                    
                                                }
                                            } else {
                                                let snapDictionary = ["imageUrlArray" : [imageUrl!], "snapOwner" : UserSingleton.sharedUserInfo.username,"date":FieldValue.serverTimestamp()] as [String : Any]
                                                
                                                fireStore.collection("Snaps").addDocument(data: snapDictionary) { (error) in
                                                    if error != nil {
                                                        self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                                                    } else {
                                                        self.tabBarController?.selectedIndex = 0
                                                        self.uploadImageView.image = UIImage(named: "selectimage.png")
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    
                                    
                                    
                                    
                                    
                                    
                                }
                            }
                            
                            
                        }
                    }
                    
                    
                    
                }

    }
    
    @objc func chooseImage(){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present (pickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        uploadImageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }

    func makeAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: title, style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}

/*
 Aynı kullanıcıdan olması durumunda üzerine yazmasını sağlayan farklı bir yöntem.
 @IBAction func uploadClicked(_ sender: Any) {
     let storage = Storage.storage()
     let storageReference = storage.reference()
     let mediaFolder = storageReference.child("media")
     
     if let data = uploadImageView.image?.jpegData(compressionQuality: 0.5) {
         let uuid = UUID().uuidString
         let imageReference = mediaFolder.child("\(uuid).jpg")
         
         imageReference.putData(data, metadata: nil) { (metadata, error) in
             if let error = error {
                 self.makeAlert(title: "Error", message: error.localizedDescription)
             } else {
                 print("#1 Url Oluşturuldu")
                 imageReference.downloadURL { (url, error) in
                     if let error = error {
                         self.makeAlert(title: "Error", message: error.localizedDescription)
                     } else if let imageUrl = url?.absoluteString {
                         // Firestore
                         let fireStore = Firestore.firestore()
                         
                         // Kullanıcının belgesini referans alıyoruz
                         let userDocument = fireStore.collection("Snaps").document(UserSingleton.sharedUserInfo.username)
                         
                         userDocument.getDocument { (document, error) in
                             if let document = document, document.exists {
                                 // Kullanıcının belgesi varsa, "imageUrlArray" alanını güncelliyoruz
                                 if var imageUrlArray = document.get("imageUrlArray") as? [String] {
                                     imageUrlArray.append(imageUrl)
                                     userDocument.updateData(["imageUrlArray": imageUrlArray]) { error in
                                         if let error = error {
                                             self.makeAlert(title: "Error", message: error.localizedDescription)
                                         } else {
                                             self.tabBarController?.selectedIndex = 0
                                             self.uploadImageView.image = UIImage(named: "select")
                                         }
                                     }
                                 }
                             } else {
                                 // Kullanıcının belgesi yoksa, yeni bir belge oluşturuyoruz
                                 let snapDictionary = [
                                     "imageUrlArray" : [imageUrl],
                                     "snapOwner" : UserSingleton.sharedUserInfo.username,
                                     "date": FieldValue.serverTimestamp()
                                 ] as [String : Any]
                                 
                                 fireStore.collection("Snaps").document(UserSingleton.sharedUserInfo.username).setData(snapDictionary) { (error) in
                                     if let error = error {
                                         self.makeAlert(title: "Error", message: error.localizedDescription)
                                     } else {
                                         self.tabBarController?.selectedIndex = 0
                                         self.uploadImageView.image = UIImage(named: "select")
                                     }
                                 }
                             }
                         }
                     }
                 }
             }
         }
     }
 }

 */
