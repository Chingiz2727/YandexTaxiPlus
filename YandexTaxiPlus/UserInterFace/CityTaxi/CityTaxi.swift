//
//  CityTaxi.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 22.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit

class CityTaxi: UITableViewController,UISearchBarDelegate {
    let search = UISearchBar()
    var list = [RoadList]()
    var searchlist = [RoadList]()
    var cellid = "cellid"
    override func viewDidLoad() {
        super.viewDidLoad()
        make()
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.title = "Межгород"
        let menubutton = UIBarButtonItem.init(image: UIImage(named: "icon_add"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(go))
        self.navigationItem.rightBarButtonItem = menubutton
        tableView.bounces = false
        navigationController?.navigationBar.barTintColor = maincolor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellid)
        UIColourScheme.instance.set(for:self)
        search.delegate = self

    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        view.addSubview(search)
        print(APItoken.getToken()!)
        search.setAnchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 40)
        search.backgroundColor = maincolor
        search.barTintColor = maincolor
        return search
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func make() {
        GetChats.Get(type: 1) { (list:[RoadList]) in
            self.list = list
            self.searchlist = list

            self.tableView.reloadData()
        }
    }
    override func viewWillAppear(_ animated: Bool) {

    }
    @objc func go() {
        self.navigationController?.pushViewController(AddTableViewController(), animated: true)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let road = RoadedCityTableViewController()
        road.startid = searchlist[indexPath.row].StartId
        road.endid = searchlist[indexPath.row].endId
        navigationController?.pushViewController(road, animated: true)
        
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchlist.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath)
        if APItoken.getColorType() == 0 {
            cell.textLabel?.textColor = UIColor.black
        }
        else {
            cell.textLabel?.textColor = UIColor.white
        }
        cell.textLabel?.text = "\(searchlist[indexPath.row].Start!) -> \(searchlist[indexPath.row].end!)"
        cell.backgroundColor = UIColor.clear
        
        // Configure the cell...

        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else { searchlist = list
            tableView.reloadData()
            return }
        
        searchlist = list.filter({ (lst) -> Bool in
           return lst.end!.contains(searchText) || lst.Start!.contains(searchText)
        })
       
        tableView.reloadData()
    }
    
    
    
}
