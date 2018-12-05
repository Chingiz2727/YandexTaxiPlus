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
    var headerid = "headerid"
    var titlemenu = [MenuModule(menu: "", img: "")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("color")
        print(APItoken.getColorType())
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = false
        tableView.separatorStyle = .none
        tableView.register(MainPageHeader.self, forCellReuseIdentifier: headerid)
        navigationController?.isNavigationBarHidden = true

      
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(true)
        tableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        UIColourScheme.instance.set(for:self)
        tableView.register(MainPageMenuCell.self, forCellReuseIdentifier: cellid)

        var ColorMenu = ""
        if APItoken.getColorType() == 0 {
            ColorMenu = "Ночной режим"
        }
        else {
            ColorMenu = "Дневной режим"
        }
        var menu = [
            MenuModule(menu: "Открытие смены", img: "icon_taxi"),
            MenuModule(menu: "Текущий заказ", img: "icon_main"),
            MenuModule(menu: "Город", img: "icon_taxi"),
            MenuModule(menu: "Межгород", img: "icon_cities_taxi"),
            MenuModule(menu: "Грузовые", img: "icon_cargo"),
            MenuModule(menu: "Эвакуатор", img: "icon_evo"),
            MenuModule(menu: "Инва Такси", img: "icon_inva"),
            MenuModule(menu: "История поездок", img: "wall-clock"),
            MenuModule(menu: "Монеты", img: "icon_by_bonuses"),
            MenuModule(menu: "Режим клиента", img: "icon_switch"),
            MenuModule(menu: "Настройки", img: "settings-6"),
            MenuModule(menu: ColorMenu, img: "view"),
            MenuModule(menu: "Поделиться", img: "icon_share")]
        self.titlemenu = menu
        self.tableView.reloadData()
    }
 
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 70
        }
        return 150
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let head = tableView.dequeueReusableCell(withIdentifier: headerid) as! MainPageHeader
        UserInformation.shared.getinfo { (info) in
            guard let name = info.user!.name else {return}
            head.nameLabel.text = name
            guard let phone = info.user!.phone else {return}
            head.phone.text = phone
        }
        if section == 1 {
            view.addSubview(outview)
            outview.addSubview(outbutton)
            outbutton.setAnchor(top: outview.topAnchor, left: outview.leftAnchor, bottom: outview.bottomAnchor, right: outview.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10)
            outbutton.setTitle("Выйти", for: .normal)
            outbutton.layer.cornerRadius = 10
            outbutton.backgroundColor = #colorLiteral(red: 0.8784313725, green: 0.2588235294, blue: 0.368627451, alpha: 1)
            outbutton.addTarget(self, action: #selector(remove), for: .touchUpInside)
            return outview
        }
        return head
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
        if APItoken.getColorType() == 0 {
            cell.img.setImageColor(color: maincolor)
            cell.label.textColor = maincolor
        }
        else {
            cell.img.setImageColor(color: UIColor.white)
cell.label.textColor = UIColor.white
        }
        
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss(animated: true, completion: nil)
        if indexPath.row == 11 {
            self.tableView.reloadData()
        }
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
        let fuull = FullChatsTableViewController()
        switch  index.row {
        case 0:
            (window.rootViewController as? UINavigationController)?.pushViewController(SessionOpenViewController(), animated: true)
        case 1:
            (window.rootViewController as? UINavigationController)?.pushViewController(DriverMapViewController(), animated: true)
        case 2:
           
            CheckCarContains.check(type: "1") { (yes, no) in
                if yes {
                     (window.rootViewController as? UINavigationController)?.pushViewController(TaxiOrdersTableViewController(), animated: true)
                }
                else {
         (window.rootViewController as? UINavigationController)?.pushViewController(SecondRegisterTableViewController(), animated: true)                }
            }
        case 3:
            CheckCarContains.check(type: "1") { (yes, no) in
                if yes {
                    (window.rootViewController as? UINavigationController)?.pushViewController(CityTaxi(), animated: true)
                }
                else {
                    (window.rootViewController as? UINavigationController)?.pushViewController(SecondRegisterTableViewController(), animated: true)                }
            }
          
            
        case 4:
            //Gruz
            CheckCarContains.check(type: "2") { (yes, no) in
                if yes {
                    fuull.type = 2
                    (window.rootViewController as? UINavigationController)?.pushViewController(fuull, animated: true)
                }
                else {
                    (window.rootViewController as? UINavigationController)?.pushViewController(SecondRegisterTableViewController(), animated: true)                }
            }
        case 5:
            //EVo
            CheckCarContains.check(type: "3") { (yes, no) in
                if yes {
                    fuull.type = 3
                    (window.rootViewController as? UINavigationController)?.pushViewController(fuull, animated: true)
                }
                else {
         (window.rootViewController as? UINavigationController)?.pushViewController(SecondRegisterTableViewController(), animated: true)                }
            }
        case 6:
            ///Inva
            CheckCarContains.check(type: "4") { (yes, no) in
                if yes {
                    fuull.type = 4
                   (window.rootViewController as? UINavigationController)?.pushViewController(fuull, animated: true)
                }
                else {
                    (window.rootViewController as? UINavigationController)?.pushViewController(SecondRegisterTableViewController(), animated: true)
                    
                }
            }
        case 7:
            (window.rootViewController as? UINavigationController)?.pushViewController(HistoryTableViewController(), animated: true)
        case 8:
            (window.rootViewController as? UINavigationController)?.pushViewController(DriverCoinsViewController(), animated: true)
        case 9:
            ChangeRole.Change { (touser,todriver,torregister) in
                if touser == true {
                    window.rootViewController = UINavigationController.init(rootViewController: TestViewController())
          }
            }
        case 10:
            (window.rootViewController as? UINavigationController)?.pushViewController(DriverSettingTableViewController(), animated: true)
        case 11:
            if APItoken.getColorType() == 0 {
                APItoken.savecolor(color: 1)
                  (window.rootViewController as? UINavigationController)?.pushViewController(SessionOpenViewController(), animated: true)
            }
            else {
                APItoken.savecolor(color: 0)
                  (window.rootViewController as? UINavigationController)?.pushViewController(SessionOpenViewController(), animated: true)
            }
          
        default:
            break
        }
        window.makeKeyAndVisible()

    }
    class func Exit() {
        guard let window = UIApplication.shared.keyWindow else {return}
        window.makeKeyAndVisible()
        Quit.quit { (yes) in
            if yes == true {
                let preft = UserDefaults.standard
                preft.removeObject(forKey: "token")
                UIApplication.shared.keyWindow?.rootViewController = EnterPhone()
            }
        }
        
    }
    
}
