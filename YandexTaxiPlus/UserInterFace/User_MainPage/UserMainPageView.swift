//
//  UserMainPageView.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 12/16/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit
import GoogleMaps

class ButtonView: UIView {
    var FromButton : MainButton = MainButton()
    var toButton : MainButton = MainButton()
    var Send : MainButton = MainButton()

    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(Send)
        addSubview(FromButton)
        addSubview(toButton)
        addview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addview() {
        
        FromButton.setAnchor(top: nil, left: leftAnchor, bottom: toButton.topAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, width: 50, height: 50)
        toButton.setAnchor(top: nil, left: leftAnchor, bottom: Send.topAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, width: 50, height: 50)
        Send.setAnchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 40, paddingRight: 0, width: 50, height: 50)
        FromButton.initialize()
        toButton.initialize()
        Send.initialize()
        FromButton.setTitle("Откуда?", for: .normal)
        FromButton.backgroundColor = UIColor.white
        toButton.setTitle("Куда?", for: .normal)
        toButton.backgroundColor = UIColor.white
        toButton.setTitleColor(maincolor, for: .normal)
        FromButton.setTitleColor(maincolor, for: .normal)
        FromButton.tag = 0
        toButton.tag = 1
        Send.setTitle("Заказать", for: .normal)
        Send.setTitleColor(UIColor.white, for: .normal)
    }
}



class MapView : UIView {
    
    var map : GMSMapView = GMSMapView()
    var menuimage : UIImageView = UIImageView()

    let Detect : UIButton = {
        let next = UIButton()
        next.backgroundColor = maincolor
        next.layer.cornerRadius = 18.0
        next.layer.shadowRadius = 1.0
        next.layer.shadowColor = UIColor.black.cgColor
        next.layer.shadowOffset = CGSize(width: 1, height: 1)
        next.layer.shadowOpacity = 0.4
        next.setImage(UIImage(named: "location-marker"), for: .normal)
        next.imageView?.contentMode = .scaleAspectFit
        next.addTarget(self, action: #selector(Detection), for: .touchUpInside)
        return next
    }()
    func check(complition:@escaping(_ success:Bool)->()) {
      
        // Here you can check whether you have allowed the permission or not.
        if CLLocationManager.locationServicesEnabled()
        {
            switch(CLLocationManager.authorizationStatus())
            {
            case .authorizedAlways, .authorizedWhenInUse:
                
                print("Authorize.")
                complition(true)
                break
                
            case .notDetermined:
                
                print("Not determined.")
                complition(false)
                
                break
                
            case .restricted:
                
                print("Restricted.")
                complition(true)
                
                break
                
            case .denied:
                
                complition(false)
            }
        }
        
    }
    
    func determine() {
        let alertController = UIAlertController(title: "Подключите передачу геоданных", message: "Для использования приложения нужно включить передачу геоданных", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Настройки", style: .default, handler: {(cAlertAction) in
            //Redirect to Settings app
            UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
        })
        let cancelAction = UIAlertAction(title: "Отменить", style: UIAlertAction.Style.cancel)
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        alertController.show()
//        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func Detection() {
        check { (success) in
            if success == true {
                let camera = GMSCameraPosition.camera(withLatitude: (self.map.myLocation?.coordinate.latitude)!, longitude: (self.map.myLocation?.coordinate.longitude)!, zoom: 16.0)
                self.map.camera = camera
            }
            else {
                self.determine()
            }
        }
       
    }
    public override init(frame: CGRect) {
        super.init(frame: frame)
        addview()
     
    }
    func addview() {
        self.addSubview(map)
        self.addSubview(Detect)
        self.addSubview(menuimage)
        menuimage.setAnchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 30, paddingBottom: 0, paddingRight: 0, width: 35, height: 25)
        menuimage.image = UIImage(named: "icon_menu")
        menuimage.isUserInteractionEnabled = true
        Detect.setAnchor(top: nil, left: nil, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 280, paddingRight: 35, width: 35, height: 35)
        map.setAnchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        map.isMyLocationEnabled = true
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
