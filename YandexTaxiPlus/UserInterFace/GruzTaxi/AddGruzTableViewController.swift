//
//  AddGruzTableViewController.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 29.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit
import Toast_Swift





class AddGruzTableViewController: UITableViewController,UITextFieldDelegate {
    
    var sendButton : UIButton = UIButton()
    var to : String!
    var from : String!
    var sits : String!
    var price : String!
    var comment : String!
    var time : CLong!
    var datePicker : UIDatePicker = UIDatePicker()
    var headerView: UIView = UIView()
    var fromButton : UITextField = UITextField()
    var toButton : UITextField = UITextField()
    var cellid = "cellid"
    
    var menu = [
                MenuCity(text: "Цена", img: "icon_by_bonuses"),
                MenuCity(text: "Дата", img: "icon_calendar_gray"),
                MenuCity(text: "Описание груза", img: "icon_dialog")]
    
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
    }

    override func viewWillAppear(_ animated: Bool) {
        UIColourScheme.instance.set(for:self)

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
        
        toButton.placeholder = "Куда?"
        fromButton.placeholder = "Откуда?"
        toButton.backgroundColor = UIColor.white
        fromButton.backgroundColor = UIColor.white
        fromButton.textColor = maincolor
        toButton.textColor = maincolor
        fromButton.textAlignment = .center
        toButton.textAlignment = .center
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
        case 1:
      
            textField.inputView = datePicker
          
        case 0:
            textField.keyboardType = .numberPad
        default:
            break
        }
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        switch textField.tag {
        case 0:
            textField.keyboardType = .numberPad
            price = textField.text
        case 1:
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy HH:mm:ss"
            datePicker.datePickerMode = .dateAndTime
            self.time = datePicker.date.millisecondsSince1970
            textField.text = dateFormatter.string(from: datePicker.date)
        case 2:
            comment = textField.text
        default:
            break

        }
    }
    
    

    
    
    
    func checkEmptyDict(_ dict:[String:Any?]) -> Bool {
        
        for (_,value) in dict {
            if value == nil || value as? String == "" { return true }
        }
        
        return false
    }
    @objc func Add() {
        from = fromButton.text!
        to = toButton.text!
        let params = [
            "token":APItoken.getToken()!,
            "type":"2",
            "comment":comment,
            "start_string":from,
            "price":price,
            "end_string":to,
            "date":time
            ] as [String : Any?]
        print(params)
        let check = checkEmptyDict(params)
        print(check)
        if check == true {
            let error = ErrorAlert(title: "", message: "", preferredStyle: .alert)
            error.show()
     
        }
        else {
            
            EvoMakeOrder.MakeOrder(type: "2", comment: comment!, start: from!, end: to!, price: price, date: String(time!)) { (state) in
                self.view.makeToastActivity(.center)
                
                if state == true {
                    self.view.hideToastActivity()
                    self.view.makeToast("Успешно")
                    self.navigationController?.popViewController(animated: true)
                }
                if state == false {
                    let alert = CustomAlert(title: "", message: "", preferredStyle: .alert)
                    alert.publish = "1"
                    alert.type = "2"
                    alert.title = ""
                    alert.show()
                }
            }
        }
    }

    
    
}
