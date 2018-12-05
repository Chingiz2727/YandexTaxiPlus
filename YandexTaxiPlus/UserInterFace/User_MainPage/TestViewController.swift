//
//  TestViewController.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 11/13/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import GoogleMaps
import Toast_Swift
import SideMenu
import UserNotifications
class TestViewController:UIViewController,CLLocationManagerDelegate,GMSMapViewDelegate,secondplaceclicked,secondplacedelegate,firstplacebuttonclicked,firstplacedelegate,commentAndDate,ordermaked,orderCanceled,Rated,UIGestureRecognizerDelegate,payByCard {
    func PayingByCard(url: String) {
        let card = PayByCardViewController()
        card.url = url
        self.navigationController?.pushViewController(card, animated: true)
    }
    
    func rated() {
        addview()
        map.clear()
        first_name = "Откуда"
        second_name = "Куда"
    }
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
    var menuimage : UIImageView = UIImageView()

    func index(index:IndexPath) {
        print(index)
        PushFromMain.push(index: index)
    }
    
    func firstadded() {
        marker1.position = CLLocationCoordinate2D(latitude: first_lat, longitude: first_long)
        marker1.icon = self.imageWithImage(image: UIImage(named: "icon_point_a")!, scaledToSize: CGSize(width: 40, height: 40))
        marker1.map = map
    }
    
    func secondadded() {
        marker2.position = CLLocationCoordinate2D(latitude: second_lat, longitude: second_long)
        marker2.icon = self.imageWithImage(image: UIImage(named: "icon_point_b")!, scaledToSize: CGSize(width: 40, height: 40))
        print("added")
        marker2.map = map
    }
    
    func Canceled() {
        map.clear()
        first_name = "Откуда"
        second_name = "Куда"
        first_lat = 0
        first_long = 0
        second_lat = 0
        second_long = 0
        addview()
    }
    
    func OrderMaked() {
        remove()
        first_clicked = false
        second_clicked = false
        
        Route.Draw(startlat: first_lat, startlong: first_long, endlat: second_lat, englong: second_long, map: map)
        Cancel.addcancel(view: self.view)
    }
    
    var Cancel = CancelView()
    func remove() {
        FromButton.removeFromSuperview()
        toButton.removeFromSuperview()
        Send.removeFromSuperview()
    }
    var map : GMSMapView = GMSMapView()
    var setting_view = SettingColectionView()
    func getdata(coment: String, data: String){
        print("typesis")
        print(type)
        setting_view.datareload(first_long: String(first_long), first_lat: String(first_lat), second_lat: String(second_lat), second_long: String(second_long),comment: coment,date:data, type: type)
        setting_view.Ordered = self
        setting_view.paybaycard = self
    }
    
    var type : String = "1"
    let marker1 = GMSMarker()
    let marker2 = GMSMarker()
    var myloc_lat : Double?
    var myloc_long: Double?
    var first_lat: Double = 0.0
    var first_long: Double = 0.0
    var first_name: String = "Откуда" {
        didSet {
            FromButton.setTitle(first_name, for: .normal)
        }
    }
    
