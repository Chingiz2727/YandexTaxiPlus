//
//  DriverMapViewController.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 30.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit
import MapKit
import NotificationCenter
import GoogleMaps
import GooglePlaces
import Alamofire
import SwiftyJSON
import SideMenu
class DriverMapViewController: UIViewController,CLLocationManagerDelegate,GMSMapViewDelegate {
    var MainMapView : DriverMapView!
    let customSideMenuManager = SideMenuManager()
    let manager = CLLocationManager()
    var latitude : Double?
    var longitude : Double?
    var order_id : String?
    var acceptOrder : UIButton =  UIButton()
    var callButton : UIButton =  UIButton()
    var chatButton : UIButton = UIButton()
    
    var but_title: String? = "Я приехал" {
        didSet {
            acceptOrder.setTitle(but_title!, for: .normal)
        }
    }
    var tag : Int? = 0 {
        didSet {
            acceptOrder.tag = tag!
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let sideMenuNavigationController = segue.destination as? UISideMenuNavigationController {
            sideMenuNavigationController.sideMenuManager = customSideMenuManager
        }
    }
    let info = InfoTable()
    func OpenMenu() {

        present(SideMenuManager.defaultManager.menuLeftNavigationController!,animated: true,completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        MainMapView.SearchAction = Detection
        NotificationCenter.default.addObserver(self, selector: #selector(self.accept(notifcation:)), name: NSNotification.Name(rawValue: "101"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.sendmyloc(notification:)), name: NSNotification.Name(rawValue: "1"), object: nil)
        setuplocation()
        // Do any additional setup after loading the view.
    }
    func Detection() {
                let camera = GMSCameraPosition.camera(withLatitude: (MainMapView.mapview.myLocation?.coordinate.latitude)!, longitude: (MainMapView.mapview.myLocation?.coordinate.longitude)!, zoom: 16.0)
                MainMapView.mapview.camera = camera
//                setupLocationManager()
    }

    override func viewWillAppear(_ animated: Bool) {
        manager.startUpdatingLocation()
        manager.requestWhenInUseAuthorization()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest

        MainMapView.MenuAction = OpenMenu
        customSideMenuManager.menuAddScreenEdgePanGesturesToPresent(toView: MainMapView.menuimage)
        customSideMenuManager.menuAddPanGestureToPresent(toView: MainMapView.menuimage)
        navigationController?.navigationBar.isHidden = true
        
    }
    
    func setup() {
        let mainView = DriverMapView(frame: self.view.frame)
        self.MainMapView = mainView
        self.view.addSubview(mainView)
    }
    func setuplocation(){
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
        manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        MainMapView.mapview.delegate = self
        MainMapView.mapview?.isMyLocationEnabled = true
        MainMapView.mapview.settings.zoomGestures = true
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        let mylocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        self.latitude = location.coordinate.latitude
        self.longitude = location.coordinate.longitude
        print(self.latitude)
        print(self.longitude)
        let defaults = UserDefaults.standard
        let token = defaults.string(forKey: "pushId")
        sendPushId.send(token: token!, long_a: longitude!, lat_a:latitude!) { (session, balance, status,order_status,order_id) in
            self.tag = order_status
            self.order_id = "\(order_id)"
            self.addbut()
            manager.stopUpdatingLocation()
            manager.stopMonitoringSignificantLocationChanges()
        }
        geo()
    }
    func geo(){
        Geocoding.LocationName(lat: "\(latitude!)", long: "\(longitude!)") { (place) in
        }
    }
    @objc func accept(notifcation:NSNotification) {
        let ord_id = notifcation.userInfo![AnyHashable("order_id")] as! String
        self.order_id = ord_id
        info.app(order_id: order_id!)
    }
    
    @objc func sendmyloc(notification:NSNotification) {
        let ord_id = notification.userInfo![AnyHashable("order_id")] as! String
        self.order_id = ord_id
        setuplocation()
        SendLocation.sendloc(longitude: String("\(self.longitude)"), latitude: String("\(self.latitude)"), order_id: ord_id)
    }
    
    
 
    func addbut() {
        if tag! > 1 {
            addbutton()
            switch tag {
            case 2:
                but_title = "Я приехал"
            case 3:
                but_title = "Начать поездку"
            case 4:
                but_title = "Завершить поездку"
            default:
                print("items")
            }
            
        }
       
       
    }
    
    func addbutton()
    {
        view.addSubview(acceptOrder)
        view.addSubview(callButton)
        view.addSubview(chatButton)
        acceptOrder.setAnchor(top: nil, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, paddingTop: 3, paddingLeft: 20, paddingBottom: 6, paddingRight: 20,width: 100,height: 50)
        callButton.setAnchor(top: nil, left: nil, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 70, paddingRight: 20, width: 50, height: 50)
        chatButton.setAnchor(top: nil, left: nil, bottom: callButton.topAnchor, right: self.view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 20, paddingRight: 20, width: 50, height: 50)
        callButton.layer.cornerRadius = callButton.bounds.size.width * 0.5
        chatButton.layer.cornerRadius = callButton.bounds.size.width * 0.5
        chatButton.backgroundColor = maincolor
        callButton.setImage(UIImage(named: "check"), for: .normal)
        chatButton.setImage(UIImage(named: "card"), for: .normal)
        acceptOrder.layer.cornerRadius = 10.0
        acceptOrder.backgroundColor = maincolor
                        acceptOrder.addTarget(self, action: #selector(DriverAction(sender:)), for: .touchUpInside)
        //            chatButton.addTarget(self, action: #selector(pushtochat), for: .touchUpInside)
    }
    @objc func DriverAction(sender:UIButton) {
        switch sender.tag {
        case 1:
            AcceptDriverOrder.accept(url: baseurl+"/accept-order/", order_id: self.order_id!) { (po) in
            }
        case 0:
            break
        case 2:
            AcceptDriverOrder.accept(url: baseurl+"/driver-came/", order_id: self.order_id!) { (po) in
                print(po)
                if po == "success" {
                    self.tag = 3
                    self.but_title = "Начать поездку"
                }
            }
        case 3:
            AcceptDriverOrder.accept(url: baseurl+"/go/", order_id: self.order_id!) { (po) in
                if po == "success" {
                    self.tag = 4
                    self.but_title = "Завершить поздку"
                }
            }
        case 4:
            AcceptDriverOrder.accept(url: baseurl+"/finish-order/", order_id: self.order_id!) { (po) in
                if po == "success" {
                    self.acceptOrder.removeFromSuperview()
                    self.callButton.removeFromSuperview()
                    self.chatButton.removeFromSuperview()
                }
            }
        default:
            break
        }
    }
    

}
