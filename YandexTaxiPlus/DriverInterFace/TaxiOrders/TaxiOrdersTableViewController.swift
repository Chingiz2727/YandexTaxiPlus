//
//  TaxiOrdersTableViewController.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 27.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit
import Presentr
import Toast_Swift
class TaxiOrdersTableViewController:UIViewController, UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate,CustomSegmentedControlDelegate {
    var codeSegmented : CustomSegmentedControl = CustomSegmentedControl()
    func changeToIndex(index: Int) {
        reload(index: index)
    }
    let tableview = UITableView()
    var cellid = "cellid"
    var ViewModel : TableViewTaxiOrdersModelType?
    var module = TaxiOrdersViewModel()
    var locationManager = CLLocationManager()
    var segment = UISegmentedControl()
    var lat : Double!
    var long : Double!
    let presenter : Presentr = {
        let width = ModalSize.fluid(percentage: 0.9)
        let heigh = ModalSize.fluid(percentage: 0.9)
        let center = ModalCenterPosition.center
        let customtype = PresentationType.custom(width: width, height: heigh, center: center)
        let customPresenter = Presentr(presentationType: customtype)
        customPresenter.backgroundOpacity  = 0.5
        return customPresenter
    }()

    var items : [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = false
        ViewModel = module
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        addview()
        navigationController?.navigationBar.isTranslucent = false
        UIColourScheme.instance.set(for:self)
        tableview.dataSource = self
        tableview.delegate = self
        tableview.register(TaxiOrdersTableViewCell.self, forCellReuseIdentifier: cellid)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: NSNotification.Name(rawValue: "101"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(sendcoor(notification:)), name: NSNotification.Name(rawValue: "1"), object: nil)
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barTintColor = maincolor
        
        reload(index: 0)
        tableview.bounces = false
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        self.lat = locValue.latitude
        self.long = locValue.longitude
        
    }
    
    @objc func sendcoor(notification:NSNotification) {
        let ord_id = notification.userInfo![AnyHashable("order_id")] as? String
        SendLocation.sendloc(longitude: String(self.long!), latitude: String(self.lat!), order_id: ord_id!)
    }
   
    
  
    func addview() {
//        self.view.addSubview(codeSegmented)
        view.addSubview(codeSegmented)
        view.addSubview(tableview)
        tableview.setAnchor(top: codeSegmented.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 2, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        codeSegmented.setButtonTitles(buttonTitles: [""])
        codeSegmented.setAnchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: self.view.frame.width, height: 50)
        CheckForChats.check { (state) in
            switch state!.showChat! {
            case true:
                self.items = ["Общий чат","Мой таксопарк"]
                self.codeSegmented.label2.isHidden = false
            case false :
                self.items = ["Общий чат"]
                self.codeSegmented.label2.isHidden = true
            }
            self.codeSegmented.label1.text = "\(state?.amountShared ?? 0)"
            self.codeSegmented.label2.text = "\(state?.amountOwn ?? 0)"
            self.codeSegmented.setButtonTitles(buttonTitles: self.items)
            self.codeSegmented.backgroundColor = .clear
            self.codeSegmented.delegate = self
            
        }
        
    }
   
    override func viewWillAppear(_ animated: Bool) {
        tableview.estimatedRowHeight = 70
        tableview.rowHeight = UITableView.automaticDimension
    }
     func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
        
    @objc func reload (index:Int) {
    self.view.makeToastActivity(.center)
        var mainurl : String!
        switch index {
        case 0:
            mainurl = "/get-shared-orders/"
        case 1:
            mainurl = "/get-own-orders/"
        default:
            break
        }
        getcharorders.get(url: mainurl!) { (info) in
            if let info = info {
                self.module.chats = info
                self.tableview.reloadData()
                self.view.hideToastActivity()
            }
          
        }
    }

     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ViewModel?.numofrows ?? 0
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as? TaxiOrdersTableViewCell
        guard let tableViewCell = cell, let viewModel = ViewModel else {
            return UITableViewCell()
        }
        let cellviewmodel = ViewModel?.cellViewModile(forIndexPath: indexPath)
        tableViewCell.viewModel = cellviewmodel
        
        return tableViewCell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let table = InfoTableViewController()
    guard let viewModel = ViewModel else {
        return
    }
    
    viewModel.selecRow(atIndexPath: indexPath)
    table.order_id = module.chats[indexPath.row].id!
    customPresentViewController(presenter, viewController: table, animated: true)
    }

}
