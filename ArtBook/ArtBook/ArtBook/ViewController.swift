//
//  ViewController.swift
//  ArtBook
//
//  Created by Musti on 23.06.2023.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    var nameArray = [String]() //Sanat eserinin adını tutacak dizi.
    var idArray = [UUID]() //Sanat eserinin id'sini tutacak dizi.
    var selectedPainting = "" //Seçilen sanat eserinin adını tutacak değişken.
    var selectedPaintingId: UUID? // Seçilen sanat eserinin ID'sini tutacak değişken.
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //Ekranın üstünde ki sağ üst köşede ekleme butonu oluşturur.
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        
        //Kaydedilen verileri almak için getData fonksiyonu çağırılır.
        getData()
    }
    
    //Yeni veri eklendiğinde kaydedilen verileri tekrar yüklemek için kullanılır.
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name(rawValue: "newData"), object: nil)
    }
    
    //Core Data'dan verileri almak için kullanılan fonksiyon.
    @objc func getData(){
        
        //Getirilen verileri tekrar tekrar getirmez sadece bir kere getirir ve orda tutar.
        nameArray.removeAll(keepingCapacity: false)
        idArray.removeAll(keepingCapacity: false)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        //Painting adında ki entity'den name ve id'yi çeker.
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(fetchRequest)
            
            if results.count > 0{
                for result in results as! [NSManagedObject] {
                    if let name = result.value(forKey: "name") as? String {
                        self.nameArray.append(name)
                    }
                    if let id = result.value(forKey: "id") as? UUID {
                        self.idArray.append(id)
                    }
                    self.tableView.reloadData()
                }
            }
            
           
        
        }
        catch {
            print("error")
        }
        
    }
    

    @objc func addButtonClicked(){
        //Artı butonuna tıklayınca gidilecek sayfa.
        selectedPainting = ""
        performSegue(withIdentifier: "DetailVc", sender: nil)
    }

    //Table görünümünde satır sayısını belirleyen fonksiyon.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    //Tablo görünümünde hücreleri belirleyen fonksiyon.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = nameArray[indexPath.row]
        return cell
    }
    
    //Geçiş yapılacak sayfaya veri aktarmak için hazırlık yapan fonksiyondur.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailVc"{
            //Seçilen satırda ki bilgileri yeni sayfaya aktardık.
            let destinationVc = segue.destination as! DetailViewController
            destinationVc.chosenPainting = selectedPainting
            destinationVc.chosenPaintingId = selectedPaintingId
        }
    }
    
    //Bir tablo hücresine tıklandığında çağrılan fonksiyondur.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Seçilen değerin adını ve id'sini değişkene aktardık diğer sayfa ile bağlantı kurarken kullanmak için.
        selectedPainting = nameArray[indexPath.row]
        selectedPaintingId = idArray[indexPath.row]
        performSegue(withIdentifier: "DetailVc", sender: nil)
    }
    
    //Bir tablo hücresinin düzenleme stilinde silinmesi durumunda çağrılan fonksiyondur.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
            
            let idString = idArray[indexPath.row].uuidString
            
            fetchRequest.predicate = NSPredicate(format: "id = %@", idString)
            
            fetchRequest.returnsObjectsAsFaults = false
            
            do{
                let results = try context.fetch(fetchRequest)
                if results.count > 0 {
                    for result in results as! [NSManagedObject]{
                        if let id = result.value(forKey: "id") as? UUID{
                            if id == idArray[indexPath.row]{
                                //Sanat eserini Core Data'dan sil ve tabloyu güncelle.
                                context.delete(result)
                                nameArray.remove(at: indexPath.row)
                                idArray.remove(at: indexPath.row)
                                self.tableView.reloadData()
                                
                                do{
                                    try context.save()
                                }
                                catch{
                                    print("Error")
                                }
                                break
                            }
                        }
                    }
                }
                
            }catch{
                print("error")
            }
            
            
            
        }
    }
}

