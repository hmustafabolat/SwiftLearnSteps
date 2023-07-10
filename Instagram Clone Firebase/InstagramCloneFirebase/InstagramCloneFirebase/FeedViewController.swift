//
//  FeedViewController.swift
//  InstagramCloneFirebase
//
//  Created by Musti on 7.07.2023.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

   
  
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.userEmailLabel.text = "user@mail.com"
        cell.likeLabel.text = "0"
        cell.commentLabel.text = "Comment"
        cell.userImageView.image = UIImage(named: "tapToSelectIcon")
        return cell
    }

    
}
