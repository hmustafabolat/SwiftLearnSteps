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

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var nameText: UITextField!
   
    @IBOutlet weak var commentText: UITextField!
    
    @IBOutlet weak var mapView: MKMapView!
    
    var chosenLatitude = Double()
    var chosenLongitude = Double()
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        gestureRecognizer.minimumPressDuration = 3
        mapView.addGestureRecognizer(gestureRecognizer)
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
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        
        //Harita da gösterilen genişlik ve yükseklik değeri yani bir nebze zoom seviyesi diyebiliriz.
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        
        
        let region = MKCoordinateRegion(center: location, span: span)
        
        mapView.setRegion(region, animated: true)
    }

    
    
    @IBAction func saveButton(_ sender: Any) {
        
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
    }
    
}

