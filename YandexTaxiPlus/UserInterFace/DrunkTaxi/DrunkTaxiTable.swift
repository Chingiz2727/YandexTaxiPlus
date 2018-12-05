//
//  DrunkTaxiTable.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 11/30/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit
import GooglePlaces
import Toast_Swift

class DrunkTaxiTable: UITableViewController,UITextFieldDelegate,firstplacedelegate,secondplacedelegate {
    func secondadded() {
        if first_long != 0 {
            GetDrunkPrice.GetPrice(from_lat: first_lat, from_long: first_long, to_lat: second_lat, to_long: second_long, comment: comment) { (price) in
                print(price)
                self.price = price
                self.tableView.reloadRows(at: [self.index], with: .none)
                
            }
        }

    }
    
    var sendButton : MainButton = MainButton()
    var kpp : Int = 0
    var allView = UIView()
    var menu = [
        MenuCity(text: "Цена", img: "icon_by_bonuses"),
        MenuCity(text: "Коментарий", img: "icon_dialog")]
    var tag : Int?
    var price : String = "Цена"
    var firstplace : firstplacedelegate?
    var seconplace : secondplacedelegate?
    var second_lat: Double = 0
    var comment: String = ""
    var second_long: Double = 0
    var label1 = MainLabel()
    var label2 = MainLabel()
    var footerview = UIView()
    var swiftcer = UISwitch()
    var img = UIImageView()
    
    
    
    var second_name: String = "Куда" {
        didSet {
            tobutton.setTitle(second_name, for: .normal)
        }
    }
    let index = IndexPath(row: 0, section: 0)

    var frombutton = UIButton()
    var tobutton = UIButton()
    var HeadView = UIView()
    
    func firstadded() {
        if second_long != 0 {
            GetDrunkPrice.GetPrice(from_lat: first_lat, from_long: first_long, to_lat: second_lat, to_long: second_long, comment: comment) { (price) in
                self.price = price
                self.tableView.reloadRows(at: [self.index], with: .none)
            }

        }
    }
    var cellid = "cellid"
    var first_lat: Double = 0
    
    var first_long: Double = 0
    
    var first_name: String = "Откуда" {
        didSet {
            frombutton.setTitle(first_name, for: .normal)
        }
    }
    var headcell = "headcell"
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(DrunkHeader.self, forCellReuseIdentifier: headcell)
        tableView.register(AddTaxiTableViewCell.self, forCellReuseIdentifier: cellid)
        tableView.bounces = false
        sendButton.initialize()
        view.addSubview(sendButton)
        label1.initialize()
        label2.initialize()
        UIColourScheme.instance.set(for:self)
        navigationController?.navigationBar.isHidden = false
        sendButton.setAnchor(top: nil, left: tableView.layoutMarginsGuide.leftAnchor, bottom: tableView.layoutMarginsGuide.bottomAnchor, right: tableView.layoutMarginsGuide.rightAnchor, paddingTop: 0, paddingLeft: 15, paddingBottom: 15, paddingRight: 15, width: 15, height: 60)
        sendButton.Title(title: "Заказать")
        sendButton.addTarget(self, action: #selector(makeOrder), for: .touchUpInside)
    }
    
    
    
    @objc func clicked(sender:UIButton) {
        self.tag = sender.tag
        switch sender.tag {
        case 0:
            firstplace = self
        case 1:
            seconplace = self
        default:
            break
        }
        
        let autocompleteController = GMSAutocompleteViewController()
       let filter = GMSAutocompleteFilter()
        filter.country = "KZ"
        autocompleteController.autocompleteFilter = filter
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
        
    }
    
