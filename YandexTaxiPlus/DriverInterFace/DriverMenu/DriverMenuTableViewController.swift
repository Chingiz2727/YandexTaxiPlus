//
//  DriverMenuTableViewController.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 30.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit
import SideMenu
class DriverMenuTableViewController: UITableViewController {
    var outview : UIView = UIView()
    var outbutton : UIButton = UIButton()
    var cellid = "cellid"
    var titlemenu = [
        MenuModule(menu: "Открытие смены", img: "icon_taxi"),
        MenuModule(menu: "Навигация", img: "icon_taxi"),
        MenuModule(menu: "Такси", img: "icon_taxi"),
        MenuModule(menu: "Инва Такси", img: "icon_inva"),
        MenuModule(menu: "Межгород", img: "icon_cities_taxi"),
        MenuModule(menu: "Грузоперевозка", img: "icon_cargo"),
        MenuModule(menu: "Эвакуатор", img: "icon_evo"),
        MenuModule(menu: "История поездок", img: "wall-clock"),
        MenuModule(menu: "Монеты", img: "icon_driver"),
        MenuModule(menu: "Настройки", img: "settings-6"),
        MenuModule(menu: "Режим клиента", img: "icon_switch"),
        MenuModule(menu: "Поделиться", img: "icon_share")]
    
    var header : MainPageHeader!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = false
        tableView.separatorStyle = .none
        navigationController?.isNavigationBarHidden = true
        tableView.register(MainPageMenuCell.self, forCellReuseIdentifier: cellid)
        UserInformation.getinfo { (info) in
            self.header.nameLabel.text = info.user.name!
            self.header.phone.text = info.user.phone!
        }
        SetupMainView()
    }
  
 
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 70
        }
        return 200
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            view.addSubview(outview)
            outview.addSubview(outbutton)
            outbutton.setAnchor(top: outview.topAnchor, left: outview.leftAnchor, bottom: outview.bottomAnchor, right: outview.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10)
            outbutton.setTitle("Выйти", for: .normal)
            outbutton.layer.cornerRadius = 10
            outbutton.backgroundColor = UIColor.red
            outbutton.addTarget(self, action: #selector(remove), for: .touchUpInside)
            return outview
        }
        return header
    }
    
    func SetupMainView() {
        let mainView = MainPageHeader(frame: CGRect(x: 0, y: 0, width: view.frame.width - view.frame.width*0.2, height: 200))
        self.header = mainView
        self.view.addSubview(mainView)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 1 {
            return 0
        }
        return titlemenu.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as! MainPageMenuCell
        
        // Configure the cell...
        cell.img.image = UIImage(named: titlemenu[indexPath.row].img)
        cell.label.text = titlemenu[indexPath.row].menu
        cell.label.textColor = maincolor
        
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss(animated: true, completion: nil)
        PushDriver.push(index: indexPath)
    }
    @objc func remove() {
        PushDriver.Exit()
    }
}
class PushDriver : UISideMenuNavigationController {
    let customSideMenuManager = SideMenuManager()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        sideMenuManager = customSideMenuManager
    }

    class func push (index:IndexPath){
        guard let window = UIApplication.shared.keyWindow else {return}
        window.makeKeyAndVisible()
        
        switch  index.row {
        case 0:
            (window.rootViewController as? UINavigationController)?.pushViewController(SessionOpenViewController(), animated: true)
        case 1:
            (window.rootViewController as? UINavigationController)?.pushViewController(DriverMapViewController(), animated: true)
        case 2:
            (window.rootViewController as? UINavigationController)?.pushViewController(TaxiOrdersTableViewController(), animated: true)
        case 3:
            (window.rootViewController as? UINavigationController)?.pushViewController(InvaTaxiTableViewController(), animated: true)
        case 4:
            (window.rootViewController as? UINavigationController)?.pushViewController(CityTaxi(), animated: true)
        case 5:
            (window.rootViewController as? UINavigationController)?.pushViewController(GruzTableViewController(), animated: true)
        case 6:
            (window.rootViewController as? UINavigationController)?.pushViewController(EvoTaxiTableViewController(), animated: true)
        case 7:
            (window.rootViewController as? UINavigationController)?.pushViewController(HistoryTableViewController(), animated: true)
        default:
            break
        }
    }
    class func Exit() {
        guard let window = UIApplication.shared.keyWindow else {return}
        window.makeKeyAndVisible()
        let stand  = UserDefaults.standard
        stand.removeObject(forKey: "token")
        UIApplication.shared.keyWindow?.rootViewController = EnterPhone()
        
    }
    
}
