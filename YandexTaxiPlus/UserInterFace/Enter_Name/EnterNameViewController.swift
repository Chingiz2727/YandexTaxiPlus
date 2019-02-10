//
//  EnterNameViewController.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 12.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import Toast_Swift
class EnterNameViewController: UIViewController,FromCitiesTableViewControllerDelegate,CLLocationManagerDelegate {
    var updateView : EnterNameView!
    var latitude : Double?
    var longitude : Double?
    var id_city : String? = ""
    var region : String?
    var name : String?
    var cname : String? = "Выберите город" {
        didSet {
            updateView.City.setTitle(cname!, for: .normal)
        }
    }
    var locationManager = CLLocationManager()

    func CityFromData(id: String, region_id: String, name: String, cname: String) {
        self.id_city = id
        self.region = region_id
        self.name = name
        self.cname = cname
    }
    
    
    var phone:String?
    var window: UIWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupview()
      setupLocationManager()
        updateView.City.addTarget(self, action: #selector(gotoCity), for: .touchUpInside)
        updateView.loginAction = check
        navigationController?.isNavigationBarHidden = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if CLLocationManager.locationServicesEnabled() {
            print("enabled")
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        else {
            print("notenabled")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        self.latitude = locValue.latitude
        self.longitude = locValue.longitude
        print(locValue)
        print("selfplace")
        manager.stopUpdatingLocation()
    }
    
    func setupview()
    {   let mainView = EnterNameView(frame: self.view.frame)
        self.updateView = mainView
        view.addSubview(mainView)
        view.backgroundColor = UIColor.white
    }
    func goToMain(){
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController.init(rootViewController: TestViewController())
    }
    
    func check() {
        if latitude != nil {
            accessing()
        }
        else {
            let alertController = UIAlertController(title: "Подключите передачу геоданных", message: "Для использования приложения нужно включить передачу геоданных", preferredStyle: UIAlertController.Style.alert)
            
            let okAction = UIAlertAction(title: "Настройки", style: .default, handler: {(cAlertAction) in
                //Redirect to Settings app
                UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
            })
            
            let cancelAction = UIAlertAction(title: "Отменить", style: UIAlertAction.Style.cancel)
            alertController.addAction(cancelAction)
            
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @objc func  gotoCity() {
        let city = CitiesTableViewController()
        city.tag = 0
        city.delegateFrom = self
        navigationController?.present(city, animated: true, completion: nil)
    }
    func accessing(){
        var name = updateView.PhoneField.text
        let url = baseurl + "/sign-up/"
        let url2 = baseurl + "/set-city/"
        name = name?.replacingOccurrences(of: " ", with: "")
        let parametr = [
            "phone":phone!,
            "name":name!,
            "latitude":latitude!,
            "longitude":longitude!
            ] as [String : Any]
        if id_city! == "" || name == "" {
            view.makeToast("Заполните все поля")
        }
  
        else {
            Alamofire.request(url, method: .post, parameters: parametr, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                if response.data != nil {
                    switch response.result {
                    case.failure(let err):
                        print(err)
                    case.success(let val):
                        var json = JSON(val)
                        let state =  json["state"].stringValue
                        print(json)
                        if state == "success" {
                            let token = json["token"].string
                            let param2 = ["token":token!,
                                          "city_id":self.id_city!]
                            Alamofire.request(url2, method: .post, parameters: param2, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (cresp) in
                                if cresp.data != nil {
                                    switch cresp.result {
                                    case.failure(let error):
                                        print(error)
                                    case.success(let val2):
                                        let js = JSON(val2)
                                        print(js)
                                        APItoken.saveapitoken(token: token!)
                                        self.goToMain()
                                    }
                                }
                            })
                        }
                    
                        
                    }
                }
        }
       
        }
    }
    func setupLocationManager(){
        self.locationManager.requestAlwaysAuthorization()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        self.locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
