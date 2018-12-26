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
    var icon : String?
    init (id:String,name:String,icon:String)
    {
        self.icon = icon
        self.id = id
        self.name = name
    }
}



class DriverRegisterTableViewController: UITableViewController,UITextFieldDelegate,CarModelDelegate,CarMarkDelegate,JKDropDownDelegate {
    func remove() {
        car_mark_name = ""
    }
    
    var car_mark_name: String = "Марка Машины"
    
    var car_model_id: Int = 0
    
    var car_model_name: String  = "Модель машины"
    var cellid = "cellid"
    var cellid5 = "cellid5"
    var cellid2 = "cellid2"
    var cellid3 = "cellid3"
    var cellid4 = "cellid4"
  
 
    

    var email: String!
    var sits : String!
    var number_car : String!
    var create_year : String!
    var typeID : String?
    var gender_id : Int?
    var facilities = [Facilities]()
    var fac = Array<String>()
    var expanded = false
    var avatar : UIImageView = UIImageView()
    
    
    
    var button : UIButton = UIButton()
    var buttonFrame : CGRect?
    var dropDownObject:JKDropDown!
    
    
    
    let registerButton = UIButton()
    var maleButton = MainButton()
    var femaleButton = MainButton()
    let fram = UIView()

    
    
    var ids = ["1","2","1","3","4"]
    var item = ["Такси","Грузоперевозка","Межгород","Эвакуатор","Инва Такси"]
    var img = ["icon_taxi","icon_cargo","icon_cities_taxi","icon_evo","icon_inva"]
    
    
    var option = ["Имя","Номер","E-mail"]
    var option3 = ["Марка автомашины","Модель автомашины"]

    var taxies = [Taxi(id: "1", name: "Такси", icon: "icon_taxi"),
                  Taxi(id: "2", name: "Грузоперевозка", icon: "icon_cargo"),
                  Taxi(id: "1", name: "Межгород", icon: "icon_cities_taxi"),
                  Taxi(id: "3", name: "Эвакуатор", icon: "icon_evo"),
                  Taxi(id: "4", name: "Инва Такси", icon: "icon_inva")]
    
    var option2 = ["Количество мест","Гос номер","Год выпуска"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        get()
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barTintColor = maincolor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.register(DriverRegisterTableViewCell.self, forCellReuseIdentifier: cellid)
        tableView.register(DriverRegisterTableViewCell2.self, forCellReuseIdentifier: cellid3)
        tableView.register(CheckBoxTableViewCell.self, forCellReuseIdentifier: cellid4)
        tableView.register(ButtonsTableViewCell.self, forCellReuseIdentifier: cellid2)
        tableView.register(CarInfoCell.self, forCellReuseIdentifier: cellid5)
        tableView.separatorStyle = .none
        UIColourScheme.instance.set(for:self)

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
            return option.count
        case 1:
            return option3.count
        case 2:
            return img.count
        case 3:
            return option2.count
        case 4:
            return facilities.count
        default:
            break
        }
        return 0
    }
    
   override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    switch section {
    case 0:
        return 100
    case 2:
        return 60
    default:
        break
    }
        return 0
    }
    
    
 
    

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 2:
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
        case 0:
            view.addSubview(avatar)
            avatar.setAnchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 100, height: 100)
            avatar.layer.cornerRadius = 50
            avatar.image = UIImage(named: "zhan")
            avatar.clipsToBounds = true
            avatar.contentMode = .scaleAspectFill
            let centerXavatar = avatar.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            NSLayoutConstraint.activate([centerXavatar])
            return avatar
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
        var index = item.firstIndex(of: name)
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
        if section == 4 {
            return 60
        }
        if section == 0 {
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
        if section == 0 {
            let GenderView = UIView()
            view.addSubview(GenderView)
            maleButton.initialize()
            femaleButton.initialize()
            GenderView.addSubview(femaleButton)
            GenderView.addSubview(maleButton)
            femaleButton.backgroundColor = UIColor.white
            maleButton.backgroundColor = UIColor.white
            femaleButton.Title(title: "Женский")
            maleButton.Title(title: "Мужской")
            maleButton.setTitleColor(maincolor, for: .normal)
            femaleButton.setTitleColor(maincolor, for: .normal)
            femaleButton.tag = 1
            maleButton.tag = 2
            maleButton.setAnchor(top: GenderView.topAnchor, left: GenderView.leftAnchor, bottom: GenderView.bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 15, paddingBottom: 5, paddingRight: 15, width: view.frame.width/2-20, height: 0)
            femaleButton.setAnchor(top: GenderView.topAnchor, left: nil, bottom: GenderView.bottomAnchor, right: GenderView.rightAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 5, paddingRight: 15, width: view.frame.width/2-20, height: 0)
            femaleButton.addTarget(self, action: #selector(gender(sender:)), for: .touchUpInside)
            maleButton.addTarget(self, action: #selector(gender(sender:)), for: .touchUpInside)
            
            return GenderView
        }
        return UIView()
    }
    @objc func gender(sender:UIButton) {
        switch sender.tag {
        case 1:
            femaleButton.backgroundColor = maincolor
            femaleButton.setTitleColor(UIColor.white, for: .normal)
            maleButton.backgroundColor = UIColor.white
            maleButton.setTitleColor(maincolor, for: .normal)
        case 2:
            maleButton.backgroundColor = maincolor
            maleButton.setTitleColor(UIColor.white, for: .normal)
            femaleButton.backgroundColor = UIColor.white
            femaleButton.setTitleColor(maincolor, for: .normal)
        default:
            break
        }
        
        self.gender_id = sender.tag
        
        
        
        
    }
  @objc  func register() {
        let car_model = "\(car_mark_name ) \(car_model_name)"
//        Register.register(gender: gender_id!, car_number: number_car!, car_model: car_model, year_of_birth: 1998, car_year: create_year!, seats_num: sits!, fac: fac, type: typeID!)
 
    let params = [
        "token":APItoken.getToken(),
        "gender":gender_id,
        "car_number":number_car,
        "car_model":car_model_id,
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
      view.makeToastActivity(.center)
        Register.register(gender: gender_id!, car_number: number_car!, car_model: "\(car_model)", year_of_birth: 1900, car_year: create_year!, seats_num: sits!, fac: fac, type: typeID!) { (success) in
            if success == true {
                self.view.hideToastActivity()
                guard let window = UIApplication.shared.keyWindow else {return}
                
                window.makeKeyAndVisible()
                window.rootViewController = UINavigationController.init(rootViewController: SessionOpenViewController())
                
            }
            else {
                self.view.hideToastActivity()
                self.view.makeToast("Ошибка")
            }
        }

   
    }
    
    }
 
   
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        let text = textField.text!
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
            break
        }
    }
   @objc func chec(check:CheckboxButton) {
        if check.on {
            self.fac.append(String(check.tag))
        }
        else {
            if let index = self.fac.index(of: String(check.tag)) {
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
