//
//  CityTaxi.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 22.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit

class CityTaxi: UITableViewController {
    let search = UISearchBar()
    var list = [RoadList]()
    var cellid = "cellid"
    override func viewDidLoad() {
        super.viewDidLoad()
        make()

     
        navigationController?.navigationBar.isHidden = false
        self.navigationItem.title = "Межгород"
        let menubutton = UIBarButtonItem.init(image: UIImage(named: "icon_add"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(go))
        self.navigationItem.rightBarButtonItem = menubutton
        tableView.bounces = false

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellid)

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
            self.tableView.reloadData()
        }
    }
    override func viewWillAppear(_ animated: Bool) {

    }
    @objc func go() {
        self.navigationController?.pushViewController(AddTableViewController(), animated: true)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var road = RoadedCityTableViewController()
        road.startid = list[indexPath.row].StartId
        road.endid = list[indexPath.row].endId
        navigationController?.pushViewController(road, animated: true)
        
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(list.count)
        return list.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath)
        cell.textLabel?.text = "\(list[indexPath.row].Start!) -> \(list[indexPath.row].end!)"
        // Configure the cell...

        return cell
    }
 
}
