//
//  DriverMenuTableViewController.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 30.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit
import Alamofire
import SideMenu
import Social
class DriverMenuTableViewController: UITableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    var outview : UIView = UIView()
    var outbutton : UIButton = UIButton()
    var cellid = "cellid"
    var headerid = "headerid"
    var titlemenu = [MenuModule(menu: "", img: "", id: "", contains: false)]
    let window = UIApplication.shared.keyWindow
    var sidemenu = SideMenuManager()
    fileprivate var image : UIImage?
    fileprivate var name : String?
    fileprivate var phone : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = false
        tableView.separatorStyle = .none
        tableView.register(MainPageHeader.self, forCellReuseIdentifier: headerid)
        navigationController?.isNavigationBarHidden = true
        UIColourScheme.instance.set(for:self)
        tableView.register(MainPageMenuCell.self, forCellReuseIdentifier: cellid)
        fetchdata()
        var ColorMenu = ""
        if APItoken.getColorType() == 0 {
            ColorMenu = "Ночной режим"
        }
        else {
            ColorMenu = "Дневной режим"
        }
        let menu = [MenuModule(menu: "Открытие смены", img: "clock-1", id: "1", contains: true),
                    MenuModule(menu: "Текущий заказ", img: "icon_main", id: "2", contains: true),
                    MenuModule(menu: "Город", img: "icon_taxi", id: "2", contains: true),
                    MenuModule(menu: "Межгород", img: "icon_cities_taxi", id: "2", contains: true),
                    MenuModule(menu: "Грузоперевозки", img: "icon_cargo", id: "2", contains: true),
                    MenuModule(menu: "Эвакуатор", img: "icon_evo", id: "2", contains: true),
                    MenuModule(menu: "Инва Такси", img: "icon_inva", id: "2", contains: true),
                    MenuModule(menu: "История поездок", img: "wall-clock", id: "2", contains: true),
                    MenuModule(menu: "Монеты", img: "icon_by_bonuses", id: "2", contains: true),
                    MenuModule(menu: "Новости", img: "ic_news", id: "2", contains: true),
                    MenuModule(menu: "Режим клиента", img: "icon_switch", id: "2", contains: true),
                    MenuModule(menu: "Настройки", img: "settings-6", id: "2", contains: true),
                    MenuModule(menu: ColorMenu, img: "view", id: "2", contains: true),
                    MenuModule(menu: "Поделиться", img: "icon_share", id: "2", contains: true)
        ]
        self.titlemenu = menu
        self.tableView.reloadData()
    }
  
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
 
    }
 
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 70
        }
        return 200
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let head = tableView.dequeueReusableCell(withIdentifier: headerid) as! MainPageHeader
        head.avatarImageView.isUserInteractionEnabled = true
        let gest = UITapGestureRecognizer.init(target: self, action: #selector(sec))
        head.avatarImageView.addGestureRecognizer(gest)
         head.nameLabel.text = name
            head.phone.text = phone
        head.avatarImageView.image = image
            sendPushId.send(completion: { (info, type) in
                if let rating = info.rating {
                    GetDriverAvatar.get(rating: rating, star: info.stars!, completion: { (avatars) in
                        head.starsAvatar.image = UIImage.init(named: avatars)
                        
                    })
                }
              
                
            })
        
        if section == 1 {
            view.addSubview(outview)
            outview.addSubview(outbutton)
            outbutton.setAnchor(top: outview.topAnchor, left: outview.leftAnchor, bottom: outview.bottomAnchor, right: outview.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10)
            outbutton.setTitle("Выйти", for: .normal)
            outbutton.layer.cornerRadius = 10
            outbutton.backgroundColor = #colorLiteral(red: 0.8784313725, green: 0.2588235294, blue: 0.368627451, alpha: 1)
            outbutton.addTarget(self, action: #selector(remove), for: .touchUpInside)
            return outview
        }
        return head
    }
    fileprivate func fetchdata() {
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            sendPushId.send(completion: { (info, type) in
                let url = "http://185.236.130.126/profile/uploads/avatars/\(info.avatar ?? "")"
                Alamofire.request(url).responseJSON(completionHandler: { (response) in
                    DispatchQueue.main.async {
                        if let data = response.data {
                            self.image = UIImage(data: data)
                        }
                    }
                })
            })
        }
        queue.async {
            UserInformation.shared.getinfo(completion: { (info) in
                if let name = info.user?.name {
                    DispatchQueue.main.async {
                        self.name = name
                    }
                }
                if let phone = info.user?.phone {
                    DispatchQueue.main.async {
                        self.phone = phone
                    }
                }
            })
        }
    }
    
    @objc func sec() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        picker.delegate = self
        self.present(picker,animated: true,completion:nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        tableView.reloadData()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedimage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.picker_image = editedimage
        } else if let originalImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.picker_image = originalImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    var picker_image : UIImage? {
        didSet {
            MakePhoto.createPhoto(photo: picker_image!) { (error, success) in
                print("error")
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 1 {
            return 0
        }
        return titlemenu.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as! MainPageMenuCell
        GetAmount.get { (amount) in
            
            switch indexPath.row {
            case 2:
                cell.countlabel.text = amount.taxi!
                cell.countlabel.backgroundColor = #colorLiteral(red: 0.8784313725, green: 0.2588235294, blue: 0.368627451, alpha: 1)
                
            case 3 :
                cell.countlabel.text = amount.mejgorod!
                cell.countlabel.backgroundColor = #colorLiteral(red: 0.8784313725, green: 0.2588235294, blue: 0.368627451, alpha: 1)
            case 6:
                cell.countlabel.text = amount.inva!
                cell.countlabel.backgroundColor = #colorLiteral(red: 0.8784313725, green: 0.2588235294, blue: 0.368627451, alpha: 1)
                
            case 4:
                cell.countlabel.text = amount.gruzotaxi!
                cell.countlabel.backgroundColor = #colorLiteral(red: 0.8784313725, green: 0.2588235294, blue: 0.368627451, alpha: 1)
                
            case 5:
                cell.countlabel.text = amount.ekavuator!
                cell.countlabel.backgroundColor = #colorLiteral(red: 0.8784313725, green: 0.2588235294, blue: 0.368627451, alpha: 1)
                
            default:
                break
            }
        }
        // Configure the cell...
        cell.img.image = UIImage(named: titlemenu[indexPath.row].img)
        cell.label.text = titlemenu[indexPath.row].menu
        if APItoken.getColorType() == 0 {
            cell.img.setImageColor(color: maincolor)
            cell.label.textColor = maincolor
        }
        else {
            cell.img.setImageColor(color: UIColor.white)
cell.label.textColor = UIColor.white
        }
        
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 13:
         GetReferal.get { (referal) in
            let toshare = [referal?.link!]
            let activity = UIActivityViewController(activityItems: toshare, applicationActivities: nil)
            activity.popoverPresentationController?.sourceView = self.view
            activity.excludedActivityTypes = [UIActivity.ActivityType.airDrop,UIActivity.ActivityType.mail,UIActivity.ActivityType.message,UIActivity.ActivityType.postToFacebook,UIActivity.ActivityType.postToTwitter,UIActivity.ActivityType.copyToPasteboard]
            self.present(activity, animated: true, completion: nil)
         }
            
        default:
            dismiss(animated: true, completion: nil)
            PushDriver.push(index: indexPath)
        }

    }
    @objc func remove() {
        PushDriver.Exit()
    }
}
class PushDriver : UISideMenuNavigationController {
    let customSideMenuManager = SideMenuManager()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        sideMenuManager = customSideMenuManager
    }

    class func push (index:IndexPath){
        guard let window = UIApplication.shared.keyWindow else {return}
        let fuull = FullChatsTableViewController()
        switch  index.row {
        case 0:
            (window.rootViewController as? UINavigationController)?.pushViewController(SessionOpenViewController(), animated: true)
        case 1:
            (window.rootViewController as? UINavigationController)?.pushViewController(DriverMapViewController(), animated: true)
        case 2:
           
            CheckCarContains.check(type: "1") { (yes, no) in
                if yes {
                     (window.rootViewController as? UINavigationController)?.pushViewController(TaxiOrdersTableViewController(), animated: true)
                }
                else {
         (window.rootViewController as? UINavigationController)?.pushViewController(SecondRegisterTableViewController(), animated: true)                }
            }
        case 3:
            CheckCarContains.check(type: "1") { (yes, no) in
                if yes {
                    (window.rootViewController as? UINavigationController)?.pushViewController(CityTaxi(), animated: true)
                }
                else {
                    (window.rootViewController as? UINavigationController)?.pushViewController(SecondRegisterTableViewController(), animated: true)                }
            }
          
            
        case 4:
            //Gruz
            CheckCarContains.check(type: "2") { (yes, no) in
                if yes {
                    fuull.type = 2
                    (window.rootViewController as? UINavigationController)?.pushViewController(fuull, animated: true)
                }
                else {
                    (window.rootViewController as? UINavigationController)?.pushViewController(SecondRegisterTableViewController(), animated: true)                }
            }
        case 5:
            //EVo
            CheckCarContains.check(type: "3") { (yes, no) in
                if yes {
                    fuull.type = 3
                    (window.rootViewController as? UINavigationController)?.pushViewController(fuull, animated: true)
                }
                else {
         (window.rootViewController as? UINavigationController)?.pushViewController(SecondRegisterTableViewController(), animated: true)                }
            }
        case 6:
            ///Inva
            CheckCarContains.check(type: "4") { (yes, no) in
                if yes {
                    fuull.type = 4
                   (window.rootViewController as? UINavigationController)?.pushViewController(fuull, animated: true)
                }
                else {
                    (window.rootViewController as? UINavigationController)?.pushViewController(SecondRegisterTableViewController(), animated: true)
                    
                }
            }
        case 7:
            (window.rootViewController as? UINavigationController)?.pushViewController(HistoryTableViewController(), animated: true)
        case 8:
            (window.rootViewController as? UINavigationController)?.pushViewController(DriverCoins(), animated: true)
        case 9:
            (window.rootViewController as? UINavigationController)?.pushViewController(NewsTableViewController(), animated: true)
        case 10:
            window.makeToastActivity(.center)
            ChangeRole.Change { (touser,todriver,torregister) in
                if touser == true {
                    window.hideToastActivity()
                    (window.rootViewController as? UINavigationController)?.pushViewController(TestViewController(), animated: true)
                    
                }
            }
        case 11:
            (window.rootViewController as? UINavigationController)?.pushViewController(UserSettingsTableViewController(), animated: true)
        case 12:
            if APItoken.getColorType() == 0 {
                APItoken.savecolor(color: 1)
                  (window.rootViewController as? UINavigationController)?.pushViewController(SessionOpenViewController(), animated: true)
            }
            else {
                APItoken.savecolor(color: 0)
                  (window.rootViewController as? UINavigationController)?.pushViewController(SessionOpenViewController(), animated: true)
            }
            
            
          
        default:
            break
        }
        window.makeKeyAndVisible()

    }
    class func Exit() {
        guard let window = UIApplication.shared.keyWindow else {return}
        window.makeKeyAndVisible()
        Quit.quit { (yes) in
            if yes == true {
                let preft = UserDefaults.standard
                preft.removeObject(forKey: "token")
                UIApplication.shared.keyWindow?.rootViewController = EnterPhone()
            }
        }
        
    }
    
}
