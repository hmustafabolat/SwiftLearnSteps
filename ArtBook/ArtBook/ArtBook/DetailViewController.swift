//
//  DetailViewController.swift
//  ArtBook
//
//  Created by Musti on 24.06.2023.
//

import UIKit
import CoreData

class DetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //Görünümde yer alan ögelerin bağlantıları.
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var nameText: UITextField!
    
    
    @IBOutlet weak var artistText: UITextField!
    
    
    @IBOutlet weak var yearText: UITextField!
    
    
    @IBOutlet weak var saveButton: UIButton!
    
    
    //Seçilen sanat eseri ve ID'si için değişkenler oluşturduk.
    var chosenPainting = ""
    var chosenPaintingId : UUID?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Core Data'dan gelen veri boş değilse yapılacak işlemler.
        if chosenPainting != "" {
            
            //Eğer eşit değilse save butonu aktif olmayacaktır ve gizlenir.
            saveButton.isHidden = true
           
            //Veri çekme işlemi.
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
            let idString = chosenPaintingId?.uuidString
            fetchRequest.predicate = NSPredicate(format: "id = %@", idString!)
            fetchRequest.returnsObjectsAsFaults = false
            
            do {
                let results = try context.fetch(fetchRequest)
                
                if results.count > 0 {
                    for result in results as! [NSManagedObject]{
                        if let name = result.value(forKey: "name") as? String{
                            nameText.text = name
                        }
                        if let artist = result.value(forKey: "artist") as? String{
                            artistText.text = artist
                        }
                        if let year = result.value(forKey: "year") as? Int{
                            yearText.text = String(year)
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
            
            
        }else{
            //Core Data'dan gelen veriler boş ise yapılacak işlemler.
            saveButton.isHidden = false
            saveButton.isEnabled = false
            
            //Yeni bir sanat eseri ekleniyor, boş bir forma sahip olunur.
            nameText.text = ""
            artistText.text = ""
            yearText.text = ""
            
        }

        
        //Recognizers
        
        //Klavyeyi boş bir alana tıklayınca yok etmek için kullanılan yapı.
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        
        //Dokunma işlemini aktif ettik
        imageView.isUserInteractionEnabled = true
        //Resme dokununca hangi fonksiyonunun çalışacağını belirttik.
        let imageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(imageTapRecognizer)
        
    }
    
    //Seçilecek resmi belirten fonksiyon.
    @objc func selectImage(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    //Resim seçmek için kullanılan fonksiyon.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        imageView.image = info[.originalImage] as? UIImage
        saveButton.isEnabled = true
        self.dismiss(animated: true, completion: nil)
        
        
    
    }
    
    //Klavye gizlemek için kullanılan fonksiyon.
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    
    //Save butonuna tıklayınca verilerin kaydedilmesini sağlayan fonksiyon.
    @IBAction func saveButtonClicked(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newPainting = NSEntityDescription.insertNewObject(forEntityName: "Paintings", into: context)
        
        //Attributes
        newPainting.setValue(nameText.text, forKey: "name")
        newPainting.setValue(artistText.text, forKey: "artist")
        if let year = Int(yearText.text!){
            newPainting.setValue(year, forKey: "year")
        }
        newPainting.setValue(UUID(), forKey: "id")
        
        let data = imageView.image!.jpegData(compressionQuality: 0.5)
        
        newPainting.setValue(data, forKey: "image")
        
        do{
            try context.save()
            print("Success")
        }catch{
            print("error")
        }
        
        //Kaydedilen veriyi newData adında bir bildirim olarak gönderir.
        NotificationCenter.default.post(name: NSNotification.Name("newData"), object: nil)
        
        //Save tuşuna basınca otomatik olarak bir geri sayfaya atar.
        self.navigationController?.popViewController(animated: true)
    }
    
    

}
