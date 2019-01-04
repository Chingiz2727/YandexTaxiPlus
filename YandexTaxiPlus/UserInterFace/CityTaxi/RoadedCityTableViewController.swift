//
//  RoadedCityTableViewController.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 24.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit

class RoadedCityTableViewController: UITableViewController,Payed {
    func reloading() {
        reload()
    }
    
var cellid = "cellid"
    var startid: String? = ""
    var endid :String? = ""
    var road = [RoadedList]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CityTaxiTableViewCell.self, forCellReuseIdentifier: cellid)
        reload()
        UIColourScheme.instance.set(for:self)

        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
 

    
    func reload() {
        RoadedTaxi.get(start_id: startid!, end_id: endid!) { (list, access, buy) in
           
            if access == true {
                self.road = list
                self.tableView.reloadData()
            }
            
            if buy == true {
                let alert = CustomAlert(title: "", message: "", preferredStyle: .alert)
                alert.publish = "0"
                alert.type = "1"
                alert.title = ""
                alert.pay = self
                AccessShowFunc.Show(completion: { (info) in
                    if let info = info {
                        print(info)
                        
                        alert.label.text = "Для публикации оплатите \(info.types[0].hourPrice ?? 0) тг"
                        self.road = list
                    }
                })
                if alert.isBeingDismissed == true {
                    self.tableView.reloadData()
                }
                alert.show()
                self.tableView.reloadData()
                }
              
        }
    
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return road.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as! CityTaxiTableViewCell
        let info = road[indexPath.row]
        var timer = Double(info.date!)
        let data = Date(timeIntervalSince1970: timer!)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+06:00") //Set timezone that you want
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm:ss" //Specify your format that you want
        let strDate = dateFormatter.string(from: data)
        cell.name.text = info.name!
        cell.price.text = "\(info.price!) тг"
        cell.from.text = info.start!
        cell.to.text = info.end!
        cell.car.text = "\(info.submodel ?? "") \(info.model ?? "" )"
        cell.phone.text = "(\(info.phone!))"
       cell.time.text = strDate
        cell.sits.text = "Место: \(info.seatsnum!)"
        // Configure the cell...
        cell.selectionStyle = .none
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
