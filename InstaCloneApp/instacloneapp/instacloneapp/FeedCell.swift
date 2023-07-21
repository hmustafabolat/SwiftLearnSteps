//
//  FeedCell.swift
//  instacloneapp
//
//  Created by Musti on 18.07.2023.
//

import UIKit
import Firebase

class FeedCell: UITableViewCell {

    @IBOutlet weak var userEmailLabel: UILabel!
    
    @IBOutlet weak var commentLabel: UITextField!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var likeLabel: UILabel!
    
    @IBOutlet weak var documentIdLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func likeButtonClicked(_ sender: Any) {
        //Bu, Firestore veritabanı ile etkileşim için bir bağlantı noktası sağlar.
        let fireStoreDatabase = Firestore.firestore()
        //'likeLabel' bir etiket olduğunu varsayarak, etiketin metin değerini tam sayıya dönüştürme işlemi gerçekleştirilir.
        //Eğer dönüşüm başarılıysa, 'likeCount' adında bir değişkene atanır ve işlemlere devam edilir.
        if let likeCount = Int(likeLabel.text!){
            //Beğeni sayısını 1 artırarak güncellemek için bir sözlük oluşturulur.
            let likeStore = ["likes": likeCount + 1] as [String : Any]
            //Firestore veritabanında 'Posts' koleksiyonunda ki belgeyi güncellemek için 'setData' kullanılır.
            //Burada ki 'merge:true' seçeneği belgenin diğer alanlarını değiştirmeden sadece 'likes' alanını güncellemek için kullanılır.
            fireStoreDatabase.collection("Posts").document(documentIdLabel.text!).setData(likeStore, merge: true)
        }
    }
    
}
