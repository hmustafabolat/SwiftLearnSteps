//
//  PlayerDetailVc.swift
//  PlayerBook
//
//  Created by Musti on 27.06.2023.
//

import UIKit
import CoreData

class PlayerDetailVc: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //Görünümde yer alan öğelerin tanımlanması ve bağlantıları.
    @IBOutlet weak var imageView: UIImageView!
   
    @IBOutlet weak var nameText: UITextField!
    
    @IBOutlet weak var teamText: UITextField!
    
    @IBOutlet weak var valueText: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    
    //Seçilen oyuncu ve oyuncuID'si için atanan değişkenler.
    var chosenPlayer = ""
    var chosenPlayerId : UUID?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //CoreData'dan çekilen verinin boş olmadığı durumlarda kullanılacak işlem.
        if chosenPlayer != ""{
            
            //Eğer eşit değilse saveButton aktif olacak.
            saveButton.isHidden = true
            
            //Veri çekme işlemleri
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Players")
            let idString = chosenPlayerId?.uuidString
            fetchRequest.predicate = NSPredicate(format: "id = %@", idString!)
            fetchRequest.returnsObjectsAsFaults = false
            
            do{
                let results = try context.fetch(fetchRequest)
                if results.count > 0{
                    for result in results as! [NSManagedObject]{
                        if let name = result.value(forKey: "ad") as? String{
                            nameText.text = name
                        }
                        if let team = result.value(forKey: "team") as? String{
                            teamText.text = team
                        }
                        if let value = result.value(forKey: "value") as? Int{
                            valueText.text = String(value)
                        }
                        if let imageData = result.value(forKey: "image") as? Data{
                            let image = UIImage(data: imageData)
                            imageView.image = image
                        }
                    }
                }

            }
            catch{
                print("Error")
            }
        }
        //CoreData'dan gelen veriler eğer boş ise yapılacak işlemler.
        else{
            saveButton.isHidden = false
            saveButton.isEnabled = false
            
            //Yeni bir oyuncu eklenir ve boş bir forma sahip olunur.
            nameText.text = ""
            teamText.text = ""
            valueText.text = ""
        }
        
        //Boş bir alana tıklayınca klavyeyi gizleyen fonksiyondur.
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        
        //Resim üzerine dokunma işlemini aktif ettik.
        imageView.isUserInteractionEnabled = true
        
        //Resme dokununca hangi fonksiyonun çalışacağını belirttik.
        let imageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(imageTapRecognizer)
        print("Seçildi")
        
        
    }
    
    //Seçilecek resmi belirten fonksiyon
    @objc func selectImage(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    //Resim seçmek için kullanılan fonksiyon.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        saveButton.isEnabled = true
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //Klavyeyi gizlemek için kullanılan fonksiyon.
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    
    //Kaydet butonunda her değişkeni kendi karşığı olan yere kaydeden fonksiyon.
    @IBAction func saveButtonClicked(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newPlayers = NSEntityDescription.insertNewObject(forEntityName: "Players", into: context)
        newPlayers.setValue(nameText.text, forKey: "ad")
        newPlayers.setValue(teamText.text, forKey: "team")
        if let value = Int(valueText.text!){
            newPlayers.setValue(value, forKey: "value")
        }
        let data = imageView.image!.jpegData(compressionQuality: 0.5)
        
        newPlayers.setValue(data, forKey: "image")
        
        newPlayers.setValue(UUID(), forKey: "id")
        
        do{
            try context.save()
            print("Success")
        }catch{
            print("Error")
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("newData"), object: nil)
        
        //Save tuşuna basınca otomatik olarak sayfayı bir geriye atar.
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
}
