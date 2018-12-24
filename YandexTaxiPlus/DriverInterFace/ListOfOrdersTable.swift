//
//  ListOfOrdersTable.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 12/14/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit




class ListOfOrdersTable: UITableViewController {
    var orders = [ActiveOrder]()
    let cellid = "cellid"
    var list : DriverProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ListOfOrdersTableViewCell.self, forCellReuseIdentifier: cellid)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        tableView.bounces = false
        reload()
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Выберите заказ"
    }
    func reload () {
        sendPushId.send { (info, ord) in
            self.orders = info.activeOrders!
            self.tableView.reloadData()
        }
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = orders[indexPath.row]
        list?.from_lat = item.fromLatitude
        list?.from_long = item.fromLongitude
        list?.to_lat = item.toLatitude
        list?.to_long = item.toLongitude
        list?.order_id = item.id
        list?.status = item.status
        list?.showButton()
        list?.DrawMap()
        self.dismiss(animated: true, completion: nil)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as! ListOfOrdersTableViewCell
        let ord = orders[indexPath.row]
        getfromgeo.get(lat: ord.fromLatitude!, long: ord.fromLongitude!) { (place1) in
            getfromgeo.get(lat: ord.toLatitude!, long: ord.toLongitude!, completion: { (place2) in
                cell.label.text = "\(place1) - \(place2)"

            })
        }
        cell.time.text = orders[indexPath.row].lastEdit!
        return cell
    }
    

}