    var first_clicked: Bool = false
    var second_lat: Double = 0.0
    var second_long: Double = 0.0
    var second_name: String = "Куда" {
        didSet {
            toButton.setTitle(second_name, for: .normal)
        }
    }
    var onOnder = OnOrder()
    var second_clicked: Bool = false
    var manager = CLLocationManager()
    var FromButton : MainButton = MainButton()
    var toButton : MainButton = MainButton()
    var Send : MainButton = MainButton()
    var Rating = RateDriver()
    func addview() {
        self.view.addSubview(Send)
        self.view.addSubview(FromButton)
        self.view.addSubview(toButton)
        
        FromButton.setAnchor(top: nil, left: self.view.leftAnchor, bottom: toButton.topAnchor, right: self.view.rightAnchor, paddingTop: 0, paddingLeft: 40, paddingBottom: 10, paddingRight: 40, width: 50, height: 50)
        toButton.setAnchor(top: nil, left: self.view.leftAnchor, bottom: Send.topAnchor, right: self.view.rightAnchor, paddingTop: 0, paddingLeft: 40, paddingBottom: 10, paddingRight: 40, width: 50, height: 50)
        Send.setAnchor(top: nil, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, paddingTop: 0, paddingLeft: 40, paddingBottom: 40, paddingRight: 40, width: 50, height: 50)
        FromButton.initialize()
        toButton.initialize()
        Send.initialize()
        FromButton.addTarget(self, action: #selector(ChoosePlace(sender:)), for: .touchUpInside)
        toButton.addTarget(self, action: #selector(ChoosePlace(sender:)), for: .touchUpInside)
        Send.addTarget(self, action: #selector(PushDetail), for: .touchUpInside)
        FromButton.backgroundColor = UIColor.white
        toButton.backgroundColor = UIColor.white
        FromButton.Title(title: first_name)
        toButton.Title(title: second_name)
        toButton.setTitleColor(maincolor, for: .normal)
        FromButton.setTitleColor(maincolor, for: .normal)
        FromButton.tag = 0
        toButton.tag = 1
        Send.setTitle("Заказать", for: .normal)
        Send.setTitleColor(UIColor.white, for: .normal)
    }
    
    
    @objc func ChoosePlace(sender:UIButton) {
        let place = ChoosePlaceTableViewController()
        let my_places = MyPlacesTableViewController()
        place.tag = sender.tag
        switch  place.tag {
        case 0:
            second_clicked = false
            my_places.first_delegate = self
            place.firstdelegate = self
            place.firtsclick = self
        case 1:
            first_clicked = false
            my_places.second_delegate = self
            place.secondplacedelegate = self
            place.secondcicked = self
        default:
            break
        }
        self.navigationController!.pushViewController(place, animated: true)
    }
    
    @objc func PushDetail() {
        print(first_lat)
        print(second_long)
        if first_lat != 0 && second_long != 0 {
            let sets = SettingTableViewController()
            sets.delegate = self
            self.navigationController!.pushViewController(sets, animated: true)
        }
        else  {
            view.makeToast("Заполните все поля")
        }

    }
    
   @objc func Detection() {
        let camera = GMSCameraPosition.camera(withLatitude: (map.myLocation?.coordinate.latitude)!, longitude: (map.myLocation?.coordinate.longitude)!, zoom: 16.0)
        map.camera = camera
        //                setupLocationManager()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(map)
        view.addSubview(menuimage)
        view.addSubview(Detect)
        if APItoken.getColorType() == 1 {
            do {
                map.mapStyle = try! GMSMapStyle(jsonString: MapStyle().kMapStyle)
            } catch {
                NSLog("One or more of the map styles failed to load. \(error)")
            }
        }
         Detect.setAnchor(top: nil, left: nil, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 280, paddingRight: 35, width: 35, height: 35)
        Detect.addTarget(self, action: #selector(Detection), for: .touchUpInside)
        GetAvatar.get { (str) in
            print("avatar")
            print(str)
        }
   
        Cancel.can = self
        menuimage.setAnchor(top: self.view.topAnchor, left: self.view.leftAnchor, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 30, paddingBottom: 0, paddingRight: 0, width: 35, height: 25)
        menuimage.image = UIImage(named: "icon_menu")
        menuimage.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        menuimage.addGestureRecognizer(tapGestureRecognizer)
        map.isMyLocationEnabled = true
        map.setAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        let menuLeft = UISideMenuNavigationController(rootViewController: MenuTableViewController())
        menuLeft.sideMenuManager.menuPresentMode = .menuSlideIn
        menuLeft.sideMenuManager.menuWidth = view.frame.width - view.frame.width*0.2
        SideMenuManager.default.menuLeftNavigationController = menuLeft
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: menuimage)
        SideMenuManager.default.menuAddPanGestureToPresent(toView: menuimage)
        SideMenuManager.default.menuFadeStatusBar = false
        SideMenuManager.default.menuPushStyle = .subMenu
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
        map.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(drivercame(notification:)), name: NSNotification.Name(rawValue: "201"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(drivercame(notification:)), name: NSNotification.Name(rawValue: "401"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(drivercame(notification:)), name: NSNotification.Name(rawValue: "501"), object: nil)
   
    }
    
    
    
    func setup() {
        if map.myLocation?.coordinate.longitude != nil {
            Geocoding.LocationName(lat: "\(String(describing: map.myLocation?.coordinate.latitude))", long: "\(String(describing: map.myLocation?.coordinate.longitude))") { (first_loc) in
                let first_place2 = first_loc?.results?[0].addressComponents?[0].shortName ?? ""
                let first_place3 = first_loc?.results?[0].addressComponents?[1].shortName ?? ""
                let finist = "\(first_place3) \(first_place2)"
                self.first_lat = (self.map.myLocation?.coordinate.latitude)!
                self.first_long = (self.map.myLocation?.coordinate.longitude)!
                self.first_name = finist
            }
        }
    }
    
    @objc func drivercame(notification:NSNotification) {
        let content = UNMutableNotificationContent()
        let ord_id = notification.userInfo![AnyHashable("order_id")] as? String
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)

        switch notification.name.rawValue {
        case "201":
            self.onOnder.addview(nav: self.navigationController!)
            content.title = "Taxi +"
            content.body = "Водитель принял ваш заказ"
            content.sound  = UNNotificationSound.default
            let request = UNNotificationRequest(identifier: "201", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            Cancel.cancel.removeFromSuperview()
            view.makeToast("Водитель принял ваш Заказ")
        case "401":
            content.title = "Taxi +"
            content.body = "Водитель подъехал"
            content.sound  = UNNotificationSound.default
            view.makeToast("Водитель подъехал")
            let request = UNNotificationRequest(identifier: "401", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        case "501":
            content.title = "Taxi +"
            content.body = "Оцените водителя"
            content.sound  = UNNotificationSound.default
            let request = UNNotificationRequest(identifier: "501", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)

            onOnder.remove()
            Rating.addRating()
            Rating.rat = self
        default:
            break
        }

    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {        navigationController?.navigationBar.isHidden = true
            navigationController?.interactivePopGestureRecognizer?.isEnabled = false

        
        sendPushId.send { (info, order) in
            switch info.status! {
            case 0:
                self.addview()
            case 1:
                self.Cancel.can = self
                self.Cancel.addcancel(view: self.view)
            case 2:
                self.onOnder.addview(nav: self.navigationController!)
            case 3:
                self.onOnder.addview(nav: self.navigationController!)
            case 4:
                self.onOnder.addview(nav: self.navigationController!)

            default:
                break
            }
        }
      
   
    }
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        present(SideMenuManager.defaultManager.menuLeftNavigationController!,animated: true,completion: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 13)
        self.map.animate(to: camera)
        
        Geocoding.LocationName(lat: String(describing: (location?.coordinate.latitude)!), long: String(describing: (location?.coordinate.longitude)!)) { (first_loc) in
            let first_place2 = first_loc!.results![0].addressComponents![0].shortName ?? ""
            let first_place3 = first_loc!.results![0].addressComponents![1].shortName ?? ""
            let finist = "\(first_place3) \(first_place2)"
            self.first_long = (location?.coordinate.longitude)!
            self.first_lat = (location?.coordinate.latitude)!
            self.first_name = finist
        }
        self.manager.stopUpdatingLocation()
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D){
        if first_clicked == true {
            marker1.map = nil
            marker1.position = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
            marker1.icon = self.imageWithImage(image: UIImage(named: "icon_point_a")!, scaledToSize: CGSize(width: 20, height: 20))
            marker1.map = map
            first_lat = coordinate.latitude
            first_long = coordinate.longitude
           
        }
        if second_clicked == true {
            marker2.map = nil
            marker2.position = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
            marker2.icon = self.imageWithImage(image: UIImage(named: "icon_point_b")!, scaledToSize: CGSize(width: 20, height: 20))
            marker2.map = map
            second_lat = coordinate.latitude
            second_long = coordinate.longitude
     
        }
    }
    
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }

    

    
    }
