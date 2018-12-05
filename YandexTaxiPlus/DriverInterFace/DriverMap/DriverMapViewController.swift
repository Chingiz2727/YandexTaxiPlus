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
    var order_id : Int? = 0
    var acceptOrder : UIButton =  UIButton()
    var callButton : UIButton =  UIButton()
    var chatButton : UIButton = UIButton()
    let marker1 = GMSMarker()
    let marker2 = GMSMarker()
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
    func OpenMenu() {
        present(SideMenuManager.defaultManager.menuLeftNavigationController!,animated: true,completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        MainMapView.mapview.delegate = self
        MainMapView.mapview.isMyLocationEnabled = true
        MainMapView.SearchAction = Detection
        // Do any additional setup after loading the view.
    }
    func Detection() {
                let camera = GMSCameraPosition.camera(withLatitude: (MainMapView.mapview.myLocation?.coordinate.latitude)!, longitude: (MainMapView.mapview.myLocation?.coordinate.longitude)!, zoom: 16.0)
                MainMapView.mapview.camera = camera
//                setupLocationManager()
    }

    override func viewWillAppear(_ animated: Bool) {
                sendPushId.send { (info, type) in
            self.tag = info.status!
           
            self.order_id = info.order_id
            self.addbut()

        }
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
    
    func addbut() {
        if tag! > 1 {
            GetOrderInfo.GetInfo(order_id: String(order_id!)) { (info) in
                
                let fromlong = info.order?.fromLongitude?.toDouble()
                let fromlat = info.order?.fromLatitude?.toDouble()
                let tolong = info.order?.toLongitude?.toDouble()
                let tolat = info.order?.toLatitude?.toDouble()
                Route.Draw(startlat: fromlat!, startlong: fromlong!, endlat: tolat!, englong: tolong!, map: self.MainMapView.mapview)
                self.marker2.position = CLLocationCoordinate2D(latitude: tolat!, longitude: tolong!)
                self.marker2.icon = self.imageWithImage(image: UIImage(named: "icon_point_b")!, scaledToSize: CGSize(width: 20, height: 20))
                self.marker2.map = self.MainMapView.mapview
                self.marker1.icon = self.imageWithImage(image: UIImage(named: "icon_point_a")!, scaledToSize: CGSize(width: 20, height: 20))
                self.marker1.position = CLLocationCoordinate2D(latitude: fromlat!, longitude: fromlong!)
                self.marker1.map = self.MainMapView.mapview
                let camera = GMSCameraPosition.camera(withLatitude: fromlat!, longitude: fromlong!, zoom: 13.0)
                self.MainMapView.mapview.camera = camera
            }
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
        callButton.setAnchor(top: chatButton.bottomAnchor, left: nil, bottom: nil, right: self.view.rightAnchor, paddingTop: 15, paddingLeft: 0, paddingBottom: 70, paddingRight: 20, width: 60, height: 60)
        chatButton.setAnchor(top: MainMapView.Detect.bottomAnchor, left: nil, bottom: nil, right: self.view.rightAnchor, paddingTop: 15, paddingLeft: 0, paddingBottom: 20, paddingRight: 20, width: 60, height: 60)
        callButton.layer.cornerRadius = 30
        chatButton.layer.cornerRadius = 30
        chatButton.setImage(UIImage.init(named: "icon_message"), for: .normal)
        callButton.setImage(UIImage.init(named: "icon_call"), for: .normal)
        callButton.backgroundColor = maincolor
        chatButton.backgroundColor = maincolor
        chatButton.imageView?.sizeToFit()
        callButton.imageView?.sizeToFit()
        callButton.imageView?.frame.size = CGSize(width: 20, height: 20)
        chatButton.imageView?.frame.size = CGSize(width: 20, height: 20)
        
        chatButton.imageView?.contentMode = .scaleAspectFit
        callButton.imageView?.contentMode = .scaleAspectFit
        callButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        chatButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        acceptOrder.layer.cornerRadius = 10.0
        acceptOrder.backgroundColor = maincolor
                        acceptOrder.addTarget(self, action: #selector(DriverAction(sender:)), for: .touchUpInside)
                    chatButton.addTarget(self, action: #selector(gotoChat), for: .touchUpInside)
        callButton.addTarget(self, action: #selector(call), for: .touchUpInside)
    }
    @objc func gotoChat() {
        let chat = ChatViewController()
        sendPushId.send { (info, order_id) in
            GetOrderInfo.GetInfo(order_id: String(order_id!)) { (order) in
                let phone_driver = order.driver?.phone
                let phone_user = order.client?.phone
                chat.chatid = "\(phone_driver!)\(phone_user!)"
                UserInformation.shared.getinfo(completion: { (info) in
                    chat.receiver  = info.user?.phone!
                })
                chat.name = order.driver?.name!
                chat.phone = order.driver?.phone!
                self.navigationController?.pushViewController(chat, animated: true)
               
            }
        }
        
        
        
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
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
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
                    self.MainMapView.mapview.clear()

                }
            }
        default:
            break
        }
    }
}
