//
//  UserSettingsTableViewController.swift
//  newtaxi
//
//  Created by Чингиз on 25.08.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit

class UserSettingsTableViewController: UITableViewController,FromCitiesTableViewControllerDelegate {
    func CityFromData(id: String, region_id: String, name: String, cname: String) {
        UserInformation.shared.getinfo { (info) in

        self.menu = [UserSetting(name: "Имя", placeholder: (info.user?.name!)!),
                     UserSetting(name: "Телефон", placeholder: (info.user?.phone!)!),
                     UserSetting(name: "Город", placeholder: cname),
                     UserSetting(name: "Монеты", placeholder: String(info.user?.balance ?? 0))] }
        tableView.reloadData()
    }
    
    var cellid = "cellid"
    var menu = [UserSetting]()
    var onChange : Bool = false
    let EditButton = MainButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        UIColourScheme.instance.set(for:self)

        tableView.register(UserSettingTableViewCell.self, forCellReuseIdentifier: cellid)
        navigationController?.navigationBar.barTintColor = maincolor
        navigationController?.navigationBar.isHidden = false
        let menubutton = UIBarButtonItem.init(image: UIImage(named: "icon_edit"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(edit))
        self.navigationItem.rightBarButtonItem = menubutton
        tableView.allowsSelection = false

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        EditButton.addTarget(self, action: #selector(edit), for: .touchUpInside)
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
            var list = [UserSetting(name: "Имя", placeholder: (info.user?.name!)!),
                        UserSetting(name: "Телефон", placeholder: (info.user?.phone!)!),
                        UserSetting(name: "Город", placeholder: (info.city?.cname!)!),
                        UserSetting(name: "Монеты", placeholder: String(info.user?.balance ?? 0))]
            self.menu = list
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
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return menu.count
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2 {
            let cities = CitiesTableViewController()
            cities.tag = 0
            cities.delegateFrom = self
            navigationController?.present(cities, animated: true, completion: nil)
        }
        print(indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid , for: indexPath) as! UserSettingTableViewCell
        cell.name.text = menu[indexPath.row].name
        cell.label.text = menu[indexPath.row].placeholder
        cell.label.textAlignment = .right
        cell.label.isUserInteractionEnabled = false
        cell.selectionStyle = .none
        return cell
    }


}
