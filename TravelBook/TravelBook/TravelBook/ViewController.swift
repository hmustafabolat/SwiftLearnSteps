//
//  ViewController.swift
//  TravelBook
//
//  Created by Musti on 1.07.2023.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UITextFieldDelegate {
    
    //Storyboard'da yer alan kullanıcı arabirim öğelerini kodda tanımladık ve IBOutlet olarak bağladık.
    @IBOutlet weak var nameText: UITextField!
    
    @IBOutlet weak var commentText: UITextField!
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var saveButton: UIButton!
    
    //Seçilen konumun koordinatlarını tutmak için atanan değişkenler.
    var chosenLatitude = Double()
    var chosenLongitude = Double()
    
    //Konum yöneticisi ve diğer değişkenleri tanımladık.
    var locationManager = CLLocationManager()
    var selectedTitle = ""
    var selectedTitleID: UUID?
    var annotationTitle = ""
    var annotationSubtitle = ""
    var annotationLatitude = Double()
    var annotationLongitude = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Delegate'leri ve delegeleri ayarladık
        nameText.delegate = self
        commentText.delegate = self
        mapView.delegate = self
        
        locationManager.delegate = self
        //En iyi ve en doğru konumu almak için kullanılır.
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //Sadece uygulamayı kullanırken veya her zaman konum izlenmesinin ayarlanması.
        locationManager.requestWhenInUseAuthorization()
        //Kullanıcının yerini almaya başlıyoruz.
        locationManager.startUpdatingLocation()
        
        
        //GestureRecognizer ekledik ve fonksiyonunu tanımladık.
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(gestureRecognizer:)))
        mapView.addGestureRecognizer(gestureRecognizer)
        gestureRecognizer.minimumPressDuration = 2

        //Klavyenin dokunma olaylarını kontrol ediyor.
        let gestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        mapView.addGestureRecognizer(gestureRecognizer2)

        //Eğer bir konum seçildiyse veritabanından detaylarını alıp haritaya ve metin alanlarına ekledik.
        if selectedTitle != ""{
            
            saveButton.isHidden = true
            
            //Core Data
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Places")
            let idString = selectedTitleID!.uuidString
            fetchRequest.predicate = NSPredicate(format: "id = %@", idString)
            fetchRequest.returnsObjectsAsFaults = false
            
            do{
                let results = try context.fetch(fetchRequest)
                if results.count > 0 {
                    for result in results as! [NSManagedObject]{
                        if let title = result.value(forKey: "title") as? String{
                            annotationTitle = title
                            if let subtitle = result.value(forKey: "subtitle") as? String{
                                annotationSubtitle = subtitle
                                if let latitude = result.value(forKey: "latitude") as? Double{
                                    annotationLatitude = latitude
                                    if let longitude = result.value(forKey: "longitude") as? Double{
                                        annotationLongitude = longitude
                                        
                                        let annotation = MKPointAnnotation()
                                        annotation.title = annotationTitle
                                        annotation.subtitle = annotationSubtitle
                                        let coordinate = CLLocationCoordinate2D(latitude: annotationLatitude, longitude: annotationLongitude)
                                        annotation.coordinate = coordinate
                                        mapView.addAnnotation(annotation)
                                        nameText.text = annotationTitle
                                        commentText.text = annotationSubtitle
                                        locationManager.stopUpdatingLocation()
                                        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                                        let region = MKCoordinateRegion(center: coordinate, span: span)
                                        mapView.setRegion(region, animated: true)
                                        
                                    }
                                }
                            }
                        }                        }
                }
            }catch {
                print("error")
            }
        }
        else{
            saveButton.isHidden = false
            saveButton.isEnabled = false
            nameText.text = ""
            commentText.text = ""
        }
    }
    
    @objc func chooseLocation(gestureRecognizer:UILongPressGestureRecognizer){
        
        //Eger GestureRecognizer başladıysa
        if gestureRecognizer.state == .began{
            //Tıklanan yeri aldık ve koordinata çevirdik.
            let touchedPoint = gestureRecognizer.location(in: self.mapView)
            let touchedCoordinates = self.mapView.convert(touchedPoint, toCoordinateFrom: self.mapView)
            
            //Koordinatları ayrı ayrı alıp oluşturduğumuz değişkenlere atadık.
            chosenLatitude = touchedCoordinates.latitude
            chosenLongitude = touchedCoordinates.longitude
            
            //Tanımladığımız değere koordinat verdik, başlık verdik, alt başlık verdik ve ekranda gösterdik.
            let annotation = MKPointAnnotation()
            annotation.coordinate = touchedCoordinates
            annotation.title = nameText.text
            annotation.subtitle = commentText.text
            self.mapView.addAnnotation(annotation)
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //Kendi lokasyonumuzu oluşturmak için kullanıyoruz.
        if selectedTitle == ""{
            let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
            
            //Harita da gösterilen genişlik ve yükseklik değeri yani bir nebze zoom seviyesi diyebiliriz.
            let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
                
            
            let region = MKCoordinateRegion(center: location, span: span)
            
            mapView.setRegion(region, animated: true)
        }
        else{
            
        }
    }
    
    @objc func hideKeyboard(){
        func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }

    }
    
    //Save butonunun durumunu kontrol eden fonksiyon. Eğer Field'lar boş işe aktif edilmeyecektir.
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let nameIsEmpty = nameText.text?.isEmpty ?? true
        let commentIsEmpty = commentText.text?.isEmpty ?? true
        
        saveButton.isEnabled = !(nameIsEmpty || commentIsEmpty)
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        //Sadece tıklanan yeri göstermek için böyle bir kontrol yazdık.
           if annotation is MKUserLocation {
               return nil
           }
           
           let reuseId = "myAnnotation"
           var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKMarkerAnnotationView
           
           if pinView == nil {
               pinView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
               //Baloncuğun içersinde ekstra bilgi göstermek için kullanılır.
               pinView?.canShowCallout = true
               //Baloncuk içerisinde ki ikonun rengini ayarlar.
               pinView?.tintColor = UIColor.red
               
               //Baloncuk içerisinde ki butonun yapılandırması.
               let button = UIButton(type: UIButton.ButtonType.detailDisclosure)
               //Baloncuğun sağ tarafında gösterilmesini sağlar.
               pinView?.rightCalloutAccessoryView = button
               
           } else {
               pinView?.annotation = annotation
           }
           
           
           
           return pinView
       }
    
    
    //Bu fonksiyonun amacı oraya tıklandığını anlamak.
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            if selectedTitle != "" {
                
                //Koordinatlar ve yerler arasında bağlantı kurmamızı sağlayan sınıf.
                let requestLocation = CLLocation(latitude: annotationLatitude, longitude: annotationLongitude)
                
                //Navigasyonu çalıştırmak için gerekli olan objeyi almak için kullanılır.
                CLGeocoder().reverseGeocodeLocation(requestLocation) { (placemarks, error) in
                    //closure
                    
                    if let placemark = placemarks {
                        if placemark.count > 0 {
                                          
                            let newPlacemark = MKPlacemark(placemark: placemark[0])
                            let item = MKMapItem(placemark: newPlacemark)
                            item.name = self.annotationTitle
                            //Navigasyonu hangi araç ile (yürüyerek, araba ile vs) kullanacağımızı ayarlıyoruz.
                            let launchOptions = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving]
                            //Haritayi açıp navigasyonu aktif edebiliriz artık
                            item.openInMaps(launchOptions: launchOptions)
                                          
                    }
                }
            }
        }
    }


    @IBAction func saveButtons(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newPlaces = NSEntityDescription.insertNewObject(forEntityName: "Places", into: context)
        
        newPlaces.setValue(nameText.text, forKey: "title")
        newPlaces.setValue(commentText.text, forKey: "subtitle")
        newPlaces.setValue(chosenLatitude, forKey: "latitude")
        newPlaces.setValue(chosenLongitude, forKey: "longitude")
        newPlaces.setValue(UUID(), forKey: "id")
        
        do{
            try context.save()
            print("Success")
        }catch{
            print("Error")
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("newPlace"), object: nil)
        navigationController?.popViewController(animated: true)
    }
    
    
    
    
}

