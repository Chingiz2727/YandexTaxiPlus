//
//  GetCarSettingsTableViewController.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 26.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit

class GetCarSettingsTableViewController: UITableViewController {
    var cellid = "cellid"
    var type : Int?
    var id : Int?
    var carmodel : CarModelDelegate?
    var carmark : CarMarkDelegate?
    var model = [SetModel]()
    let searchbar : UISearchBar = UISearchBar()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellid)
        reload()
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        view.addSubview(searchbar)
        return searchbar
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func reload() {
        if type! == 0 {
        RegiterSettingApi.setting { (model) in
            self.model = model
            self.tableView.reloadData()
        }
        }
        else {
            RegiterSettingApi.Mark(id: id ?? 0) { (model) in
                self.model = model
                self.tableView.reloadData()
            }
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return model.count
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(model[indexPath.row].model)

        if type! == 0
        {
            carmodel?.remove()
            carmodel?.car_model_id = model[indexPath.row].id
            carmodel?.car_model_name = model[indexPath.row].model
            
        }
        if type! == 1 {
            carmark?.car_mark_name = model[indexPath.row].model
        }
        self.navigationController?.popViewController(animated: true)
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath)
        cell.textLabel?.text = model[indexPath.row].model
        
        // Configure the cell...

        return cell
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
