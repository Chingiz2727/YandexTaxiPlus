//
//  UserMainPageViewController.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 13.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyStarRatingView
import Toast_Swift
import NotificationCenter
import  SideMenu
import GoogleMaps
class UserMainPageViewController: UIViewController,CLLocationManagerDelegate,GMSMapViewDelegate {
    var MainMapview : UserMainPageView!
    let cellid = "cellid"
    let cellid2 = "cellid2"
    var service_id : Int!
    var PriceCar = [carPrice]()
    var paytype = [Payment(type: "Карта", icon: "warning"),Payment(type: "Наличные", icon: "warning"),Payment(type: "Оплата монетами", icon: "warning")]
    let blackview = UIView()
    var selectedindexpath : IndexPath!
    var mainview = UIView()
    var button : UIButton = UIButton()
    let starRatingView = SwiftyStarRatingView()
    let StarBack = UIView()
    let StarRateTopImage = UIImageView()
    let StarRateLabel = UILabel()
    let starRateTextView = UITextField()
    let starRateButton = UIButton()
    let starRateLine = UIView()
    var chatButton = UIButton()
    var callButton  = UIButton()
    var order_id : String?
    var rating_text : String?
    var rating_star: String?
    var locationManager:CLLocationManager!
    private var currentCoordinate: CLLocationCoordinate2D?
    var currentLocation:CLLocation?
    
    var colletionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.clipsToBounds = false
        cv.layer.masksToBounds = false
        cv.layer.shadowColor = UIColor.black.cgColor
        cv.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        cv.layer.shadowRadius = 2.0
        cv.layer.shadowOpacity = 0.5
        return cv
    }()
    
    var collview:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.clipsToBounds = false
        cv.layer.masksToBounds = false
        cv.layer.shadowColor = UIColor.black.cgColor
        cv.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        cv.layer.shadowRadius = 2.0
        cv.layer.shadowOpacity = 0.5
        return cv
    }()
    func AddConnectButton() {
        view.addSubview(chatButton)
        view.addSubview(callButton)
        chatButton.tag = 22
        callButton.tag = 23
        chatButton.backgroundColor = maincolor
        callButton.backgroundColor = UIColor.red
        callButton.layer.cornerRadius = 18.0
        chatButton.layer.cornerRadius = 18.0
        chatButton.setAnchor(top: MainMapview.Detect.bottomAnchor, left: nil, bottom: nil, right: MainMapview.Detect.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 36, height: 36)
        chatButton.addTarget(self, action: #selector(gotoChat), for: .touchUpInside)
        callButton.setAnchor(top: chatButton.bottomAnchor, left: nil, bottom: nil, right: MainMapview.Detect.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 36, height: 36)
    }
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = UIColor.init(r: 104, g: 205, b: 179)
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barTintColor = maincolor
        navigationController?.navigationBar.isTranslucent = false
        MainMapview.To.addTarget(self, action: #selector(ChoosePlace(sender:)), for: .touchUpInside)
        let polyLine: GMSPolyline = GMSPolyline()
        polyLine.isTappable = true
        MainMapview.mapview.delegate = self
        MainMapview.mapview.isUserInteractionEnabled = true
        
        MainMapview.From.addTarget(self, action: #selector(ChoosePlace(sender:)), for: .touchUpInside)
        MainMapview.From.setTitle(first_name, for: .normal)
        MainMapview.To.setTitle(second_name, for: .normal)
        MainMapview.Call.addTarget(self, action: #selector(data), for: .touchUpInside)
    }
   
    func OpenMenu() {
        
        present(SideMenuManager.defaultManager.menuLeftNavigationController!,animated: true,completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupMainView()
        setupLocationManager()
        MainMapview.MenuAction = OpenMenu
        colletionView.register(PriceCell.self, forCellWithReuseIdentifier: cellid)
        collview.register(CarCell.self, forCellWithReuseIdentifier: cellid2)
        colletionView.delegate = self
        collview.delegate = self
        colletionView.dataSource = self
        collview.dataSource = self
        let menuLeft = UISideMenuNavigationController(rootViewController: MenuTableViewController())
        menuLeft.sideMenuManager.menuPresentMode = .menuSlideIn
        menuLeft.sideMenuManager.menuWidth = view.frame.width - view.frame.width*0.2
        SideMenuManager.default.menuLeftNavigationController = menuLeft
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: MainMapview.menuimage)
        SideMenuManager.default.menuAddPanGestureToPresent(toView: MainMapview.menuimage)
        

        SideMenuManager.default.menuFadeStatusBar = false
        SideMenuManager.default.menuPushStyle = .subMenu

        NotificationCenter.default.addObserver(self, selector: #selector(drivercame(notification:)), name: NSNotification.Name(rawValue: "201"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(drivercame(notification:)), name: NSNotification.Name(rawValue: "401"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(drivercame(notification:)), name: NSNotification.Name(rawValue: "501"), object: nil)
    }
    func index(index:IndexPath) {
        print(index)
       PushFromMain.push(index: index)
    }
    @objc func drivercame(notification:NSNotification) {
        let ord_id = notification.userInfo![AnyHashable("order_id")] as? String
        switch notification.name.rawValue {
        case "201":
            self.order_id = ord_id
            ShowInfo()
            AddConnectButton()
            view.makeToast("Водитель принял ваш Заказ")
        case "401":
            view.makeToast("Водитель подъехал")
        case "501":
            addRating()
        default:
            break
        }
    }
    

    
    @objc func function(start:SwiftyStarRatingView) {
        print(start.value)
    }
    func SetupMainView() {
        let mainView = UserMainPageView(frame: self.view.frame)
        self.MainMapview = mainView
        self.view.addSubview(mainView)
    }
    
//    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D){
//        print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
//        MainMapview.mapview.clear() // clearing Pin before adding new
//        let marker = GMSMarker(position: coordinate)
//        let mark2 = GMSMarker(position: coordinate)
//        marker.map?.clear()
//        marker.icon = UIImage(named: "icon_point_a")
//        marker.map = MainMapview.mapview
//    }
    @objc func ChoosePlace(sender:UIButton) {
        print("let")
        let place = ChoosePlaceTableViewController()
        place.tag = sender.tag
//        self.navigationController?.pushViewController(place, animated: true)
        let navEditorViewController: UINavigationController = UINavigationController(rootViewController: place)
        navigationController?.present(navEditorViewController, animated: true, completion: nil)
        
        
    }
  @objc func gotoChat() {
        let chat = ChatViewController()
        GetOrderInfo.GetInfo(order_id: order_id!) { (order) in
            var phone_driver = order.driver?.phone
            var phone_user = order.client?.phone
            chat.chatid = "\(phone_driver!)\(phone_user!)"
            chat.name = order.driver?.name!
            chat.phone = order.driver?.phone!
            self.navigationController?.pushViewController(chat, animated: true)
        }
    }
    
    func remove() {
        let stand  = UserDefaults.standard
        stand.removeObject(forKey: "token")
        UIApplication.shared.keyWindow?.rootViewController = EnterPhone()
    }
    func ShowInfo() {
        GetOrderInfo.GetInfo(order_id: order_id!) { (order) in
          
        }
    }
}
