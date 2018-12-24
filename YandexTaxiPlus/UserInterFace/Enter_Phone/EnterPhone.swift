//
//  ViewController.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 12.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import Toast_Swift
import SwiftPhoneNumberFormatter

class EnterPhone: UIViewController {

    var loginview : PhoneFieldView!
    var window: UIWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupview()
        loginview.PhoneField.config.defaultConfiguration = PhoneFormat(defaultPhoneFormat: "(###) ###-##-##")
        loginview.PhoneField.prefix = "+7"
        loginview.loginAction = response
        navigationController?.isNavigationBarHidden = true
        APItoken.savecolor(color: 0)
    }
    
    
    func setupview()
    {   let mainView = PhoneFieldView(frame: self.view.frame)
        self.loginview = mainView
        view.addSubview(mainView)
        view.backgroundColor = UIColor.white
    }
    
    
    func response() {
        let tet = loginview.PhoneField.text!
        let phone = tet.replacingOccurrences(of:" ", with: "").replacingOccurrences(of: "-", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "(", with: "").replacingOccurrences(of: "+", with: "")
        
      
        let url = baseurl + "/send-sms/"
        let text = ["phone":phone]
        if phone.count != 11 {
            self.view.makeToast("Введите корректный номер телефона")
        }
        else {
            Alamofire.request(url, method: .post, parameters: text, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                if response.data != nil {
                    switch response.result {
                    case.failure(let error):
                        print(error)
                    case.success(let value):
                        let json = JSON(value)
                                            let acces = EnterPhoneViewController()
                                            acces.phone = phone
                                            self.window = UIWindow(frame: UIScreen.main.bounds)
                                            self.window?.makeKeyAndVisible()
                                            self.window?.rootViewController = acces
                        
                    }
                }
            }
        }
         }


}

