//
//  DriverSettingTableViewController.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 11/30/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit

class DriverSettingTableViewController: UITableViewController {
    let cellid = "cellid"
    var menu = [MenuModule(menu: "Настройки аккаунта", img: "user", id: "1", contains: false),
                MenuModule(menu: "FAQ", img: "icon_faq", id: "1", contains: false)]
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(MainPageMenuCell.self, forCellReuseIdentifier: cellid)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        UIColourScheme.instance.set(for:self)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = maincolor
        navigationController?.navigationBar.isHidden = false


        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as! MainPageMenuCell
        cell.label.text = menu[indexPath.row].menu
        cell.img.image = UIImage.init(named: menu[indexPath.row].img)

        // Configure the cell...
        cell.selectionStyle = .none
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
  override  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    switch indexPath.row {
    case 0:
        self.navigationController?.pushViewController(UserSettingsTableViewController(), animated: true)
    case 1:
        self.navigationController?.pushViewController(AddFAQTableViewController(), animated: true)
    default:
        break
    }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
