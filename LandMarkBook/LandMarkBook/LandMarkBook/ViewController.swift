//
//  ViewController.swift
//  LandMarkBook
//
//  Created by Musti on 18.06.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    var playerSurname = [String]()
    var playerName = [String]()
    var playerImage = [UIImage]()
   
    
    var chosenPlayerName = ""
    var chosenPlayerSurname = ""
    var chosenPlayerImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        playerName.append("Arda")
        playerName.append("İrfan Can")
        playerName.append("Michy")
        playerName.append("Ferdi")
        playerName.append("Luan")
        
       
        playerSurname.append("Güler")
        playerSurname.append("Kahveci")
        playerSurname.append("Batshuayi")
        playerSurname.append("Kadıoğlu")
        playerSurname.append("Peres")
        
        
        playerImage.append(UIImage(named: "arda")!)
        playerImage.append(UIImage(named: "irfancan")!)
        playerImage.append(UIImage(named: "michy")!)
        playerImage.append(UIImage(named: "ferdi")!)
        playerImage.append(UIImage(named: "luanperes")!)
        
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerSurname.count
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        //cell.textLabel?.text = "Test"         Bu artık kullanılmayacak.
        
        var content = cell.defaultContentConfiguration()
        content.text = playerSurname[indexPath.row]
        content.secondaryText = playerName[indexPath.row]
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenPlayerName = playerName[indexPath.row]
        chosenPlayerSurname = playerSurname[indexPath.row]
        chosenPlayerImage = playerImage[indexPath.row]
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC"{
            let destinatinVC = segue.destination as! DetailsVC
            
            destinatinVC.selectedLandmarkName = chosenPlayerName
            destinatinVC.selectedLandmarkSurname = chosenPlayerSurname
            destinatinVC.selectedLandmarkImage = chosenPlayerImage
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            self.playerName.remove(at: indexPath.row)
            self.playerSurname.remove(at: indexPath.row)
            self.playerImage.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

}

