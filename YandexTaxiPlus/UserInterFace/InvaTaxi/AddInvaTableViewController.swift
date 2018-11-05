//
//  AddInvaTableViewController.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 29.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit

class AddInvaTableViewController: UITableViewController,UITextFieldDelegate {

    var sendButton : UIButton = UIButton()
    var sits : String?
    var price : String?
    var comment : String?
    var time : CLong?
    var datePicker : UIDatePicker = UIDatePicker()
    var headerView: UIView = UIView()
    var fromButton : UITextField = UITextField()
    var toButton : UITextField = UITextField()
    var cellid = "cellid"
    
    var menu = [
        MenuCity(text: "Дата", img: "icon_calendar"),
        MenuCity(text: "Описание", img: "icon_dialog")]
    
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
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField.tag {
       
        case 0:
            DatePickerDialog().show("DatePicker", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .dateAndTime) {
                (date) -> Void in
                if let dt = date {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "MM/dd/yyyy HH:mm:ss"
                    textField.text = formatter.string(from: dt)
                    let vremya = dt.timeIntervalSince1970
                    self.time = CLong(vremya)
                    print(vremya)
                }
            }
        case 1 :
            comment = textField.text
        default:
            break
        }
    }
    @objc func Add() {
        
    }
    
    
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
}

