//
//  DetailViewController.swift
//  SimpsonBook
//
//  Created by Musti on 19.06.2023.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var detailImageView: UIImageView!
    
    
    @IBOutlet weak var simpsonNameLabel: UILabel!
    
    
    
    @IBOutlet weak var simpsonJobLabel: UILabel!
    
    var selectedSimpson : Simpson?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        simpsonNameLabel.text = selectedSimpson?.name
        simpsonJobLabel.text = selectedSimpson?.job
        detailImageView.image = selectedSimpson?.image

        
    }
    

    

}
