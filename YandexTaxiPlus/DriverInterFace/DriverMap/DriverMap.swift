//
//  DriverMap.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 12/14/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit
import GoogleMaps
import SideMenu
import Presentr


class DriverMapViewController: UIViewController,DriverProtocol,CLLocationManagerDelegate,GMSMapViewDelegate {
    var from_long: String?
    var to_long: String?
    var manager = CLLocationManager()

    var from_lat: String?
    var to_lat: String?
    var status: Int?
    var order_id: Int?
    var MainMapView : DriverMapView!
    let marker1 = GMSMarker()
    let marker2 = GMSMarker()
    var acceptOrder : UIButton =  UIButton()
    var callButton : UIButton =  UIButton()
    var chatButton : UIButton = UIButton()
    var zayavabutton : UIButton = UIButton()
    let customSideMenuManager = SideMenuManager()
    let presenter : Presentr = {
        let customPresenter = Presentr(presentationType: .alert)
        customPresenter.backgroundOpacity  = 0.5
        
        return customPresenter
    }()
    var but_title: String? = "Я приехал" {
        didSet {
            acceptOrder.setTitle(but_title!, for: .normal)
        }
    }
    
    
    
    func DrawMap() {
        let fromlong = from_long?.toDouble()
        let tolong = to_long?.toDouble()
        let fromlat = from_lat?.toDouble()
        let tolat = to_lat?.toDouble()
        Route.Draw(startlat: fromlat!, startlong: fromlong!, endlat: tolat!, englong: tolong!, map: MainMapView.mapview)
        marker1.position = CLLocationCoordinate2D(latitude: fromlat!, longitude: fromlong!)
        marker2.position = CLLocationCoordinate2D(latitude: tolat!, longitude: tolong!)
         self.marker2.icon = self.imageWithImage(image: UIImage(named: "icon_point_b")!, scaledToSize: CGSize(width: 20, height: 20))
         self.marker1.icon = self.imageWithImage(image: UIImage(named: "icon_point_a")!, scaledToSize: CGSize(width: 20, height: 20))
        self.marker1.map = self.MainMapView.mapview
        self.marker2.map = self.MainMapView.mapview
        let camera = GMSCameraPosition.camera(withLatitude: fromlat!, longitude: fromlong!, zoom: 13.0)
        self.MainMapView.mapview.camera = camera
    }
    
