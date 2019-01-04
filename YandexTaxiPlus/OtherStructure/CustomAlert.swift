//
//  CustomAlert.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 11/26/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit
import Toast_Swift

class CustomAlert: UIAlertController {
    var imag : UIImageView = UIImageView()
    var label : UILabel = UILabel()
    var button : UIButton = UIButton()
    var window = UIApplication.shared.keyWindow
    var publish : String?
    var type:String?
    
    var pay : Payed?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(imag)
        view.addSubview(label)
        view.addSubview(button)
        imag.setAnchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0,width: 50,height: 50)
        let centerimage = imag.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        NSLayoutConstraint.activate([centerimage])
        imag.image = UIImage.init(named: "icon_error")
        label.numberOfLines = 0
        label.textAlignment = .center
        label.setAnchor(top: imag.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 0, paddingRight: 10,width: 240,height: 0)
        button.setAnchor(top: label.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 10, paddingRight: 10)
        
        button.setTitle("Оплатить", for: .normal)
        button.setTitleColor(maincolor, for: .normal)
        button.addTarget(self, action: #selector(dismissing), for: .touchUpInside)
    }
    

    @objc func dismissing() {
        sendPushId.send { (info, order) in
            BuyAcessFunc.Buy(publish: self.publish!, type: self.type!, completion: { (yes, no) in
              if  yes {
                    self.window?.makeToast("Оплачено")
                    self.dismiss(animated: true, completion: nil)
                self.pay?.reloading()
                }
              if  no {
                    self.window?.makeToast("Недостаточно монет")
                self.dismiss(animated: true, completion: nil)

                }
            })
        }
     
        
    }
}
class ErrorAlert: UIAlertController {
    var imag : UIImageView = UIImageView()
    var label : UILabel = UILabel()
    var button : UIButton = UIButton()
    var window = UIApplication.shared.keyWindow
    var publish : String?
    var type:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(imag)
        view.addSubview(label)
        view.addSubview(button)
        imag.setAnchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0,width: 50,height: 50)
        let centerimage = imag.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        NSLayoutConstraint.activate([centerimage])
        imag.image = UIImage.init(named: "icon_error")
        label.numberOfLines = 0
        label.textAlignment = .center
        label.setAnchor(top: imag.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 0, paddingRight: 10,width: 240,height: 0)
        button.setAnchor(top: label.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 10, paddingRight: 10)
        button.setTitle("Закрыть", for: .normal)
        button.setTitleColor(maincolor, for: .normal)
        label.text = "Заполните все поля"
        
        
        button.addTarget(self, action: #selector(dismissing), for: .touchUpInside)
    }
    
    
    @objc func dismissing() {
        self.dismiss(animated: true, completion: nil)
        }
        
        
    }

