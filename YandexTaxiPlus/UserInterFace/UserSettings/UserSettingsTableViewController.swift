//
//  UserSettingsTableViewController.swift
//  newtaxi
//
//  Created by Чингиз on 25.08.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit

class UserSettingsTableViewController: UITableViewController {
    var cellid = "cellid"
    var menu = [UserSetting(name: "Имя", placeholder: "Chris"),
                UserSetting(name: "Фамилия", placeholder: "Evans"),
                UserSetting(name: "Номер Телефона", placeholder: "+7 747 750 2321"),
                UserSetting(name: "Бонусы", placeholder: "500")]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UserSettingTableViewCell.self, forCellReuseIdentifier: cellid)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid , for: indexPath) as! UserSettingTableViewCell
        cell.name.text = menu[indexPath.row].name
        cell.label.placeholder = menu[indexPath.row].placeholder
        return cell
    }


}
