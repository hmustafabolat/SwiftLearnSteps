//
//  ViewController.swift
//  PlayerBook
//
//  Created by Musti on 27.06.2023.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var nameArray = [String]()
    var idArray = [UUID]()
    var selectedPlayers = ""
    var selectedPlayerId: UUID?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name(rawValue: "newData"), object: nil)
    }
    
    @objc func getData(){
        nameArray.removeAll(keepingCapacity: false)
        idArray.removeAll(keepingCapacity: false)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Players")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(fetchRequest)
            
            if results.count > 0{
                for result in results as! [NSManagedObject] {
                    if let name = result.value(forKey: "ad") as? String {
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
        selectedPlayers = ""
        performSegue(withIdentifier: "PlayerVc", sender: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = nameArray[indexPath.row]
        return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PlayerVc"{
            let destinationVc = segue.destination as! PlayerDetailVc
            destinationVc.chosenPlayer = selectedPlayers
            destinationVc.chosenPlayerId = selectedPlayerId
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Seçilen değerin adını ve id'sini değişkene aktardık diğer sayfa ile bağlantı kurarken kullanmak için.
        selectedPlayers = nameArray[indexPath.row]
        selectedPlayerId = idArray[indexPath.row]
        performSegue(withIdentifier: "PlayerVc", sender: nil)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Players")
            
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

