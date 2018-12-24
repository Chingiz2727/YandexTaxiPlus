//
//  HistoryTableViewController.swift
//  newtaxi
//
//  Created by Чингиз on 24.08.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit
import Presentr
import SideMenu
class HistoryTableViewController: UITableViewController,GetDate {
    var time : Int!

    func reload() {
        
    }
    
    var date: Int?
    var history = [History]()
    
   var cellid = "cellid"
    var img : String!
    let customSideMenuManager = SideMenuManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = false

        tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: cellid)
        tableView.tableFooterView = UIView()
        img = "icon_calendar"
        let nav = UIImage(named: img)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: nav, style: .plain, target: self, action: #selector(create))
        navigationItem.rightBarButtonItem?.width = 20
        navigationController?.navigationBar.barTintColor = maincolor
        navigationController?.navigationBar.isHidden = false
        tableView.bounces = false
        UIColourScheme.instance.set(for:self)

    }
 

    
 

    @objc func create() {
        DatePickerDialog().show("DatePicker", doneButtonTitle: "Ок", cancelButtonTitle: "Закрыть", datePickerMode: .date) {
            (date) -> Void in
            if let dt = date {
                
                let formatter = DateFormatter()
                formatter.dateFormat = "MM/dd/yyyy"
                getHistory.get(date: dt.timeIntervalSince1970, completion: { (hist) in
                    self.history = hist
                    self.tableView.reloadData()
                })
              
            }
          
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
        return history.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as! HistoryTableViewCell
        let item = history[indexPath.row]
        
        getfromgeo.get(lat: item.from_lat!, long: item.from_long!) { (place1) in
            getfromgeo.get(lat: item.to_lat!, long: item.to_long!, completion: { (place2) in
                cell.place.text = "\(place1) - \(place2)"
            })
        }
        
        cell.img.image = UIImage.init(named: "placeholder")
        cell.label.text = String(history[indexPath.row].price!) + " тг"
        cell.date.text = history[indexPath.row].last_edit!
        
        return cell
    }


   

}
