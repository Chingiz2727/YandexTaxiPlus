//
//  PhoneFieldView.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 12.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit
import SwiftPhoneNumberFormatter

class PhoneFieldView: UIView {
    var loginAction: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        SetAcnchor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let TitleView : UILabel = {
        let title = UILabel()
        title.frame.size = CGSize(width: 100, height: 100)
        
        title.text = "Введите номер телефона \n для авторизации"
        title.textAlignment = .center
        title.numberOfLines = 2
        title.font = UIFont(name: "Arial", size: 20)
        title.textColor = UIColor.darkGray
        return title
        
    }()
    let PhoneField : PhoneFormattedTextField = {
        let phone = PhoneFormattedTextField()
        
        phone.layer.cornerRadius = 5.0
        let mycolor = UIColor.init(r: 44, g: 192, b: 154)
        phone.frame.size = CGSize(width: 100, height: 100)
        phone.layer.borderColor = maincolor.cgColor
        phone.layer.borderWidth = 1.0
        phone.placeholder = "Номер телефона"
        phone.textAlignment = .center
  
        return phone
    }()
    let Next : UIButton = {
        let next = UIButton()
        next.backgroundColor = maincolor
        next.layer.cornerRadius = 10.0
        next.frame.size = CGSize(width: 100, height: 100)
        
        next.setTitle("Далее", for: .normal)
        next.addTarget(self, action: #selector(handlelogin), for: .touchUpInside)
        return next
    }()
    @objc func handlelogin()
    {
        loginAction?()
    }
    
    func SetAcnchor() {
        self.addSubview(TitleView)
        self.addSubview(PhoneField)
        self.addSubview(Next)
        TitleView.setAnchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 50, paddingLeft: 30, paddingBottom: 0, paddingRight: 30, width: 100, height: 50)
        PhoneField.setAnchor(top: TitleView.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 50, paddingLeft: 30, paddingBottom: 0, paddingRight: 30, width: 100, height: 50)
        Next.setAnchor(top: PhoneField.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 20, paddingLeft: 50, paddingBottom: 0, paddingRight: 50, width: 100, height: 50)
        
    }
}
