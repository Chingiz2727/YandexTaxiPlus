//
//  InvaTaxiTableViewController.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 19.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit


class InvaTaxiTableViewController: UITableViewController,UITextFieldDelegate {
    var cellid = "cellid"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barTintColor = maincolor
        self.navigationItem.title = "Инва Такси"
        let menubutton = UIBarButtonItem.init(image: UIImage(named: "icon_add"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(go))
        self.navigationItem.rightBarButtonItem = menubutton
        tableView.bounces = false
        tableView.register(CityTaxiTableViewCell.self, forCellReuseIdentifier: cellid)
        UIColourScheme.instance.set(for:self)

        tableView.delegate = self
        tableView.dataSource = self
    }
    @objc func go() {
        self.navigationController?.pushViewController(AddInvaTableViewController(), animated: true)
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as! CityTaxiTableViewCell
        
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