 override   func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    view.addSubview(HeadView)
    tobutton.addTarget(self, action: #selector(clicked(sender:)), for: .touchUpInside)
    frombutton.addTarget(self, action: #selector(clicked(sender:)), for: .touchUpInside)
    navigationController?.navigationBar.barTintColor = maincolor
    HeadView.addSubview(frombutton)
    HeadView.addSubview(tobutton)
    HeadView.backgroundColor = maincolor
    frombutton.backgroundColor = UIColor.white
    tobutton.backgroundColor = UIColor.white
    tobutton.setTitleColor(maincolor, for: .normal)
    frombutton.setTitleColor(maincolor, for: .normal)
    frombutton.setAnchor(top: HeadView.topAnchor, left: HeadView.leftAnchor, bottom: nil, right: HeadView.rightAnchor, paddingTop: 10, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: 50, height: 50)
    tobutton.setAnchor(top: frombutton.bottomAnchor, left: HeadView.leftAnchor, bottom: nil, right: HeadView.rightAnchor, paddingTop: 10, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: 50, height: 50)
    frombutton.setTitle("Откуда", for: .normal)
    frombutton.tag = 0
    tobutton.tag = 1
    tobutton.setTitle("Куда", for: .normal)
    return HeadView
    }
   
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 130
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return menu.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as! AddTaxiTableViewCell
        cell.icon.image = UIImage.init(named: menu[indexPath.row].img)
        cell.textfield.placeholder = menu[indexPath.row].text
        cell.textfield.tag = indexPath.row
        // Configure the cell...
        if cell.textfield.tag == 1 {
            cell.textfield.text = comment
        }
        if cell.textfield.tag == 0 {
            cell.textfield.isUserInteractionEnabled = false
            cell.textfield.text = price
        }
        return cell
    }
 
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        view.addSubview(footerview)
        footerview.addSubview(allView)
        
         swiftcer.setOn(true, animated: true)
        allView.addSubview(img)
        allView.addSubview(label1)
        allView.addSubview(label2)
        allView.addSubview(swiftcer)
        allView.setAnchor(top: img.topAnchor, left: view.leftAnchor, bottom: img.bottomAnchor, right: label2.rightAnchor, paddingTop: 0, paddingLeft:15, paddingBottom: 0, paddingRight: 0)
        img.setAnchor(top: nil, left: allView.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 0,width: 25,height: 25)
        label1.setAnchor(top: nil, left: img.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0)
        label1.text = "АКПП"
        swiftcer.setAnchor(top: nil, left: label1.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 20, paddingRight: 20)
        label2.setAnchor(top: nil, left: swiftcer.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 0)
        label2.text = "МКПП"
        img.image = UIImage.init(named: "icon_transmission")
        let imgcen = img.centerYAnchor.constraint(equalTo: swiftcer.centerYAnchor)
        swiftcer.addTarget(self, action: #selector(switched(switcher:)), for: .valueChanged)
        let center1 = label1.centerYAnchor.constraint(equalTo: swiftcer.centerYAnchor)
        let center2 = label2.centerYAnchor.constraint(equalTo: swiftcer.centerYAnchor)
        let centrview = allView.centerYAnchor.constraint(equalTo: footerview.centerYAnchor)
        NSLayoutConstraint.activate([center1,center2,centrview,imgcen])
        swiftcer.onTintColor = maincolor
        swiftcer.setOn(false, animated: true)
        return footerview
    }
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
    
    
    @objc func switched(switcher:UISwitch){
        switch switcher.isOn {
        case false:
            kpp = 0
        case true:
            kpp = 2
        default:
            break
        }
        print(kpp)
        print(switcher.isOn)
    }
    @objc func makeOrder() {
        if first_lat == 0 && second_lat == 0 {
            let toast = ErrorAlert(title: "", message: "", preferredStyle: .alert)
            toast.show()
        }
        else {
            view.makeToastActivity(.center)
            DrunkMakerOrder.make(lat_a: first_lat, long_a: first_long, lat_b: second_lat, long_b: second_long, comment: comment, kpp: kpp) { (success) in
                if success == true {
                    self.view.hideToastActivity()
                    self.navigationController?.pushViewController(TestViewController(), animated: true)
                }
            }
        
        }
    }

}



extension DrunkTaxiTable: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        viewController.navigationController?.navigationBar.tintColor = maincolor
        switch tag! {
        case 0:
            firstplace?.first_lat = place.coordinate.latitude
            firstplace?.first_long = place.coordinate.longitude
            firstplace?.first_name = place.name
            firstplace?.firstadded()
        case 1:
            seconplace?.second_lat = place.coordinate.latitude
            seconplace?.second_long = place.coordinate.longitude
            seconplace?.second_name = place.name
            seconplace?.secondadded()
        default:
            break
        }
      

        
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
