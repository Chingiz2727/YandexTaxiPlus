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
import Presentr
class TestViewController:UIViewController,CLLocationManagerDelegate,GMSMapViewDelegate,commentAndDate,ordermaked,orderCanceled,Rated,UIGestureRecognizerDelegate,payByCard,UserMainPageProtocol {
 
    func first_added() {
        marker1.position = CLLocationCoordinate2D(latitude: from_lat!, longitude: from_long!)
        marker1.icon = self.imageWithImage(image: UIImage(named: "icon_point_a")!, scaledToSize: CGSize(width: 30, height: 30))
        marker1.map = mapview?.map
    }
    
    func second_added() {
        marker2.position = CLLocationCoordinate2D(latitude: to_lat!, longitude: to_long!)
        marker2.icon = self.imageWithImage(image: UIImage(named: "icon_point_b")!, scaledToSize: CGSize(width: 30, height: 30))
        marker2.map = mapview?.map
    }
    var orderbutton = UIButton()

    var userprotocol : UserMainPageProtocol?
    var first_clicked: Bool? = false
    var second_clicked: Bool? = false
    var from_lat: Double? = 0
    var from_long: Double? = 0
    var to_lat: Double? = 0
    var to_long: Double? = 0
    var order_id: Int? = 0
    var first_name: String? = "Откуда" {
        didSet {
            ButView?.FromButton.setTitle(first_name, for: .normal)
        }
    }
    var state_type: Int?
    
    func addbuttons() {
        switch state_type! {
        case 0 :
            addview()
        case 1:
            remove()
            self.Cancel.can = self
            Cancel.order_id = order_id
            self.Cancel.addcancel(view: self.view)
            Route.Draw(startlat: from_lat!, startlong: from_long!, endlat: to_lat!, englong: to_long!, map: (mapview?.map)!)
        default:
            remove()
            addbut()
            Route.Draw(startlat: from_lat!, startlong: from_long!, endlat: to_lat!, englong: to_long!, map: (mapview?.map)!)
            onOnder.order_id = order_id!
            
        }
    }
    
    func newOrders() {
        self.addview()
    }
    let presenter : Presentr = {
       
        let width = ModalSize.fluid(percentage: 1)
        let heigh = ModalSize.fluid(percentage: 1.4)
        
        let center = ModalCenterPosition.bottomCenter
        
        let customtype = PresentationType.custom(width: width, height: heigh, center: center)
        let customPresenter = Presentr(presentationType: customtype)
        customPresenter.backgroundOpacity  = 0
        return customPresenter
    }()


    
    var ButView : ButtonView?
    var mapview : MapView?
    
    func PayingByCard(url: String) {
        let card = PayByCardViewController()
        card.url = url
        self.navigationController?.pushViewController(card, animated: true)
    }
    
    func rated() {
        addview()
        mapview?.map.clear()
        first_name = "Откуда"
        second_name = "Куда"
    }
    
    func index(index:IndexPath) {
        PushFromMain.push(index: index)
    }
    
    
    func Canceled() {
        mapview?.map.clear()
        first_name = "Откуда"
        second_name = "Куда"
        addview()
    }
    
    func OrderMaked() {
        remove()
        first_clicked = false
        second_clicked = false
        Cancel.order_id = order_id
        Route.Draw(startlat: from_lat!, startlong: from_long!, endlat: to_lat!, englong: to_long!, map: (mapview?.map)!)
        Cancel.addcancel(view: self.view)
    }
    var sec_id: Int?
    var Cancel = CancelView()
    func remove() {
        ButView?.removeFromSuperview()
    }
    var setting_view = SettingColectionView()
    
    func getdata(coment: String, data: String){
        setting_view.datareload(first_long: String(from_long!), first_lat: String(from_lat!), second_lat: String(to_lat!), second_long: String(to_long!),comment: coment,date:data, type: type)
        setting_view.user = self
        setting_view.Ordered = self
        setting_view.paybaycard = self
    }
    
    var type : String = "1"
    var marker1 = GMSMarker()
    var marker2 = GMSMarker()
    var myloc_lat : Double?
    var myloc_long: Double?
    var second_name: String? = "Куда" {
        didSet {
            ButView?.toButton.setTitle(second_name, for: .normal)
        }
    }
    
