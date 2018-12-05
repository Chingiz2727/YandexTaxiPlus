//
//  TaxiOrdersTableViewController.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 27.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit
import Presentr
class TaxiOrdersTableViewController: UITableViewController,CLLocationManagerDelegate {
    var cellid = "cellid"
    var ViewModel : TableViewTaxiOrdersModelType?
    var module = TaxiOrdersViewModel()
    var locationManager = CLLocationManager()
    var segment = UISegmentedControl()
    var lat : Double!
    var long : Double!
    var reloadButton  = UIButton()
    let presenter : Presentr = {
        let width = ModalSize.fluid(percentage: 0.9)
        let heigh = ModalSize.fluid(percentage: 0.9)
        let center = ModalCenterPosition.center
        let customtype = PresentationType.custom(width: width, height: heigh, center: center)
        let customPresenter = Presentr(presentationType: customtype)
        customPresenter.backgroundOpacity  = 0.5
        
        return customPresenter
    }()

    var items : [String] = [] {
        didSet {
            segment = UISegmentedControl(items: items)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewModel = module
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        UIColourScheme.instance.set(for:self)

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TaxiOrdersTableViewCell.self, forCellReuseIdentifier: cellid)
               NotificationCenter.default.addObserver(self, selector: #selector(reloadBut(notification:)), name: NSNotification.Name(rawValue: "101"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(sendcoor(notification:)), name: NSNotification.Name(rawValue: "1"), object: nil)
        navigationController?.navigationBar.isHidden = false
        reloadButton.addTarget(self, action: #selector(reload), for: .touchUpInside)
        CheckForChats.check { (state) in
            switch state {
            case true:
                self.items = ["Общий чат","Мой таксопарк"]
            case false :
                self.items = ["Общий чат"]
            }
            self.makeSegment()
            self.reload()
        }
        navigationController?.navigationBar.barTintColor = maincolor
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
    @objc func reloadBut(notification:NSNotification) {
        if reloadButton.isDescendant(of: self.view) {
            
        }
        else {
            view.addSubview(reloadButton)
            reloadButton.setAnchor(top: tableView.layoutMarginsGuide.topAnchor, left: tableView.layoutMarginsGuide.leftAnchor, bottom: nil, right: tableView.layoutMarginsGuide.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 10, height: 40)
            reloadButton.layer.cornerRadius = 5
            reloadButton.setTitle("Новые заказы", for: .normal)
            reloadButton.backgroundColor = maincolor
            reloadButton.setTitleColor(UIColor.white, for: .normal)
        }
    }
    
    func makeSegment() {
        segment.tintColor = UIColor.white
        segment.backgroundColor  = maincolor
        navigationItem.titleView = segment
        segment.addTarget(self, action: #selector(segment(seg:)), for: .valueChanged)
        segment.selectedSegmentIndex = 0
    }
    
    @objc func segment(seg:UISegmentedControl) {
        reload()
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.estimatedRowHeight = 70
        tableView.rowHeight = UITableView.automaticDimension
    }
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
        
  @objc func reload () {
    if reloadButton.isDescendant(of: self.view) {
        reloadButton.removeFromSuperview()
    }
        var mainurl : String!
        switch segment.selectedSegmentIndex {
        case 0:
            mainurl = "/get-shared-orders/"
        case 1:
            mainurl = "/get-own-orders/"
        default:
            break
        }
        getcharorders.get(url: mainurl!) { (info) in
            print(mainurl!)
            self.module.chats = info
            self.tableView.reloadData()
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ViewModel?.numofrows ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as? TaxiOrdersTableViewCell
        guard let tableViewCell = cell, let viewModel = ViewModel else {
            return UITableViewCell()
        }
        let cellviewmodel = ViewModel?.cellViewModile(forIndexPath: indexPath)
        tableViewCell.viewModel = cellviewmodel
        
        return tableViewCell
    }
    
    
    
  override  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let table = InfoTableViewController()
    guard let viewModel = ViewModel else {
        return
    }
    
    viewModel.selecRow(atIndexPath: indexPath)
    table.order_id = module.chats[indexPath.row].id!
    customPresentViewController(presenter, viewController: table, animated: true)
    }

}
