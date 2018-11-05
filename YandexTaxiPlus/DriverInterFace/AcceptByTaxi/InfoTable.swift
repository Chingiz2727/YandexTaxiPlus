//
//  InfoTable.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 30.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit
import GoogleMaps
class InfoTable: NSObject,UITableViewDataSource,UITableViewDelegate {
    var menu = [AccepTaxiModule]()
    var id_order : String?
    var cellid = "cellid"
    var InfoTable : UITableView = UITableView()
    var footer : UIView = UIView()
    var AcceptButton : UIButton = UIButton()
    var CancelButton : UIButton = UIButton()
    var Map : GMSMapView = GMSMapView()
    
    func app(order_id:String?) {
        self.id_order = order_id
        GetOrderInfo.GetInfo(order_id: order_id!) { (order) in
            let module = [AccepTaxiModule(detail: "Имя:", menu: (order.client?.name!)!, img: "user"),
                          AccepTaxiModule(detail: "Цена:", menu: "\(order.order?.price)", img: "icon_by_bonuses")]
            
            self.menu = module
            self.AddView()
            self.InfoTable.reloadData()
        }
    }
    
    func AddView(){
        TableData()
        InfoTable.tag = 12
        if let window = UIApplication.shared.keyWindow {
            print(123)
            window.addSubview(InfoTable)
            self.InfoTable.frame = CGRect(x: 0, y: 0, width: 250, height: 420)

            InfoTable.center = CGPoint(x: window.frame.width/2, y: window.frame.height/2)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        self.InfoTable.addSubview(footer)
        footer.addSubview(AcceptButton)
        footer.addSubview(CancelButton)
        CancelButton.backgroundColor = UIColor.red
        AcceptButton.setTitle("Принять", for: .normal)
        CancelButton.setTitle("Отказать", for: .normal)
        CancelButton.setTitleColor(UIColor.white, for: .normal)
        AcceptButton.setTitleColor(UIColor.white, for: .normal)
        AcceptButton.backgroundColor = maincolor
        AcceptButton.layer.cornerRadius = 10
        CancelButton.layer.cornerRadius = 10
        AcceptButton.setAnchor(top: footer.topAnchor, left: footer.leftAnchor, bottom: footer.bottomAnchor, right: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 0,width: 100,height: 0)
        CancelButton.setAnchor(top: footer.topAnchor, left: nil , bottom: footer.bottomAnchor, right: footer.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10,width: 100,height: 0)
        AcceptButton.addTarget(self, action: #selector(accepting), for: .touchUpInside)
        CancelButton.addTarget(self, action: #selector(remove), for: .touchUpInside)
        return footer
    }
    func TableData()
    {
        InfoTable.register(AcceptByTaxiCell.self, forCellReuseIdentifier: cellid)
        InfoTable.dataSource = self
        InfoTable.delegate = self
        InfoTable.bounces = false
        InfoTable.isScrollEnabled = false
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    @objc func remove() {
        InfoTable.removeFromSuperview()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as! AcceptByTaxiCell
        cell.menu.text = menu[indexPath.row].detail
        cell.detail.text = menu[indexPath.row].menu
        cell.icon.image = UIImage(named: menu[indexPath.row].img)
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return Map
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 250
    }
    @objc func accepting() {
        AcceptFunc.accept(order_id: self.id_order!) { (state) in
            print(state)
            self.remove()
        }
    }
}