    var onOnder = OrderDetailTableViewController()
    var manager = CLLocationManager()
    var Rating = RateDriver()
    func addview() {
        let bottomMargin = CGFloat(0) //Space between button and bottom of the screen
        let new = ButtonView(frame: CGRect(x: 0, y: 0, width: view.frame.width-100, height: 200))
        new.center = CGPoint(x: (parent?.view.bounds.size.width)! / 2, y: (parent?.view.bounds.size.height)! - new.height / 2 - bottomMargin)
        ButView = new
        new.isOpaque = false
        ButView?.FromButton.addTarget(self, action: #selector(ChoosePlace(sender:)), for: .touchUpInside)
        ButView?.toButton.addTarget(self, action: #selector(ChoosePlace(sender:)), for: .touchUpInside)
        ButView?.Send.addTarget(self, action: #selector(PushDetail), for: .touchUpInside)
        view.addSubview(ButView!)
    }
    
    
    @objc func ChoosePlace(sender:UIButton) {
        let place = ChoosePlaceTableViewController()
        let my_places = MyPlacesTableViewController()
        my_places.userprotocol = self
        place.tag = sender.tag
        place.userprotcol = self
        self.navigationController!.pushViewController(place, animated: true)
    }
    
    
    @objc func PushDetail() {
        if from_lat != 0 && to_long != 0 {
            let sets = SettingTableViewController()
            sets.delegate = self
            self.navigationController!.pushViewController(sets, animated: true)
        }
            
        else  {
            view.makeToast("Заполните все поля")
        }

    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let maps = MapView(frame: view.bounds)
        mapview = maps
        view.addSubview(mapview!)
        addview()
        userprotocol = self
        check()
        mapview?.map.delegate = self
        Cancel.can = self
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        mapview!.menuimage.addGestureRecognizer(tapGestureRecognizer)
        let menuLeft = UISideMenuNavigationController(rootViewController: MenuTableViewController())
        menuLeft.sideMenuManager.menuPresentMode = .menuSlideIn
        menuLeft.sideMenuManager.menuWidth = view.frame.width - view.frame.width*0.2
        SideMenuManager.default.menuLeftNavigationController = menuLeft
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: mapview!.menuimage)
        SideMenuManager.default.menuAddPanGestureToPresent(toView: mapview!.menuimage)
        SideMenuManager.default.menuFadeStatusBar = false
        SideMenuManager.default.menuPushStyle = .subMenu
        manager.delegate = self
        SideMenuManager.default.menuLeftNavigationController?.dismiss(animated: true, completion: nil)
        manager.requestWhenInUseAuthorization()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
        NotificationCenter.default.addObserver(self, selector: #selector(drivercame(notification:)), name: NSNotification.Name(rawValue: "201"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(drivercame(notification:)), name: NSNotification.Name(rawValue: "401"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(drivercame(notification:)), name: NSNotification.Name(rawValue: "501"), object: nil)
    }
    
    func check() {
        sendPushId.send { (info, type) in
            if info.activeOrders!.count != 0 {
                let orders = info.activeOrders![0]
                self.userprotocol?.from_lat = Double(orders.fromLatitude!)
                self.userprotocol?.from_long = Double(orders.fromLongitude!)
                self.userprotocol?.to_lat = Double(orders.toLatitude!)
                self.userprotocol?.to_long = Double(orders.toLongitude!)
                self.userprotocol?.state_type = orders.status
                self.userprotocol?.order_id = orders.id
                self.userprotocol?.addbuttons()
                self.userprotocol?.first_added()
                self.userprotocol?.second_added()
                self.userprotocol?.first_clicked = false
                self.userprotocol?.second_clicked = false
                self.userprotocol?.second_added()
                self.userprotocol?.second_name = "Куда?"
            }
        }
    }
    
    
    
    func setup() {
        if mapview?.map.myLocation?.coordinate.longitude != nil {
            let coord =   mapview?.map.myLocation?.coordinate
            let lat = coord?.latitude
            let long = coord?.longitude
            getfromgeo.get(lat: String(lat!), long: String(long!)) { (place) in
                self.first_name = place
            }
            self.from_lat = lat
            self.from_long = long
        }
    }
    
    
    
    @objc func drivercame(notification:NSNotification) {
     
        switch notification.name.rawValue {
        case "201":
            addbut()
            Cancel.cancel.removeFromSuperview()
            Cancel.label.removeFromSuperview()
            view.makeToast("Водитель принял ваш Заказ")
        case "401":
            break
        case "501":
            orderbutton.removeFromSuperview()
            Rating.addRating()
            Rating.rat = self
        default:
            break
        }

    }
    
    func addbut() {
        view.addSubview(orderbutton)
        Route.Draw(startlat: from_lat!, startlong: from_long!, endlat: to_lat!, englong: to_long!, map: (mapview?.map)!)
        orderbutton.backgroundColor = maincolor
        orderbutton.setAnchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 40)
        orderbutton.setTitle("Информация о заказе", for: .normal)
        orderbutton.setTitleColor(UIColor.white, for: .normal)
        orderbutton.addTarget(self, action: #selector(showdes), for: .touchUpInside)
    }
    
    @objc func showdes() {
 
            self.customPresentViewController(self.presenter, viewController: self.onOnder, animated: true, completion: nil)
       
    }
    override func viewWillAppear(_ animated: Bool)
    {       navigationController?.navigationBar.isHidden = true
            navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
    }
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        
        present(SideMenuManager.defaultManager.menuLeftNavigationController!,animated: true,completion: nil)
    }
    
    
    }
