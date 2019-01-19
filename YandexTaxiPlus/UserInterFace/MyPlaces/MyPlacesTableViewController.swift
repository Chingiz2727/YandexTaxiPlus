//
//  MyPlacesTableViewController.swift
//  newtaxi
//
//  Created by Чингиз on 25.08.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit

class MyPlacesTableViewController: UITableViewController {
    var cellid = "cellid"
    var userprotocol : UserMainPageProtocol?
    var tag : Int!
    var myplace = [MyPlace]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(MyPlacesTableViewCell.self, forCellReuseIdentifier: cellid)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_add"), style: .plain, target: self, action: #selector(create))
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        getmyplace()
        UIColourScheme.instance.set(for:self)

    }
    override func viewWillAppear(_ animated: Bool) {
                getmyplace()
    }
    
    func getmyplace() {
            GetMyPlace.get { (myplace:[MyPlace]!) in
            if let myplace = myplace {
                self.myplace = myplace
                self.tableView.reloadData()
            }
        }
    }
    @objc func create() {
        navigationController?.pushViewController(SavePlaceViewController(), animated: true)
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
        return myplace.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as! MyPlacesTableViewCell
        cell.place.text = myplace[indexPath.row].place
                cell.img.image = UIImage(named: "placeholder")
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = myplace[indexPath.row]
        switch tag {
        case 0:
            userprotocol?.first_name = item.place
            userprotocol?.from_lat = Double(item.lat)!
            userprotocol?.from_long = Double(item.lang)!
            userprotocol?.first_added()
        case 1:
            userprotocol?.second_name = item.place
            userprotocol?.to_long = Double(item.lang)!
            userprotocol?.to_lat = Double(item.lat)!
            userprotocol?.second_added()
            
        default:
            break
        }
        self.navigationController?.popToRootViewController(animated: true)
    }
 


}
