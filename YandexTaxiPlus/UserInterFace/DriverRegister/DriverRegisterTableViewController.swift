//
//  DriverRegisterTableViewController.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 24.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit
class Taxi {
    var id : String?
    var name: String?
    init (id:String,name:String)
    {
        self.id = id
        self.name = name
    }
}
class DriverRegisterTableViewController: UITableViewController,UITextFieldDelegate,CarModelDelegate,CarMarkDelegate {
    func CarMark(Id: Int, Name: String) {
    self.carMark = Name
        
    }
    
    func CarModel(Id: Int, Name: String) {
        self.id = Id
        self.carModel = Name
    }
    
    var cellid = "cellid"
    var cellid5 = "cellid5"
    var cellid2 = "cellid2"
    var cellid3 = "cellid3"
    var cellid4 = "cellid4"
    var email: String?
    var carMark: String? = "Марка Машины"
    var carModel  : String? = "Модель машины"
    var sits : String?
    var number_car : String?
    var create_year : String?
    var id : Int?
    var typeID : String?
    
    var facilities = [Facilities]()
    var fac = Array<Int>()
    var expanded = false
    var avatar : UIImageView = UIImageView()
    var button : UIButton = UIButton()
    let registerButton = UIButton()

    var option = ["Имя","Номер","E-mail"]
    var option3 = ["Марка автомашины","Модель автомашины"]

