//
//  OrderDetailTableViewController.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 12/18/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit
import Alamofire
class OrderDetailTableViewController: UITableViewController {
    var menu = [AccepTaxiModule]()
    let cellid = "cellid"
    var footerid = "footer"
    let tablehead = "header"
    var order_id : Int?
    let window = UIApplication.shared.keyWindow!
    var image : UIImage?
    var startimage : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(AcceptByTaxiCell.self, forCellReuseIdentifier: cellid)
        tableView.register(CellFooterInfo.self, forCellReuseIdentifier: footerid)
        tableView.bounces = false
        tableView.register(HeaderOrderTableViewCell.self, forCellReuseIdentifier: tablehead)
        fetching()
        
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: tablehead) as! HeaderOrderTableViewCell
        cell.button.addTarget(self, action: #selector(dismissed), for: .touchDown)
        cell.avatarImageView.image = image
        cell.starsAvatar.image = startimage
        return cell
    }
    
    
    
   
    fileprivate func fetching() {
        self.view.makeToastActivity(.center)
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            GetOrderInfo.GetInfo(order_id: String(self.order_id!), completion: { (info) in
                if let avatar = info.avatar {
                    let url = "http://185.236.130.126/profile/uploads/avatars/\(avatar)"
                    Alamofire.request(url).responseJSON(completionHandler: { (response) in
                        DispatchQueue.main.async {
                            self.image = UIImage(data: response.data!)
                            self.tableView.reloadData()
                        }
                    })
                }
                else {
                    self.image = UIImage.init(named: "userjpg")
                }
            

            })
        }
        queue.async {
            GetOrderInfo.GetInfo(order_id: String(self.order_id!), completion: { (info) in
                GetDriverAvatar.get(rating: info.rating!, star: info.stars!, completion: { (name) in
                    self.startimage = UIImage.init(named: name)
                    self.tableView.reloadData()

                })
            })
        }
        queue.async {
            Makemenu.getmenu(completion: { (menu) in
                self.menu = menu
                self.view.hideToastActivity()
                self.tableView.reloadData()
            })
        }
    }
    
    @objc func dismissed() {
        self.dismiss(animated: true, completion: nil)
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 120
    }
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let foot = tableView.dequeueReusableCell(withIdentifier: footerid) as! CellFooterInfo
        foot.chat.addTarget(self, action: #selector(gotoChat), for: .touchUpInside)
        foot.call.addTarget(self, action: #selector(call), for: .touchUpInside)
        return foot
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    @objc func call() {
        sendPushId.send { (info, order_id) in
            let inf = info.activeOrders![0]
            GetOrderInfo.GetInfo(order_id: String(inf.id!)) { (order) in
    
                let phone_user = order.driver?.phone
                if let url = URL(string: "tel://\("+" + phone_user!)") {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
                
            }
        }
    }
    
    @objc func gotoChat() {
        let chat = ChatViewController()
        GetOrderInfo.GetInfo(order_id: String(order_id!)) { (order) in
            let phone_driver = order.driver?.phone
            let phone_user = order.client?.phone
            self.window.makeToastActivity(.center)
            chat.chatid = "\(phone_driver!)\(phone_user!)"
            UserInformation.shared.getinfo(completion: { (info) in
                chat.receiver  = info.user?.phone!
                    chat.name = order.driver?.name!
                    chat.phone = order.driver?.phone!
                    chat.token = order.driver?.token!
                
                
                self.dismiss(animated: true, completion: nil)
                
                self.window.hideToastActivity()
                (self.window.rootViewController as? UINavigationController)?.pushViewController(
                    chat, animated: true)
            })
            
          }
        
        
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return menu.count
    }
    
    

  override  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as! AcceptByTaxiCell
        cell.menu.text = menu[indexPath.row].detail
        cell.detail.text = menu[indexPath.row].menu
        cell.icon.image = UIImage(named: menu[indexPath.row].img)
        cell.selectionStyle = .none
        return cell
    }
 
}

class Makemenu {
    class func getmenu(completion:@escaping(_ module:[AccepTaxiModule])->()) {
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
                                      AccepTaxiModule(detail: "Дата посадки", menu: (info.order?.lastEdit!)!, img: "clock-1"),
                                      AccepTaxiModule(detail: "Режим", menu: ("Такси"), img: "icon_mode")]
                       completion(module)
                    })
                })
            }
            )
        }
    }
}
