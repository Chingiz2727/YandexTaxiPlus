//
//  FullChatsTableViewController.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 11/27/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit

class FullChatsTableViewController: UITableViewController,UIGestureRecognizerDelegate,UISearchBarDelegate {
    var cellid = "cellid"
    var type : Int?
    var nav_title: String! = ""
    let search = UISearchBar()

    var chats : TableViewFullChatsModelType?
    var model = FullChatsViewModel()
    var searchrlist = FullChatsViewModel()
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

        chats = searchrlist
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.isTranslucent = false

        navigationController?.navigationBar.isHidden = false
        let menubutton = UIBarButtonItem.init(image: UIImage(named: "icon_add"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(go))
        self.navigationItem.rightBarButtonItem = menubutton
        tableView.bounces = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CityTaxiTableViewCell.self, forCellReuseIdentifier: cellid)
        navigationController?.navigationBar.barTintColor = maincolor
        search.delegate = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
      
        self.navigationItem.title = nav_title
        reload()
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        view.addSubview(search)
        search.setAnchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 40)
        search.backgroundColor = maincolor
        search.barTintColor = maincolor
        return search
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
                self.model.chats = list
                self.searchrlist.chats = list
                self.tableView.reloadData()
            }
            if no == true {
                let alert = CustomAlert(title: "", message: "", preferredStyle: .alert)
                alert.publish = "0"
                alert.type = String(self.type!)
                AccessShowFunc.Show(completion: { (info) in
                    if let info = info {
                        alert.label.text = "Для публикации оплатите \(info.types[self.type!-1].hourPrice ?? 0) тг"
                        alert.show()
                        self.model.chats = list
                        self.searchrlist.chats = list
                    }
                })

                if alert.isBeingDismissed {
                    self.tableView.reloadData()
                }
           

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
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else { searchrlist.chats = model.chats
            tableView.reloadData()
            return }
        
        searchrlist.chats = model.chats.filter({ (lst) -> Bool in
            return lst.to_string!.contains(searchText) || lst.from_string!.contains(searchText)
        })
        
        tableView.reloadData()
    }

}
