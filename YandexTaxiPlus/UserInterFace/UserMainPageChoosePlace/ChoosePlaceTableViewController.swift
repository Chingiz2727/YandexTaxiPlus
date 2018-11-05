//
//  ChoosePlaceTableViewController.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 15.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit
import GooglePlaces
import RealmSwift
class ChoosePlaceTableViewController: UITableViewController,UISearchBarDelegate,UISearchControllerDelegate {
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var resultView: UITextView?
    var arr = [MenuPlace(name: "", lat: 0, long: 0),MenuPlace(name: "", lat: 0, long: 0)]
    var cellid = "cellid"
    var tag : Int? = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        AddSearchBar()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellid)
        print(tag!)
    }
    
    func tagItem(text:String,lang:Double,lat:Double)
    {
        let view = UserMainPageView()
        switch tag! {
        case 0:
            first_name = text
            first_lat = lat
            first_long = lang
            view.From.setTitle(text, for: .normal)
        case 1:
            second_name = text
            second_lat = lat
            second_long = lang
            view.To.setTitle(text, for: .normal)
        default:
            break
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func AddSearchBar() {
        navigationController?.navigationBar.isHidden = false

        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self
        resultsViewController?.autocompleteFilter?.country = "kz"
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController
        
        // Put the search bar in the navigation bar.
        searchController?.searchBar.sizeToFit()
        navigationItem.titleView = searchController?.searchBar
        
        // When UISearchController presents the results view, present it in
        // this view controller, not one further up the chain.
        definesPresentationContext = true
        // Prevent the navigation bar from being hidden when searching.
        searchController?.hidesNavigationBarDuringPresentation = false
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }


}
