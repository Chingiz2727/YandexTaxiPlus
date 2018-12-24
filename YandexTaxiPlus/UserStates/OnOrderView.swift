//
//  OnOrderView.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 11/20/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
import UIKit

class OnOrder : NSObject,UITableViewDataSource,UITableViewDelegate {
    var menu = [AccepTaxiModule]()
    var cellid = "cellid"
    var footerid = "footer"
    var order_id : Int?
    var navigation : UINavigationController?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as! AcceptByTaxiCell
        cell.menu.text = menu[indexPath.row].detail
        cell.detail.text = menu[indexPath.row].menu
        cell.icon.image = UIImage(named: menu[indexPath.row].img)
        cell.selectionStyle = .none
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let foot = tableview.dequeueReusableCell(withIdentifier: footerid) as! CellFooterInfo
        foot.chat.addTarget(self, action: #selector(gotoChat), for: .touchUpInside)
        foot.call.addTarget(self, action: #selector(call), for: .touchUpInside)
        return foot
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 80
    }
    
    var tableview : UITableView = UITableView()
    var showbutton : UIButton = UIButton()
    let window : UIWindow = UIApplication.shared.keyWindow!
    
    
    func addview(nav:UINavigationController) {
        self.navigation = nav
        window.addSubview(showbutton)
        showbutton.tag = 0
        window.addSubview(tableview)
        self.tableview.frame = CGRect(x: 0, y: window.frame.height, width: self.tableview.frame.width, height: 480)
        self.showbutton.frame = CGRect(x: 0, y: window.frame.height - 60, width: self.window.frame.width, height: 60)
        showbutton.setTitle("Информация о заказе", for: .normal)
        showbutton.backgroundColor = maincolor
        showbutton.addTarget(self, action: #selector(showhide(sender:)), for: .touchUpInside)
        datareload()
    }
    
    func showtable() {
    let height:CGFloat = 480
    let y = window.frame.height - height
    UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
               self.showbutton.frame = CGRect(x: 0, y: y-60, width: self.window.frame.width, height: 60)
        self.tableview.frame = CGRect(x: 0, y: y, width: self.window.frame.width, height: height)
 
    }, completion: nil)
        tableview.bounces = false
        tableview.isScrollEnabled = false
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(AcceptByTaxiCell.self, forCellReuseIdentifier: cellid)
        tableview.register(CellFooterInfo.self, forCellReuseIdentifier: footerid)
    
    }
    @objc func showhide(sender:UIButton) {
        switch  sender.tag {
        case 0:
            showtable()
            showbutton.tag = 1
        case 1:
            showbutton.tag = 0
            dismiss()
        default:
            break
        }
    }
    
    func dismiss(){
    UIView.animate(withDuration: 0.1) {
        if let window = UIApplication.shared.keyWindow {
            self.tableview.frame = CGRect(x: 0, y: window.frame.height, width: self.tableview.frame.width, height: self.tableview.frame.height)
             self.showbutton.frame = CGRect(x: 0, y: window.frame.height - 60, width: self.window.frame.width, height: 60)
           
        }
    }
    }
    
    
    @objc func gotoChat() {
        let chat = ChatViewController()
            GetOrderInfo.GetInfo(order_id: String(order_id!)) { (order) in
                let phone_driver = order.driver?.phone
                let phone_user = order.client?.phone
                chat.chatid = "\(phone_driver!)\(phone_user!)"
                UserInformation.shared.getinfo(completion: { (info) in
                    chat.receiver  = info.user?.phone!
                })
                chat.name = order.driver?.name!
                chat.phone = order.driver?.phone!
                self.showbutton.removeFromSuperview()
                self.tableview.removeFromSuperview()
                self.navigation?.pushViewController(chat, animated: true)
            }
        
        
    }
    
    func remove() {
        self.showbutton.removeFromSuperview()
        self.tableview.removeFromSuperview()
    }
    @objc func call() {
        sendPushId.send { (info, order_id) in
            var inf = info.activeOrders![0]
            GetOrderInfo.GetInfo(order_id: String(inf.id!)) { (order) in
                let phone_user = order.driver?.phone
                if let url = URL(string: "tel://\("+" + phone_user!)") {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
                
            }
        }
    }
    func datareload() {
        sendPushId.send { (info, order) in
            let id = info.activeOrders![0]
            GetOrderInfo.GetInfo(order_id: "\(id.id!)", completion: { (info) in
                var car_name : String?
                var car_number : String?
                for i in info.car! {
                    car_name = i.submodel!
                    car_number = i.number!
                }
                
                getfromgeo.get(lat: (info.order?.fromLatitude)!, long: (info.order?.fromLongitude)!, completion: { (place) in
                    getfromgeo.get(lat: (info.order?.toLatitude)!, long: (info.order?.toLongitude)!, completion: { (place2) in
                        let module = [AccepTaxiModule(detail: "Откуда", menu: place, img: "icon_point_a"),
                                      AccepTaxiModule(detail: "Куда", menu: place2, img: "icon_point_b"),
                                      AccepTaxiModule(detail: "Имя", menu: (info.driver?.name!)!, img: "user"),
                                      AccepTaxiModule(detail: "Номер телефона", menu: (info.driver?.phone!)!, img: "icon_phone"),
                                      AccepTaxiModule(detail: "Марка машины", menu: car_name!, img: "icon_car"),
                                      AccepTaxiModule(detail: "Номер машины", menu: (car_number)!, img: "icon_card"),
                                      AccepTaxiModule(detail: "Дата посадки", menu: (info.order?.created!)!, img: "clock-1"),
                                      AccepTaxiModule(detail: "Режим", menu: ("Такси"), img: "icon_mode")]
                        self.menu = module
                    })
                })
                
       
             

                
                
        
//                self.tableview.reloadData()
            }
                
            )
            
        }
       
    }
}
