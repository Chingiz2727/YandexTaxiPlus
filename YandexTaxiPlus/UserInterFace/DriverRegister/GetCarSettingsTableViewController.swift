//
//  GetCarSettingsTableViewController.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 26.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit

class GetCarSettingsTableViewController: UITableViewController,UISearchBarDelegate {
    var cellid = "cellid"
    var type : Int?
    var id : Int?
    var carmodel : CarModelDelegate?
    var carmark : CarMarkDelegate?
    var model = [SetModel]()
    var searchmodel = [SetModel]()
    let searchbar : UISearchBar = UISearchBar()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellid)
        searchbar.delegate = self
        searchbar.tintColor = maincolor
        searchbar.barTintColor = maincolor
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
            self.searchmodel = model
            self.tableView.reloadData()
        }
        }
        else {
            RegiterSettingApi.Mark(id: id ?? 0) { (model) in
                self.model = model
                self.searchmodel = model
                self.tableView.reloadData()
            }
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchmodel.count
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(searchmodel[indexPath.row].model)

        if type! == 0
        {
            carmodel?.remove()
            carmodel?.car_model_id = searchmodel[indexPath.row].id
            carmodel?.car_model_name = searchmodel[indexPath.row].model
            
        }
        if type! == 1 {
            carmark?.car_mark_name = searchmodel[indexPath.row].model
            carmark?.car_mark_id = searchmodel[indexPath.row].id
        }
        self.navigationController?.popViewController(animated: true)
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath)
        cell.textLabel?.text = searchmodel[indexPath.row].model
        
        // Configure the cell...

        return cell
    }
 

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else { searchmodel = model
            tableView.reloadData()
            return }
        
        searchmodel = model.filter({ (lst) -> Bool in
            return lst.model.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }

}
