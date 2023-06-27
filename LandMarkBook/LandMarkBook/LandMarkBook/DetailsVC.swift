//
//  DetailsVC.swift
//  LandMarkBook
//
//  Created by Musti on 18.06.2023.
//

import UIKit

class DetailsVC: UIViewController {

    @IBOutlet weak var landmarkLabel: UILabel!
    @IBOutlet weak var landmarkImage: UIImageView!
    
    var selectedLandmarkName = ""
    var selectedLandmarkSurname = ""
    var selectedLandmarkImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        landmarkLabel.text = selectedLandmarkName + " " + selectedLandmarkSurname
        
        landmarkImage.image = selectedLandmarkImage

       
    }
    

    
}
