//
//  MenuTableViewController.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 20.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit
import SideMenu

class MenuTableViewController: UITableViewController {
    var cellid = "cellid"
    var outview : UIView = UIView()
    var outbutton : UIButton = UIButton()
    var titlemenu = [
        MenuModule(menu: "Такси", img: "icon_taxi"),
        MenuModule(menu: "Lady Такси", img: "icon_taxi"),
        MenuModule(menu: "Межгород", img: "icon_cities_taxi"),
        MenuModule(menu: "Инва Такси", img: "icon_inva"),
        MenuModule(menu: "Грузоперевозки", img: "icon_cargo"),
        MenuModule(menu: "Эвакуатор", img: "icon_evo"),
        MenuModule(menu: "Трезвый Водитель", img: "icon_driver"),
        MenuModule(menu: "История поездок", img: "wall-clock"),
        MenuModule(menu: "Настройки", img: "settings-6"),
        MenuModule(menu: "Мои Монеты", img: "icon_driver"),
        MenuModule(menu: "Режим Водителя", img: "icon_switch"),
        MenuModule(menu: "Поделиться", img: "icon_share")]
    var headerid = "headerid"
    override func viewDidLoad() {
        super.viewDidLoad()
        UIColourScheme.instance.set(for:self)

        tableView.bounces = false
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        navigationController?.isNavigationBarHidden = true
        tableView.register(MainPageMenuCell.self, forCellReuseIdentifier: cellid)
        tableView.register(MainPageHeader.self, forCellReuseIdentifier: headerid)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 70
        }
        return 200
    }
   override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let head = tableView.dequeueReusableCell(withIdentifier: headerid) as! MainPageHeader
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
    UserInformation.shared.getinfo { (info) in
        var name = info.user?.name
        head.nameLabel.text = name! ?? "user"
        head.phone.text = info.user?.phone!
    }
    GetAvatar.get { (string) in
        print(string)
    }
        return head
    }
    @objc func remove() {
        PushDriver.Exit()
    }
    // MARK: - Table view data source

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
        if APItoken.getColorType() == 0 {
            cell.img.setImageColor(color: maincolor)
            cell.label.textColor = maincolor

        }
        else {
            cell.img.setImageColor(color: UIColor.white)
            cell.label.textColor = UIColor.white

        }
        cell.label.text = titlemenu[indexPath.row].menu
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    let main = TestViewController()
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss(animated: true, completion: nil)
        main.index(index: indexPath)
    }
}
class PushFromMain : UINavigationController {
    class func push (index:IndexPath){
        guard let window = UIApplication.shared.keyWindow else {return}
        let fuull = FullChatsTableViewController()
        var Mainpage = TestViewController()
        switch index.row {
        case 0:
            Mainpage.type = "1"
            (window.rootViewController as? UINavigationController)?.pushViewController(Mainpage, animated: true)
        case 1:
            Mainpage.type = "2"
            (window.rootViewController as? UINavigationController)?.pushViewController(Mainpage, animated: true)
        case 2:
            (window.rootViewController as? UINavigationController)?.pushViewController(CityTaxi(), animated: true)
        case 3:
            fuull.type = 4
            (window.rootViewController as? UINavigationController)?.pushViewController(fuull, animated: true)
        case 4:
            fuull.type = 2
            (window.rootViewController as? UINavigationController)?.pushViewController(fuull, animated: true)

        case 5:
            fuull.type = 3
            (window.rootViewController as? UINavigationController)?.pushViewController(fuull, animated: true)
        case 6:
            
            (window.rootViewController as? UINavigationController)?.pushViewController(DrunkTaxiTable(), animated: true)
        case 7:
            (window.rootViewController as? UINavigationController)?.pushViewController(HistoryTableViewController(), animated: true)
        case 8:
              (window.rootViewController as? UINavigationController)?.pushViewController(UserSettingsTableViewController(), animated: true)
        case 9:
              (window.rootViewController as? UINavigationController)?.pushViewController(DriverCoinsViewController(), animated: true)
        case 10:
            ChangeRole.Change { (touser,todriver,torregister) in
                if todriver == true {
                    window.makeToastActivity(.center)
                    let menuLeftNavigationController = UISideMenuNavigationController(rootViewController: DriverMenuTableViewController())
                    SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController
                    menuLeftNavigationController.sideMenuManager.menuWidth = window.frame.width - window.frame.width*0.2
                    SideMenuManager.default.menuFadeStatusBar = false
                    SideMenuManager.default.menuPushStyle = .replace
                    menuLeftNavigationController.sideMenuManager.menuPresentMode = .menuSlideIn
                    window.rootViewController = UINavigationController.init(rootViewController: SessionOpenViewController())
                    window.hideToast()
                }
                if torregister == true {
                    (window.rootViewController as? UINavigationController)?.pushViewController(DriverRegisterTableViewController(), animated: true)
                }
            }
        default:
            break
        }
        window.makeKeyAndVisible()

      
    }
   
}
extension UIImageView {
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}
