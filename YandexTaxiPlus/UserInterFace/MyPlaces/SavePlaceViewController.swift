//
//  SavePlaceViewController.swift
//  newtaxi
//
//  Created by Чингиз on 28.08.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import GooglePlacePicker
import Toast_Swift
class SavePlaceViewController: UIViewController,GMSMapViewDelegate,CLLocationManagerDelegate,UITextFieldDelegate {
    var lat : CLLocationDegrees!
    var lang : CLLocationDegrees!
    var name : String?
    var manager = CLLocationManager()

  @objc  func send() {
        if saveView.name.text! == "" && lang == nil {
            self.view.makeToast("Заполните все поля")
        }
        else
        {
            SavePlace.save(name: saveView.name.text!, lat: lat, long: lang, token: APItoken.getToken()!)
            self.navigationController?.popViewController(animated: true)

        }
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 13)
        self.saveView.map.animate(to: camera)
        self.manager.stopUpdatingLocation()
    }
    
    var saveView : SavePlaceView!
    
    func setupview()
    {   let mainView = SavePlaceView(frame: self.view.frame)
        self.saveView = mainView
        view.addSubview(mainView)
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupview()
        UIColourScheme.instance.set(for:self)
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
        name = saveView.name.text
        saveView.map.delegate = self
        saveView.saveAction = send
        saveView.savebutton.addTarget(self, action: #selector(send), for: .touchUpInside)
        }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        mapView.clear()
        let position = CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude)
        let marker = GMSMarker(position: position)
        self.lat = coordinate.latitude
        self.lang = coordinate.longitude
        marker.map = saveView.map
    }

}
