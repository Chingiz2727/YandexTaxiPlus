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
    
    

}

