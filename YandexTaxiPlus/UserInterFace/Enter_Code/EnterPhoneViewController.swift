//
//  EnterPhoneViewController.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 12.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import Toast_Swift
import SideMenu
class EnterPhoneViewController: UIViewController {

    var accessview : EnterCodeView!
    var window: UIWindow?
    var phone:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupview()
        navigationController?.navigationBar.isHidden = true
        
        accessview.loginAction = accessing
        
        // Do any additional setup after loading the view.
    }
    func setupview()
    {   let mainView = EnterCodeView(frame: self.view.frame)
        self.accessview = mainView
        view.addSubview(mainView)
        view.backgroundColor = UIColor.white
    }
    func go(){
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
    }
    func accessing() {
        let url = "http://185.236.130.126:443/verify-code"
        let params = [
            "phone":phone!,
            "code":accessview.PhoneField.text!
        ]
        
        let name = EnterNameViewController()
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if response.data != nil {
                switch response.result {
                case.failure(let err):
                    print(err)
                case.success(let val):
                    var json = JSON(val)
                    if json["state"] == "error" {
                      self.view.makeToast("Неправильный Код")
                    }
                    else {
                        self.window = UIWindow(frame: UIScreen.main.bounds)
                        self.window?.makeKeyAndVisible()
                        let token = json["user"]["token"].stringValue
                        if json["type"].intValue == 2 {
                            APItoken.saveapitoken(token: token)
                            self.window = UIWindow(frame: UIScreen.main.bounds)
                            let nav1 = UINavigationController()
                            let mainView = SessionOpenViewController(nibName: nil, bundle: nil) //ViewController = Name of your controller
                            nav1.viewControllers = [mainView]
                            self.window!.rootViewController = nav1
                            self.window?.makeKeyAndVisible()                        }
                        if json["type"].intValue == 1 {
                            //                            let menuLeftNavigationController = UISideMenuNavigationController(rootViewController: MenuTableViewController())
                            //                            SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController
                            //                            menuLeftNavigationController.sideMenuManager.menuWidth = self.window!.frame.width - self.window!.frame.width*0.2
                            //                            SideMenuManager.default.menuFadeStatusBar = false
                            //                            SideMenuManager.default.menuPushStyle = .replace
                            //                            menuLeftNavigationController.sideMenuManager.menuPresentMode = .menuSlideIn
                            APItoken.saveapitoken(token: token)
                            self.window = UIWindow(frame: UIScreen.main.bounds)
                            let nav1 = UINavigationController()
                            let mainView = TestViewController(nibName: nil, bundle: nil) //ViewController = Name of your controller
                            nav1.viewControllers = [mainView]
                            self.window!.rootViewController = nav1
                            self.window?.makeKeyAndVisible()
                        }
                        if json["type"].intValue == 0 {
                            name.phone = self.phone
                            self.window?.rootViewController = UINavigationController(rootViewController: name)
                            
                        }
                    }
                }
            }
        }
}
}
