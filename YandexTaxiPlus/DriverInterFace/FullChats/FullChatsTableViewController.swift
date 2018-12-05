//
//  FullChatsTableViewController.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 11/27/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit

class FullChatsTableViewController: UITableViewController,UIGestureRecognizerDelegate {
    var cellid = "cellid"
    var type : Int?
    var nav_title: String! = ""
    
    var chats : TableViewFullChatsModelType?
    var model = FullChatsViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        switch type! {
        case 2:
            nav_title = "Грузоперевозка"
        case 3:
            nav_title = "Эвакуатор"
        case 4:
            nav_title = "ИнваТакси"
        default:
            break
        }
        UIColourScheme.instance.set(for:self)

        chats = model
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.navigationBar.tintColor = UIColor.white
        
        navigationController?.navigationBar.isHidden = false
        let menubutton = UIBarButtonItem.init(image: UIImage(named: "icon_add"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(go))
        self.navigationItem.rightBarButtonItem = menubutton
        tableView.bounces = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CityTaxiTableViewCell.self, forCellReuseIdentifier: cellid)
        navigationController?.navigationBar.barTintColor = maincolor
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
      
        self.navigationItem.title = nav_title
        reload()
    }
    
    @objc func go() {
        switch type! {
        case 2:
            self.navigationController?.pushViewController(AddGruzTableViewController(), animated: true)
        case 3:
            self.navigationController?.pushViewController(AddEvoTaxiTableViewController(), animated: true)
        case 4:
            self.navigationController?.pushViewController(AddInvaTableViewController(), animated: true)
        default:
            break
        }
    }
    
    func reload() {
        GetFullChats.Get(type: type!) { (list, yes, no) in
            if yes == true {
                print("reloaded")
                self.model.chats = list
                self.tableView.reloadData()
            }
            if no == true {
                let alert = CustomAlert(title: "", message: "", preferredStyle: .alert)
                alert.publish = "0"
                alert.type = String(self.type!)
                alert.title = ""
                alert.show()
                self.model.chats = list
                self.tableView.reloadData()
                
            }
            self.model.chats = list
            self.tableView.reloadData()
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
 

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return chats?.numofrows ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as? CityTaxiTableViewCell
        
        guard let tableViewCell = cell, let viewModel = chats else {
            return UITableViewCell()
        }
        let cellviewmodel = chats?.cellViewModile(forIndexPath: indexPath)
        tableViewCell.viewModel = cellviewmodel
        return tableViewCell
    }

}
