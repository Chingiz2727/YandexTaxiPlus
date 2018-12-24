//
//  UserSettingsTableViewController.swift
//  newtaxi
//
//  Created by Чингиз on 25.08.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit
class SettingCar {
    var img : String?
    var type : String?
    var id : String?
    var name :String?
    init(img:String,type:String,id:String,name:String) {
        self.img = img
        self.type = type
        self.id = id
        self.name = name
    }
}
class UserSettingsTableViewController: UITableViewController,FromCitiesTableViewControllerDelegate {
    func CityFromData(id: String, region_id: String, name: String, cname: String) {
        UserInformation.shared.getinfo { (info) in

        self.menu = [UserSetting(name: "Имя", placeholder: (info.user?.name!)!),
                     UserSetting(name: "Телефон", placeholder: (info.user?.phone!)!),
                     UserSetting(name: "Город", placeholder: cname),
                     UserSetting(name: "Монеты", placeholder: String(info.user?.balance ?? 0))] }
        tableView.reloadData()
    }
    var cars = [Car]()
    
    var cellid = "cellid"
    var menu = [UserSetting]()
    var onChange : Bool = false
    let EditButton = MainButton()
    let sec2 = "sec2"
    override func viewDidLoad() {
        super.viewDidLoad()
        UIColourScheme.instance.set(for:self)
        navigationController?.navigationBar.isTranslucent = false

        tableView.register(UserSettingTableViewCell.self, forCellReuseIdentifier: cellid)
        tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: sec2)
        navigationController?.navigationBar.barTintColor = maincolor
        navigationController?.navigationBar.isHidden = false
        let menubutton = UIBarButtonItem.init(image: UIImage(named: "icon_edit"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(edit))
        self.navigationItem.rightBarButtonItem = menubutton
        tableView.allowsSelection = false

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        EditButton.addTarget(self, action: #selector(edit), for: .touchUpInside)

        getinfo()
    }
    
    @objc func edit() {
        onChange = !onChange
        switch onChange {
        case true:
            view.addSubview(EditButton)
            EditButton.initialize()
            EditButton.setAnchor(top: nil, left: tableView.layoutMarginsGuide.leftAnchor, bottom: tableView.layoutMarginsGuide.bottomAnchor, right: tableView.layoutMarginsGuide.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 10, height: 60)
            EditButton.setTitle("Сохранить", for: .normal)
            tableView.allowsSelection = true
        case false :
            EditButton.removeFromSuperview()
            tableView.allowsSelection = false
        default:
            break
        }
     
        
    }
    func getinfo() {
        UserInformation.shared.getinfo { (info) in
            let list = [UserSetting(name: "Имя", placeholder: (info.user?.name!)!),
                        UserSetting(name: "Телефон", placeholder: (info.user?.phone!)!),
                        UserSetting(name: "Город", placeholder: (info.city?.cname!)!),
                        UserSetting(name: "Монеты", placeholder: String(info.user?.balance ?? 0))]
            self.menu = list
            if let car = info.cars {
                self.cars = car
            }
            self.tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 1 {
            return cars.count
        }
        if section == 0 {
            return menu.count

        }
        return 0
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2 {
            let cities = CitiesTableViewController()
            cities.tag = 0
            cities.delegateFrom = self
            navigationController?.present(cities, animated: true, completion: nil)
        }
        
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cels = UITableViewCell()
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellid , for: indexPath) as! UserSettingTableViewCell
            cell.name.text = menu[indexPath.row].name
            cell.label.text = menu[indexPath.row].placeholder
            cell.label.textAlignment = .right
            cell.label.isUserInteractionEnabled = false
            cell.selectionStyle = .none
            return cell
        }
        if indexPath.section == 1 {
            let cell2 = tableView.dequeueReusableCell(withIdentifier: sec2) as! HistoryTableViewCell
            cell2.img.image = UIImage.init(named: cars[indexPath.row].type!)
            cell2.date.text = "\(cars[indexPath.row].submodel!) \(cars[indexPath.row].model!)"
            cell2.label.text = cars[indexPath.row].number!
            return cell2
        }
        return cels
     
    }


}
