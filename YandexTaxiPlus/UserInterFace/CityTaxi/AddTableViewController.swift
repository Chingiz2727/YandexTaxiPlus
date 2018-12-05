//
//  AddTableViewController.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 22.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit
import Toast_Swift
class AddTableViewController: UITableViewController,ToCitiesTableViewControllerDelegate,FromCitiesTableViewControllerDelegate,UITextFieldDelegate {
    var sendButton : UIButton = UIButton()
    var sits : String?
    var price : String?
    var comment : String?
    var time : CLong?
    func CityFromData(id: String, region_id: String, name: String, cname: String) {
        self.FromId = id
        self.Fromregion_id = region_id
        self.Fromname = name
        self.Fromcname = cname
    }
    
    func CityToData(id: String, region_id: String, name: String, cname: String) {
        self.id = id
        self.region_id = region_id
        self.name = name
        self.cname = cname
    }
     var datePicker : UIDatePicker = UIDatePicker()
    var id : String?
    var region_id: String?
    var name : String?
    var cname :String? {
        didSet {
            toButton.setTitle("\(cname!),\(name!)", for: .normal)
        }
    }
   
    var FromId : String?
    var Fromregion_id : String?
    var Fromname : String?
    var Fromcname :String? {
        didSet {
            fromButton.setTitle("\(Fromcname!),\(Fromname!)", for: .normal)
        }
    }
    var headerView: UIView = UIView()
    var fromButton : UIButton = UIButton()
    var toButton : UIButton = UIButton()
    var cellid = "cellid"
    
    var menu = [MenuCity(text: "Количество мест", img: "icon_seat"),
                MenuCity(text: "Цена за одного пассажира", img: "icon_by_bonuses"),
                MenuCity(text: "Дата", img: "icon_calendar_gray"),
                MenuCity(text: "Комментарий,пожелания", img: "icon_dialog")]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        tableView.register(AddTaxiTableViewCell.self, forCellReuseIdentifier: cellid)
        tableView.bounces = false
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(sendButton)
        sendButton.setAnchor(top: nil, left: tableView.layoutMarginsGuide.leftAnchor, bottom: tableView.layoutMarginsGuide.bottomAnchor, right: tableView.layoutMarginsGuide.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 30, paddingRight: 10, width: 0, height: 60)
        sendButton.addTarget(self, action: #selector(Add), for: .touchUpInside)
        sendButton.backgroundColor = maincolor
        sendButton.setTitle("Оставить заявку", for: .normal)
        sendButton.layer.cornerRadius = 15
        fromButton.addTarget(self, action: #selector(sender(sender:)), for: .touchUpInside)
        toButton.addTarget(self, action: #selector(sender(sender:)), for: .touchUpInside)
    }
    override func viewWillAppear(_ animated: Bool) {
        UIColourScheme.instance.set(for:self)

    }
    
    @objc func sender(sender:UIButton) {
       let gonext = CitiesTableViewController()
        switch sender.tag {
        case 0:
            gonext.delegateFrom = self
        case 1:
            gonext.delegateto = self
        default:
            break
        }
        gonext.tag = sender.tag
        navigationController?.present(gonext, animated: true, completion: nil)
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 130
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
  override  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    view.addSubview(headerView)
    headerView.addSubview(fromButton)
    fromButton.tag = 0
    headerView.addSubview(toButton)
    toButton.tag = 1
    headerView.setAnchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 90)
    headerView.addSubview(fromButton)
    fromButton.setAnchor(top: headerView.topAnchor, left: headerView.leftAnchor, bottom: nil, right: headerView.rightAnchor, paddingTop: 2, paddingLeft: 5, paddingBottom: 0, paddingRight: 5, width: 0, height: 40)
    toButton.setAnchor(top: fromButton.bottomAnchor, left: headerView.leftAnchor, bottom: nil, right: headerView.rightAnchor, paddingTop: 2, paddingLeft: 5, paddingBottom: 0, paddingRight: 5, width: 0, height: 40)
    
    toButton.setTitle("Куда?", for: .normal)
    fromButton.setTitle("Откуда?", for: .normal)
    toButton.backgroundColor = UIColor.white
    fromButton.backgroundColor = UIColor.white
    fromButton.setTitleColor(maincolor, for: .normal)
    toButton.setTitleColor(maincolor, for: .normal)
    headerView.backgroundColor = maincolor
    return headerView
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
        cell.icon.image = UIImage(named: menu[indexPath.row].img)
        cell.textfield.placeholder = menu[indexPath.row].text
        cell.selectionStyle = .none
        cell.textfield.delegate = self
        cell.textfield.tag = indexPath.row
        return cell
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 2:
            textField.inputView = datePicker
        case 0:
            textField.keyboardType = .numberPad
        case 1:
            textField.keyboardType = .numberPad
        default:
            break
        }
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        switch textField.tag {
        case 1:
            textField.keyboardType = .numberPad
            price = textField.text
        case 2:
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy HH:mm:ss"
            datePicker.datePickerMode = .dateAndTime
            self.time = datePicker.date.millisecondsSince1970
            textField.text = dateFormatter.string(from: datePicker.date)
        case 3:
            comment = textField.text
        case 0:
            sits = textField.text
        default:
            break
            
        }
    }
    
    
    
    @objc func Add() {
        let params = ["token":APItoken.getToken()!,
                      "type":"\(1)",
                      "seats_number":sits,
                      "start_id":FromId,
                      "end_id":id,
                      "price":price,
                      "date":"\(time ?? 0)"]
        print(params)
  
        if params.values.filter({ $0 == nil }).isEmpty
        {
            let param = ["token":APItoken.getToken()!,
                          "type":"\(1)",
                "seats_number":sits!,
                "start_id":FromId!,
                "end_id":id!,
                "price":price!,
                "date":"\(time ?? 0)"]
            print(param)
            AddSpecificOrder.City(params: param as [String:Any]) { (success, failure) in
                            if success {
                                self.view.hideToastActivity()
                                self.navigationController?.popViewController(animated: true)
                            }
                            if failure {
                                let alert = CustomAlert(title: "", message: "", preferredStyle: .alert)
                                alert.publish = "1"
                                alert.type = "1"
                                alert.title = ""
                                alert.show()
                            }
                        }
            }
        else
        {
            let error = ErrorAlert(title: "", message: "", preferredStyle: .alert)
            error.show()
            
        }
      
     
      
    }
 

}

