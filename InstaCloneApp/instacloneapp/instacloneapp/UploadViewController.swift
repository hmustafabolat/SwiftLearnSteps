//
//  UploadViewController.swift
//  instacloneapp
//
//  Created by Musti on 15.07.2023.
//
// Delegate: Bir sınıfın veya nesnenin belirli olayları veya işlemleri başka bir sınıf veya nesneye devretmesini sağlayan bir tasarım desenidir.
// Self: 'self', bir sınıfın veya nesnenin kendisini temsil eden bir referanstır. Bir sınıf içinde kullanıldığında, 'self' sözcüğü o sınıfın mevcut örneğini(nesnesini) temsil eder.
// Bu şekilde 'delegate' ve 'self' kullanarak, bir nesnenin başka bir nesneyle iletişim kurmasını ve o nesnenin davranışını özelleştirmesini sağlayabilirsiniz.

import UIKit
import Firebase
import FirebaseStorage

class UploadViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var commentText: UITextField!
    
    @IBOutlet weak var uploadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //'imageView' nesnesinin kullanıcı etkileşimini etklinleştirir.
        imageView.isUserInteractionEnabled = true
        //'UITapGestureRecognizer' sınıfından bir nesne oluşturur ve 'chooseImage' isimli bir metodu tetikleyecek şekilde yapılandırır.
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        //Oluşturulan etkileşim tanıma nesnesi, 'imageView'a' eklenir.
        imageView.addGestureRecognizer(gestureRecognizer)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //'info' sözlüğünden '.originalImage' anahtarını kullanarak seçilen orjinal resmi alır ve bu resmi 'imageView'ın görüntüsüne atar.
        imageView.image = info[.originalImage] as? UIImage
        //Kullanıcının resim seçim işlemi bittiğinde resim seçim ekranının kapatılıp ana ekrana dönüşünü sağlar.
        self.dismiss(animated: true, completion: nil)
    }
    
    func makeAlert(titleInput: String, messageInput: String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true,completion: nil)
    }
    
    @IBAction func actionButtonClicked(_ sender: Any) {
        
        //Storage sınıfı Firebase Storage hizmetine erişim sağlamak için kullanılır.
        let storage = Storage.storage()
        //'storageReference', depolama hizmetindeki belirli bir konumu temsil eder.
        let storageReference = storage.reference()
        //'storageReference üzerinde 'media' adında bir klasör oluşturulur ve bu değişkene atanır.
        let mediaFolder = storageReference.child("media")
        
        //'JPEG'in veriye dönüştürülmesi ve dataya aktarılmasının ardından sıkıştırma işlemi yapılır ve veri boyutu düşürülür.
        if let data = imageView.image?.jpegData(compressionQuality: 0.5){
            
            //Her kaydedilen resim için ayrı bir id tutar.
            let uuid = UUID().uuidString
            //'imageReference', 'mediaFolder' altında 'image.jpg' adında bir referans oluşturur. Bu yüklenen görüntünün konumunu temsil eder.
            let imageReference = mediaFolder.child("\(uuid).jpg")
            //'putData(_:metadata:completion:)' metodu 'data' değişkenindeki görüntü verisini 'imageReference' konumuna yükler.
            imageReference.putData(data, metadata: nil){ (metadata, error) in
                //İşlem tamamlandıktan sonra bu ifade işlemin sonucunu ve olası hataları içeren 'metadata' ve 'error' parametrelerini alır.
                if error != nil{
                    self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error")
                }else{
                    //'downloadURL' yüklenen görüntünün indirme URL'sini almak için kullanılır.
                    imageReference.downloadURL{(url, error) in
                        //İşlem tamamlandığında indirme URL'sini ve olası hataları içeren 'url' ve 'error' parametrelerini alır.
                        if error == nil{
                            let imageUrl = url?.absoluteString
                            
                            
                            //Database
                            //Firebase, firestore veritabanına erişmek için kullanılan 'Firestore' sınıfının bir örnerğini oluşturur.
                            let firestoreDatabase = Firestore.firestore()
                            //'DocumentReference' tipinde bir değşiken oluşturulur ve başlangıçta 'nil' olarak atanır. Bu değişken, yeni oluşturulan belgeye bir referans sağlayacaktır.
                            var firestoreReference : DocumentReference? = nil
                            //'firestorePost' değişkeni, firestore'a eklenecek olan verilerin bir sözlük olarak tanımlandığı yerdir.
                            let firestorePost = ["imageUrl" : imageUrl!, "postedBy": Auth.auth().currentUser?.email!, "postComment": self.commentText.text!, "date": FieldValue.serverTimestamp(), "likes": 0] as [String : Any]
                            //'firestoreDatabase' üzerinde ki 'Posts' koleksiyonuna yeni bir belge eklemek için 'addDocument' metodu kullanılır.
                            //'firestorePost' yeni eklenecek verileri temsil eder.
                            firestoreReference = firestoreDatabase.collection("Posts").addDocument(data: firestorePost, completion: { (error) in
                                if error != nil{
                                    self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error")
                                }else{
                                    self.imageView.image = UIImage(named: "select.png")
                                    self.commentText.text = ""
                                    self.tabBarController?.selectedIndex = 0
                                }
                            })
                            }
                    }
                }
            }
        }
    }
    
    //Kullanıcının resim seçmek için tıkladığında çağrılan fonksiyon oluşturulur.
    @objc func chooseImage(){
        //'UIImagePickerController' sınıfından 'pickerController' adında bir nesne oluşturur.
        let pickerController = UIImagePickerController()
        //Delegesini self olarak ayarlar.
        pickerController.delegate = self
        //Kaynak türünü fotoğraf kitaplığı olarak belirler.
        pickerController.sourceType = .photoLibrary
        //Resim seçim ekranını açar.
        present(pickerController, animated: true, completion: nil)
    }

}