    func showButton() {
        switch status {
        case 2:
            but_title = "Я приехал"
        case 3:
            but_title = "Начать поездку"
        case 4:
            but_title = "Завершить поездку"
        default:
            break
            
        }
        view.addSubview(acceptOrder)
        view.addSubview(callButton)
        view.addSubview(chatButton)
        view.addSubview(zayavabutton)
        acceptOrder.tag = status!
        acceptOrder.setAnchor(top: nil, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, paddingTop: 3, paddingLeft: 20, paddingBottom: 6, paddingRight: 20,width: 100,height: 50)
        callButton.setAnchor(top: chatButton.bottomAnchor, left: nil, bottom: nil, right: self.view.rightAnchor, paddingTop: 15, paddingLeft: 0, paddingBottom: 70, paddingRight: 20, width: 60, height: 60)
        zayavabutton.setAnchor(top: callButton.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 60, height: 60)
        chatButton.setAnchor(top: MainMapView.Detect.bottomAnchor, left: nil, bottom: nil, right: self.view.rightAnchor, paddingTop: 15, paddingLeft: 0, paddingBottom: 20, paddingRight: 20, width: 60, height: 60)
        zayavabutton.layer.cornerRadius = 30
        callButton.layer.cornerRadius = 30
        chatButton.layer.cornerRadius = 30
        zayavabutton.setImage(#imageLiteral(resourceName: "icon_error-white"), for: .normal)
        
        zayavabutton.imageView?.setImageColor(color: UIColor.white)
        chatButton.setImage(UIImage.init(named: "icon_message"), for: .normal)
        callButton.setImage(UIImage.init(named: "icon_call"), for: .normal)
        zayavabutton.backgroundColor = maincolor
        callButton.backgroundColor = maincolor
        chatButton.backgroundColor = maincolor
        chatButton.imageView?.sizeToFit()
        zayavabutton.imageView?.sizeToFit()
        callButton.imageView?.sizeToFit()
        zayavabutton.imageView?.frame.size = CGSize(width: 20, height: 20)
        
        callButton.imageView?.frame.size = CGSize(width: 20, height: 20)
        chatButton.imageView?.frame.size = CGSize(width: 20, height: 20)
        chatButton.imageView?.contentMode = .scaleAspectFit
        callButton.imageView?.contentMode = .scaleAspectFit
        zayavabutton.imageView?.contentMode = .scaleAspectFit
        zayavabutton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        zayavabutton.addTarget(self, action: #selector(makezaya), for: .touchUpInside)
        callButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        chatButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        acceptOrder.layer.cornerRadius = 10.0
        acceptOrder.backgroundColor = maincolor
        acceptOrder.addTarget(self, action: #selector(DriverAction(sender:)), for: .touchUpInside)
        chatButton.addTarget(self, action: #selector(gotoChat), for: .touchUpInside)
        callButton.addTarget(self, action: #selector(call), for: .touchUpInside)
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
                    self.status = 3
                    self.acceptOrder.tag = 3

                    self.but_title = "Начать поездку"
                }
            }
        case 3:
            AcceptDriverOrder.accept(url: baseurl+"/go/", order_id: self.order_id!) { (po) in
                if po == "success" {
                    self.status = 4
                    self.acceptOrder.tag = 4
                    self.but_title = "Завершить поездку"
                }
            }
        case 4:
            AcceptDriverOrder.accept(url: baseurl+"/finish-order/", order_id: self.order_id!) { (po) in
                if po == "success" {
                    self.acceptOrder.removeFromSuperview()
                    self.callButton.removeFromSuperview()
                    self.chatButton.removeFromSuperview()
                    self.zayavabutton.removeFromSuperview()
                    self.MainMapView.mapview.clear()
                }
            }
        default:
            break
        }
    }
    @objc func gotoChat() {
        let chat = ChatViewController()
        GetOrderInfo.GetInfo(order_id: String(order_id!)) { (order) in
            let phone_driver = order.driver?.phone
            let phone_user = order.client?.phone
            self.view.makeToastActivity(.center)
            chat.chatid = "\(phone_driver!)\(phone_user!)"
            UserInformation.shared.getinfo(completion: { (info) in
                chat.receiver  = order.driver?.phone!
                chat.name = info.user?.name!
                chat.phone = info.user?.phone!
                chat.token = info.user?.token!
                self.view.hideToastActivity()
                self.navigationController?.pushViewController(chat, animated: true)
            })
        }
    }
    @objc func makezaya() {
        let controller = ZayavaViewController()
        controller.order_id = "\(self.order_id!)"
        customPresentViewController(presenter, viewController: controller, animated: true)
    }
    
    @objc func call() {
        sendPushId.send { (info, order_id) in
            GetOrderInfo.GetInfo(order_id: String(order_id!)) { (order) in
                let phone_user = order.client?.phone
                if let url = URL(string: "tel://\("+" + phone_user!)") {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
                
            }
        }
    }
    func OpenMenu() {
        present(SideMenuManager.defaultManager.menuLeftNavigationController!,animated: true,completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let sideMenuNavigationController = segue.destination as? UISideMenuNavigationController {
            sideMenuNavigationController.sideMenuManager = customSideMenuManager
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        let Tables = ListOfOrdersTable()
        Tables.list = self
        sendPushId.send { (info, type) in
            if (info.activeOrders?.count)! > 0 {
                self.customPresentViewController(self.presenter, viewController: Tables, animated: true)
            }
        }
        MainMapView.mapview.delegate = self
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
    }
    
    func Detection() {
        let camera = GMSCameraPosition.camera(withLatitude: (MainMapView.mapview.myLocation?.coordinate.latitude)!, longitude: (MainMapView.mapview.myLocation?.coordinate.longitude)!, zoom: 16.0)
        MainMapView.mapview.camera = camera
    }
    
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    override func viewWillAppear(_ animated: Bool) {
        MainMapView.MenuAction = OpenMenu
        customSideMenuManager.menuAddScreenEdgePanGesturesToPresent(toView: MainMapView.menuimage)
        customSideMenuManager.menuAddPanGestureToPresent(toView: MainMapView.menuimage)
        navigationController?.navigationBar.isHidden = true
        MainMapView.mapview.delegate = self
        MainMapView.mapview.isMyLocationEnabled = true
        MainMapView.SearchAction = Detection
    }
    
    func setup() {
        let mainView = DriverMapView(frame: self.view.frame)
        self.MainMapView = mainView
        self.view.addSubview(mainView)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 13)
        self.MainMapView.mapview.animate(to: camera)
        
        self.manager.stopUpdatingLocation()
    }
    
}