    var img = ["icon_taxi","icon_cargo","icon_cities_taxi","icon_evo","icon_inva"]
    var taxies = [Taxi(id: "1", name: "Такси"),
                  Taxi(id: "5", name: "Грузоперевозка"),
                  Taxi(id: "4", name: "Межгород"),
                  Taxi(id: "6", name: "Эвакуатор"),
                  Taxi(id: "5", name: "Инва Такси")]
    var option2 = ["Количество мест","Гос номер","Год выпуска"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        get()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.register(DriverRegisterTableViewCell.self, forCellReuseIdentifier: cellid)
        tableView.register(DriverRegisterTableViewCell2.self, forCellReuseIdentifier: cellid3)
        tableView.register(CheckBoxTableViewCell.self, forCellReuseIdentifier: cellid4)
        tableView.register(ButtonsTableViewCell.self, forCellReuseIdentifier: cellid2)
        tableView.register(CarInfoCell.self, forCellReuseIdentifier: cellid5)
        tableView.separatorStyle = .none
    }
   override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.section == 2 {
        if expanded {
            return 60
        }
        else {
            return 0
        }
    }
        return 60
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 5
    }
    override func viewWillAppear(_ animated: Bool) {
        
        self.tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        print(fac)
        if indexPath.section == 2 {
            button.setTitle(taxies[indexPath.row].name!, for: .normal)
            self.typeID = taxies[indexPath.row].id!
            toggleSection()
        }
    }
    func get() {
        DriverRegisterApi.getOption { (facilities:[Facilities]!) in
            if let facilities = facilities {
                self.facilities = facilities
                self.tableView.reloadData()
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 4 {
            return facilities.count
        }
        if section == 2 {
            return img.count
        }
        if section == 3 {
            return option2.count
        }
        if section == 1 {
            return option3.count
        }
        if section == 0 {
            return option.count

        }
        return 0
    }
   override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    if section == 2 {
        return 30
    }
    if section == 3 {
        return 0
    }
    if section == 4 {
        return 0
    }
    if section == 1 {
        return 0
    }
        return 100
    }
    
    @objc func push(sender:UIButton)
    {
        sender.tintColor = UIColor.brown
        
    }
   @objc func toggleSection() {
        expanded = !expanded
        tableView.beginUpdates()
        for i in 0..<img.count {
            tableView.reloadRows(at: [IndexPath(row: i, section: 2)], with: .automatic)
        }
        tableView.endUpdates()
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 2 {
            view.addSubview(button)
            button.setTitle("Выберите машину", for: .normal)
            button.addTarget(self, action: #selector(toggleSection), for: .touchUpInside)
            button.backgroundColor = maincolor
            return button
        }
        if section == 3 {
            return nil
        }
        if section == 4 {
            return nil
        }
        if section == 1 {
            return nil
        }
        view.addSubview(avatar)
        avatar.setAnchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 100, height: 100)
        avatar.layer.cornerRadius = 50
        avatar.image = UIImage(named: "zhan")
        avatar.clipsToBounds = true
        avatar.contentMode = .scaleAspectFill
        let centerXavatar = avatar.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        NSLayoutConstraint.activate([centerXavatar])
        return avatar
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 2 && expanded {
            let cell2 = tableView.dequeueReusableCell(withIdentifier: cellid2) as! ButtonsTableViewCell
            cell2.TaxiLabel.textAlignment = .left
            cell2.TaxiLabel.text = taxies[indexPath.row].name
            cell2.TaxiButton.image = UIImage(named: img[indexPath.row])
            return cell2
        }
        if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellid3) as! DriverRegisterTableViewCell2
            let text = cell.TextField.text
            cell.TextField.tag  = indexPath.row + 3
            let tag = cell.TextField.tag
            switch tag {
            case 3 :
                self.sits = text
            case 4:
                self.number_car = text
            case 5:
                self.create_year = text
            default:
                print("")
            }
            cell.TextField.delegate = self
            cell.TextField.placeholder = option2[indexPath.row]
            cell.selectionStyle = .none
            return cell
        }
        
        if indexPath.section == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellid4) as! CheckBoxTableViewCell
            cell.label.text = facilities[indexPath.row].name
            cell.check.tag = facilities[indexPath.row].id
            cell.check.addTarget(self, action: #selector(chec(check:)), for: .valueChanged)
            cell.selectionStyle = .none
            return cell
        }
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellid5) as! CarInfoCell
            cell.ButtonClick.setTitle(option3[indexPath.row], for: .normal)
            cell.ButtonClick.setTitleColor(maincolor, for: .normal)
            cell.ButtonClick.isEnabled = true
            switch cell.ButtonClick.tag {
            case 0:
                cell.ButtonClick.setTitle(carModel, for: .normal)
            case 1:
                cell.ButtonClick.setTitle(carMark, for: .normal)

            default:
                break
            }
            cell.ButtonClick.tag = indexPath.row
            
            cell.ButtonClick.addTarget(self, action: #selector(sender(sender:)), for: .touchUpInside)
            cell.selectionStyle = .none
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid) as! DriverRegisterTableViewCell
        cell.TextField.tag = indexPath.row
        UserInformation.getinfo { (info) in
            print(info.user.name)
            switch cell.TextField.tag {
            case 0:
                cell.TextField.isEnabled = false
                cell.TextField.text = info.user.name!
            case 1:
                cell.TextField.isEnabled = false
                cell.TextField.text = info.user.phone!
            case 2 :
                cell.TextField.placeholder = "Email"
                cell.TextField.isEnabled = true
               self.email = cell.TextField.text
            default:
                print("")
            }
        }
      
        cell.selectionStyle = .none
        return cell
    }
   
    @objc func sender(sender:UIButton) {
        let setting = GetCarSettingsTableViewController()
        print(sender.tag)
        switch sender.tag {
        case 0:
            
            setting.carmodel = self
        case 1:
            setting.carmark = self
            setting.id = id
        default:
            break
        }
        setting.type = sender.tag

        self.present(setting, animated: true, completion: nil)
    }
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 4 {
            return 60
        }
        return 0
    }
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 4 {
            view.addSubview(registerButton)
            registerButton.backgroundColor = maincolor
            registerButton.setTitle("Регистрация", for: .normal)
            registerButton.setTitleColor(UIColor.white, for: .normal)
            registerButton.addTarget(self, action: #selector(register), for: .touchUpInside)
            return registerButton
        }
        return UIView()
    }
  @objc  func register() {
    let car_model = "\(carMark ?? "" ) \(carModel ?? "")"
    
        Register.register(gender: 2, car_number: number_car!, car_model: car_model, year_of_birth: 1998, car_year: create_year!, seats_num: sits!, fac: fac, type: typeID!)
//    guard let window = UIApplication.shared.keyWindow else {return}
//    window.makeKeyAndVisible()
//    (window.rootViewController as? UINavigationController)?.pushViewController(SessionOpenViewController(), animated: true)
    
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = textField.text
        switch textField.tag {
        case 2:
            self.email = text
        case 3:
            self.sits = text
        case 4:
            self.number_car = text
        case 5:
            self.create_year = text
        default:
            print("")
        }
        return true
    }
   @objc func chec(check:CheckboxButton) {
        if check.on {
            self.fac.append(check.tag)
            print(self.fac)
        }
        else {
            if let index = self.fac.index(of: check.tag) {
                self.fac.remove(at: index)
            }
    }
    
    }

}
