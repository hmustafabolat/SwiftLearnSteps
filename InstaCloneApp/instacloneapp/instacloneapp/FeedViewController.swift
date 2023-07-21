//
//  FeedViewController.swift
//  instacloneapp
//
//  Created by Musti on 15.07.2023.
//

import UIKit
import Firebase
import SDWebImage

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var userEmailArray = [String]()
    var userCommentArray = [String]()
    var likeArray = [Int]()
    var userImageArray = [String]()
    var documentIdArray = [String]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
      
        getDataFromFirestore()
    }
    
    func getDataFromFirestore(){
        //Bu, Firestore veritabanı ile etkileşim için bir bağlantı noktası sağlar.
        let  firestoreDatabase = Firestore.firestore()
        //'Posts' koleksiyonunu dinlemek üzere bir snapshot listener eklenir. Bu 'Posts' koleksiyonunda herhangi bir değişiklik olduğunda otomatik olarak çalışacak bir snapshot lister'ı tanımlar
        firestoreDatabase.collection("Posts").order(by: "date", descending: true).addSnapshotListener { (snapshot,error) in
            if error != nil{
                print(error?.localizedDescription as Any)
            }else{
                //Veritabanı snapshot'ı boş değilse ve nil değilse, for in döngüsü oluşturulur.
                if snapshot?.isEmpty != true && snapshot != nil{
                    //Her bir ögeyi diziye eklemeden önce boşaltmamız gerekiyor.
                    self.userEmailArray.removeAll(keepingCapacity: false)
                    self.userCommentArray.removeAll(keepingCapacity: false)
                    self.likeArray.removeAll(keepingCapacity: false)
                    self.userImageArray.removeAll(keepingCapacity: false)
                    //'for document in snapshot!.documents' --> Bu her bir belgeye erişmek için snapshot'ın belgeleri üzerinde dönülmesini sağlar.
                    for document in snapshot!.documents{
                        //Belgenin kimlik bilgisi yazdırılır.
                        let documentID = document.documentID
                        self.documentIdArray.append(documentID)
                        //Belgeden 'postedBy' alanını alıp 'userEmailArray' dizisine ekler.
                        if let postedBy = document.get("postedBy") as? String{
                            self.userEmailArray.append(postedBy)
                        }
                        if let postComment = document.get("postComment") as? String{
                            self.userCommentArray.append(postComment)
                        }
                        if let likes = document.get("likes") as? Int {
                            self.likeArray.append(likes)
                        }
                        if let imageUrl = document.get("imageUrl") as? String {
                            self.userImageArray.append(imageUrl)
                        }
                    }
                    //Tablo görünümünün yeniden yüklemesini sağlayarak, güncellenmiş verilerle tablo oluşturulur.
                    self.tableView.reloadData()
                }
            }
            
        }
    }
    
    //'tableView(_:numberOfRowsInSection:' --> 'UITableViewDataSource' protokolünün bir metodu olup, tablo görünümündeki bölümlerin hücre sayısını belirtir.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return min(userEmailArray.count, userCommentArray.count, likeArray.count, userImageArray.count)
    }

    
    //'tableView(_:cellForRowAt:' --> 'UITableViewDataSource' protokolünün bir metodu olup, belirli bir indeksteki hücreyi döndürmek için kullanılır.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Burada 'tableView.dequeueReusableCell(withIdentifier:, for:)' metodu kullanılarak 'Cell' adında bir hücre örneği alınır.
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        //Alınan 'Cell' adında ki hücrelere bu hücrenin özellikleri atanır.
        cell.userEmailLabel.text = userEmailArray[indexPath.row]
        cell.likeLabel.text = String(likeArray[indexPath.row])
        cell.commentLabel.text = userCommentArray[indexPath.row]
        cell.userImageView.sd_setImage(with: URL(string: self.userImageArray[indexPath.row]))
        cell.documentIdLabel.text = documentIdArray[indexPath.row]
        //Son olarak oluşturulan hücre geri döndürülür.
        return cell
    }

}
