//
//  MenuTableViewController.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 20.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit
import SideMenu
import Alamofire
class MenuTableViewController: UITableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    var cellid = "cellid"
    var outview : UIView = UIView()
     let window = UIApplication.shared.keyWindow
    fileprivate var image : UIImage?
    fileprivate var name : String?
    fileprivate var phone : String?
    var outbutton : UIButton = UIButton()
    let menu = [MenuModule(menu: "Такси", img: "icon_taxi", id: "1", contains: true),
                MenuModule(menu: "Lady Такси", img: "icon_taxi", id: "2", contains: true),
                MenuModule(menu: "Межгород", img: "icon_cities_taxi", id: "1", contains: true),
                MenuModule(menu: "Инва Такси", img: "icon_inva", id: "4",  contains: true),
                MenuModule(menu: "Грузоперевозки", img: "icon_cargo", id: "2",  contains: true),
                MenuModule(menu: "Эвакуатор", img: "icon_evo", id: "3", contains: true),
                MenuModule(menu: "Трезвый Водитель", img: "icon_driver", id: "3", contains: true),
                MenuModule(menu: "История поездок", img: "wall-clock", id: "3", contains: false),
                MenuModule(menu: "Настройки", img: "icon_settings", id: "3",  contains: false),
                MenuModule(menu: "Мои Монеты", img: "icon_driver", id: "3",  contains: false),
                MenuModule(menu: "Новости", img: "ic_news", id: "3", contains: false),
                MenuModule(menu: "Режим Водителя", img: "icon_switch", id: "3", contains: false),
                MenuModule(menu: "Поделиться", img: "icon_share", id: "3",contains: false)]
    
    var headerid = "headerid"
    override func viewDidLoad() {
        super.viewDidLoad()
      fetchdata()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIColourScheme.instance.set(for:self)
        
        tableView.bounces = false
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        navigationController?.isNavigationBarHidden = true
        tableView.register(MainPageMenuCell.self, forCellReuseIdentifier: cellid)
        tableView.register(MainPageHeader.self, forCellReuseIdentifier: headerid)
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 70
        }
        return 200
    }
    
    
   override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let head = tableView.dequeueReusableCell(withIdentifier: headerid) as! MainPageHeader
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
    head.avatarImageView.isUserInteractionEnabled = true
    let gest = UITapGestureRecognizer.init(target: self, action: #selector(sec))
    head.avatarImageView.addGestureRecognizer(gest)
    head.nameLabel.text = name
    head.phone.text = phone
    head.avatarImageView.image = image
        return head
    }
    
    
    
    
    fileprivate func fetchdata() {
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            sendPushId.send(completion: { (info, type) in
                let url = "http://185.236.130.126/profile/uploads/avatars/\(info.avatar ?? "")"
                Alamofire.request(url).responseJSON(completionHandler: { (response) in
                    DispatchQueue.main.async {
                        
                        self.image = UIImage(data: response.data!)!
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
    
    @objc func remove() {
        PushDriver.Exit()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 1 {
            return 0
        }
        return menu.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as! MainPageMenuCell
        GetAmount.get { (amount) in
            switch indexPath.row {
            case 0:
                cell.countlabel.text = amount.taxi!
                cell.countlabel.backgroundColor = #colorLiteral(red: 0.8784313725, green: 0.2588235294, blue: 0.368627451, alpha: 1)
            case 1:
                cell.countlabel.text = amount.taxi!
                cell.countlabel.backgroundColor = #colorLiteral(red: 0.8784313725, green: 0.2588235294, blue: 0.368627451, alpha: 1)

            case 2 :
                cell.countlabel.text = amount.mejgorod!
                cell.countlabel.backgroundColor = #colorLiteral(red: 0.8784313725, green: 0.2588235294, blue: 0.368627451, alpha: 1)
            case 3:
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
        cell.img.image = UIImage(named: menu[indexPath.row].img)
        if APItoken.getColorType() == 0 {
            cell.img.setImageColor(color: maincolor)
            cell.label.textColor = maincolor
        }
        else {
            cell.img.setImageColor(color: UIColor.white)
            cell.label.textColor = UIColor.white
        }
        cell.label.text = menu[indexPath.row].menu
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    let main = TestViewController()
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 12:
            GetReferal.get { (referal) in
                let toshare = [referal?.link!]
                let activity = UIActivityViewController(activityItems: toshare, applicationActivities: nil)
                activity.popoverPresentationController?.sourceView = self.view
                activity.excludedActivityTypes = [UIActivity.ActivityType.airDrop,UIActivity.ActivityType.mail,UIActivity.ActivityType.message,UIActivity.ActivityType.postToFacebook,UIActivity.ActivityType.postToTwitter,UIActivity.ActivityType.copyToPasteboard]
                self.present(activity, animated: true, completion: nil)
            }
        default:
            dismiss(animated: true, completion: nil)
            main.index(index: indexPath)
        }
    }
}
class PushFromMain : UINavigationController {
    class func push (index:IndexPath){
        guard let window = UIApplication.shared.keyWindow else {return}
        let fuull = FullChatsTableViewController()
        var Mainpage = TestViewController()
        switch index.row {
        case 0:
            Mainpage.type = "1"
            (window.rootViewController as? UINavigationController)?.pushViewController(Mainpage, animated: true)
        case 1:
            Mainpage.type = "2"
            (window.rootViewController as? UINavigationController)?.pushViewController(Mainpage, animated: true)
        case 2:
            (window.rootViewController as? UINavigationController)?.pushViewController(CityTaxi(), animated: true)
        case 3:
            fuull.type = 4
            (window.rootViewController as? UINavigationController)?.pushViewController(fuull, animated: true)
        case 4:
            fuull.type = 2
            (window.rootViewController as? UINavigationController)?.pushViewController(fuull, animated: true)

        case 5:
            fuull.type = 3
            (window.rootViewController as? UINavigationController)?.pushViewController(fuull, animated: true)
        case 6:
            
            (window.rootViewController as? UINavigationController)?.pushViewController(DrunkTaxiTable(), animated: true)
        case 7:
            (window.rootViewController as? UINavigationController)?.pushViewController(HistoryTableViewController(), animated: true)
        case 8:
              (window.rootViewController as? UINavigationController)?.pushViewController(DriverSettingTableViewController(), animated: true)
        case 9:
              (window.rootViewController as? UINavigationController)?.pushViewController(UserCoinViewController(), animated: true)
        case 10:
            (window.rootViewController as? UINavigationController)?.pushViewController(NewsTableViewController(), animated: true)
        case 11:
            window.makeToastActivity(.center)

            ChangeRole.Change { (touser,todriver,torregister) in
                if todriver == true {
                (window.rootViewController as? UINavigationController)?.pushViewController(SessionOpenViewController(), animated: true)
                    window.hideToast()
                }
                if torregister == true {
                    (window.rootViewController as? UINavigationController)?.pushViewController(DriverRegisterTableViewController(), animated: true)
                }
            }
        default:
            break
        }
        window.makeKeyAndVisible()

      
    }
   
}
extension UIImageView {
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}
