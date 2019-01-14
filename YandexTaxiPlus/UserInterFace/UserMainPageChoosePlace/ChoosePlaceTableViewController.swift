//
//  ChoosePlaceTableViewController.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 15.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit
import GooglePlaces
class ChoosePlaceTableViewController: UITableViewController,UISearchBarDelegate,UISearchControllerDelegate,GMSAutocompleteResultsViewControllerDelegate {
    
    var userprotcol : UserMainPageProtocol?

    
    var resultsViewController: GMSAutocompleteResultsViewController?
    var deleg : GMSAutocompleteViewController?
    var searchController: UISearchController?
    var resultView: UITextView?
    var arr = [MenuPlace(name: "", lat: 0, long: 0),MenuPlace(name: "", lat: 0, long: 0)]
    var cellid = "cellid"
    var tag : Int? = 0
    
    var array = ["Выбрать местоположение на карте","Сохраненные места"]
    override func viewDidLoad() {
        super.viewDidLoad()
        AddSearchBar()
        tableView.register(ChoosePlaceTableViewCell.self, forCellReuseIdentifier: cellid)
        navigationController?.navigationBar.isTranslucent = true
        UIColourScheme.instance.set(for:self)
        tableView.bounces = false

    }
    
    func tagItem(text:String,lang:Double,lat:Double)
    {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            switch self.tag! {
            case 0:
                self.userprotcol?.from_lat = lat
                self.userprotcol?.from_long = lang
                self.userprotcol?.first_name = text
                self.userprotcol?.first_added()
            case 1:
                self.userprotcol?.to_lat = lat
                self.userprotcol?.to_long = lang
                self.userprotcol?.second_name = text
                self.userprotcol?.second_added()
            default:
                break
            }
            self.navigationController?.popViewController(animated: true)

        }
    
        
    }
    
    func AddSearchBar() {
        navigationController?.navigationBar.isHidden = false
        
       
        
        resultsViewController = GMSAutocompleteResultsViewController()
        let filter = GMSAutocompleteFilter()
        filter.country = "KZ"
        deleg?.autocompleteFilter = filter

        resultsViewController!.autocompleteFilter = filter
        resultsViewController?.delegate = self
        navigationController?.navigationBar.barTintColor = maincolor
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController
        searchController?.searchBar.sizeToFit()
//        navigationItem.titleView = searchController?.searchBar
        searchController?.searchBar.barTintColor = maincolor
        definesPresentationContext = true
        searchController?.hidesNavigationBarDuringPresentation = false
    }
  override  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if searchController?.isEditing == true  {
        return 0
    }
    
        return 40
    }
    
   override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    view.addSubview((searchController?.searchBar)!)
        return searchController?.searchBar
    }
  override  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.row == 0 {
        switch tag! {
        case 0:
            userprotcol?.first_clicked = true
            userprotcol?.second_clicked = false
        case 1:
            userprotcol?.first_clicked = false
            userprotcol?.second_clicked = true
        default:
            break
        }
        self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    else {
        let myplace = MyPlacesTableViewController()
        myplace.tag = tag
        myplace.userprotocol = userprotcol
      
        self.navigationController?.pushViewController(myplace, animated: true)
    }
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
 
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as! ChoosePlaceTableViewCell
        cell.img.image  = UIImage(named: "icon_location_marker")
        cell.label.text = array[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }

    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didAutocompleteWith place: GMSPlace) {
        searchController?.isActive = false
        resultsController.autocompleteFilter?.country = "KZ"
        // Do something with the selected place.
        searchController?.searchBar.text = place.name
        
        self.tagItem(text: place.name, lang: place.coordinate.longitude, lat: place.coordinate.latitude)
        self.navigationController?.popViewController(animated: true)

    }
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didSelect prediction: GMSAutocompletePrediction) -> Bool {
        return true
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didFailAutocompleteWithError error: Error){
        let filter = GMSAutocompleteFilter()
        filter.type = .establishment
        filter.country = "KZ"
        resultsController.autocompleteFilter = filter
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        self.navigationController?.popViewController(animated: true)
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        self.navigationController?.popViewController(animated: true)

    }
    
}
//
//  ChoosePlaceTableViewCell.swift
//  Taxi+
//
//  Created by Чингиз on 16.08.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit

class ChoosePlaceTableViewCell: UITableViewCell {
    
    let img = UIImageView()
    let label = MainLabel()
    let view = UIView()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    func setView() {
        self.addSubview(view)
        view.addSubview(label)
        label.initialize()
        view.addSubview(img)
        img.contentMode = .scaleAspectFill
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "che tam"
        let centerY = img.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        let centerYLabel = label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        label.setAnchor(top: self.topAnchor, left: img.rightAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 10)
        label.numberOfLines = 0
        img.setAnchor(top: nil, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 30, paddingBottom: 0, paddingRight: 0,width: 20,height: 20)
        NSLayoutConstraint.activate([centerY,centerYLabel])
        self.backgroundColor = nil
    }
}


