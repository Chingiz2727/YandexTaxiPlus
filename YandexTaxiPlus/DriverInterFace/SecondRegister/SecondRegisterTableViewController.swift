//
//  DriverRegisterTableViewController.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 24.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit

class SecondRegisterTableViewController: UITableViewController,UITextFieldDelegate,CarModelDelegate,CarMarkDelegate,JKDropDownDelegate {
    func remove() {
        car_mark_name = ""
    }
    
  
    
    var car_mark_name: String = "Марка Машины"
    
    var car_model_id: Int = 0
    
    var car_model_name: String = "Модель машины"
    
    let fram = UIView()

    
    var cellid = "cellid"
    var cellid5 = "cellid5"
    var cellid2 = "cellid2"
    var cellid3 = "cellid3"
    var cellid4 = "cellid4"
  
    var sits : String?
    var number_car : String?
    var create_year : String?
    var id : Int?
    var typeID : String?
    
    var facilities = [Facilities]()
    var fac = Array<Int>()
    var expanded = false
    
    
    var button : UIButton = UIButton()
    var buttonFrame : CGRect?
    var dropDownObject:JKDropDown!
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)

    }
    
    let registerButton = UIButton()
    
    var option3 = ["Марка автомашины","Модель автомашины"]
    var ids = ["1","2","1","3","4"]
    var item = ["Такси","Грузоперевозка","Межгород","Эвакуатор","Инва Такси"]
    var img = ["icon_taxi","icon_cargo","icon_cities_taxi","icon_evo","icon_inva"]
    var option2 = ["Количество мест","Гос номер","Год выпуска"]
    override func viewDidLoad() {
        super.viewDidLoad()
        get()
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barTintColor = maincolor
        navigationController?.navigationBar.isTranslucent = false

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
        if indexPath.section == 1 {
           return 0
        }
        return 60
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
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
        switch section {
        case 0:
            return option3.count
        case 2:
            return option2.count
        case 3:
            return facilities.count
        default:
            break
        }
        return 0
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 1:
            return 60
        default:
            break
        }
        return 0
    }
    
  
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 1:
            view.addSubview(fram)
            fram.addSubview(button)
            button.setTitle("Выберите машину", for: .normal)
            button.setAnchor(top: fram.topAnchor, left: fram.leftAnchor, bottom: fram.bottomAnchor, right: fram.rightAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 5, paddingRight: 10)
            button.addTarget(self, action: #selector(tapsOnButton), for: .touchUpInside)
            button.setTitleColor(maincolor, for: .normal)
            button.layer.cornerRadius = 10.0
            button.layer.borderColor = maincolor.cgColor
            button.layer.borderWidth = 1
            buttonFrame = view.convert(fram.frame, to: view)
            return fram
        default:
            break
        }
        return nil
    }
    @objc func tapsOnButton() {
        if dropDownObject == nil {
           
            dropDownObject = JKDropDown()
            dropDownObject.dropDelegate = self
            dropDownObject.showJKDropDown(senderObject: button, height: CGFloat(img.count*50), arrayList: item , arrayImages: img,buttonFrame:buttonFrame!,direction : "down")
            view.addSubview(dropDownObject)
            
        }
        else {
            dropDownObject.hideDropDown(senderObject: button,buttonFrame:buttonFrame!)
            dropDownObject = nil
        }
    }
    func recievedSelectedValue(name: String, imageName: String) {
        print(name)
        let index = item.firstIndex(of: name)
        self.typeID = ids[index!]
        dropDownObject.hideDropDown(senderObject: button, buttonFrame: buttonFrame!)
        dropDownObject = nil
        button.setTitle(name, for: .normal)
        var imageView : UIImageView?
        imageView = UIImageView(image: UIImage(named:imageName))
        imageView?.frame = CGRect(x: 25, y: 5, width: 40, height: 40)
        imageView?.contentMode = .scaleAspectFit
        button.addSubview(imageView!)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellid3) as! DriverRegisterTableViewCell2
            let text = cell.TextField.text
            cell.TextField.tag  = indexPath.row + 2
            let tag = cell.TextField.tag
            switch tag {
            case 2 :
                self.sits = text
            case 3:
                self.number_car = text
            case 4:
                self.create_year = text
            default:
                break
            }
            cell.TextField.delegate = self
            cell.TextField.placeholder = option2[indexPath.row]
            cell.selectionStyle = .none
            return cell
        }
        
        if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellid4) as! CheckBoxTableViewCell
            cell.label.text = facilities[indexPath.row].name
            cell.check.tag = facilities[indexPath.row].id
            cell.check.addTarget(self, action: #selector(chec(check:)), for: .valueChanged)
            cell.selectionStyle = .none
            return cell
        }
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellid5) as! CarInfoCell
            cell.ButtonClick.setTitle(option3[indexPath.row], for: .normal)
            cell.ButtonClick.setTitleColor(maincolor, for: .normal)
            cell.ButtonClick.addTarget(self, action: #selector(sender(sender:)), for: .touchUpInside)
            cell.ButtonClick.isEnabled = true
            cell.ButtonClick.tag = indexPath.row
            switch cell.ButtonClick.tag {
            case 0:
                cell.ButtonClick.setTitle(car_model_name, for: .normal)
            case 1:
                cell.ButtonClick.setTitle(car_mark_name, for: .normal)
                
            default:
                break
            }
           
            return cell
        }
        
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        return cell
    }
    
    
    @objc func sender(sender:UIButton) {
        let setting = GetCarSettingsTableViewController()
        switch sender.tag {
        case 0:
            setting.carmodel = self
        case 1:
            setting.carmark = self
            setting.id = car_model_id
        default:
            break
        }
        setting.type = sender.tag
        self.navigationController?.pushViewController(setting, animated: true)
    }
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 3 {
            return 60
        }
        return 0
    }
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 3 {
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
        let car_model = "\(car_mark_name ) \(car_model_name)"
        //        Register.register(gender: gender_id!, car_number: number_car!, car_model: car_model, year_of_birth: 1998, car_year: create_year!, seats_num: sits!, fac: fac, type: typeID!)
        let params = [
            "token":APItoken.getToken(),
            "car_number":number_car,
            "car_model":car_model,
            "year_of_birth":1998,
            "car_year":create_year,
            "seats_number":sits,
            "facilities":fac,
            "type":typeID
            ] as [String : Any?]
        
        let check = checkEmptyDict(params)
        switch check {
        case true:
            view.makeToast("Заполните все поля")
        case false:
            UserInformation.shared.getinfo { (info) in
                self.view.makeToastActivity(.center)
                Register.register(gender: (info.user?.genderID!)!, car_number: self.number_car!, car_model: "\(car_model)", year_of_birth: 1900, car_year: self.create_year!, seats_num: self.sits!, fac: self.fac, type: self.typeID!, completion: { (success) in
                    if success == true {
                        self.view.hideToastActivity()
                        self.navigationController?.popViewController(animated: true)
                    }
                    else {
                      self.view.makeToast("Ошибка")
                    }
                })
            }
            
            
        }
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        let text = textField.text
        switch textField.tag {
        case 2:
            self.sits = text
        case 3:
            self.number_car = text
        case 4:
            self.create_year = text
        default:
break        }
    }
    
    @objc func chec(check:CheckboxButton) {
        if check.on {
            self.fac.append(check.tag)
        }
        else {
            if let index = self.fac.index(of: check.tag) {
                self.fac.remove(at: index)
            }
        }
        
    }
    
    func checkEmptyDict(_ dict:[String:Any?]) -> Bool {
        
        for (_,value) in dict {
            if value == nil || value as? String == "" { return true }
        }
        
        return false
        
    }
}
