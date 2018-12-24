//
//  CitiesTableViewController.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 23.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit

class CitiesTableViewController: UITableViewController {
    var cellid = "cellid"
    var citie = [CitiesList]()
    var tag : Int?
    var delegateFrom : FromCitiesTableViewControllerDelegate?
    var delegateto : ToCitiesTableViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        data()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellid)
        UIColourScheme.instance.set(for:self)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func viewWillAppear(_ animated: Bool) {
        data()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return citie.count
    }
    func data() {
        Citylist.List { (list:[CitiesList]) in
            self.citie = list
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath)

        cell.textLabel?.text = "\(citie[indexPath.row].Name!),\(citie[indexPath.row].Region!)"
        return cell
    }
 
  override  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if tag! == 0 {
        delegateFrom?.CityFromData(id: citie[indexPath.row].id!, region_id: citie[indexPath.row].regionId!, name: citie[indexPath.row].Region!, cname: citie[indexPath.row].Name!)
    }
    else {
        delegateto?.CityToData(id: citie[indexPath.row].id!, region_id: citie[indexPath.row].regionId!, name: citie[indexPath.row].Region!, cname: citie[indexPath.row].Name!)
    }

    self.dismiss(animated: true, completion: nil)
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
