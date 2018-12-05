//
//  EnterNameView.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 12.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit

class EnterNameView: UIView {

    
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
        title.text = "Введите ваше имя"
        title.textAlignment = .center
        title.numberOfLines = 2
        title.font = UIFont(name: "Arial", size: 20)
        title.textColor = UIColor.darkGray
        return title
        
    }()
    let PhoneField : UITextField = {
        let phone = UITextField()
        phone.layer.cornerRadius = 5.0
        phone.layer.borderColor = maincolor.cgColor
        phone.layer.borderWidth = 1.0
        phone.placeholder = "Имя"
        phone.textAlignment = .center
        return phone
    }()
    let City : UIButton = {
        let next = UIButton()
        next.layer.cornerRadius = 10.0
        next.layer.borderColor = maincolor.cgColor
        next.layer.borderWidth = 1.0
        next.setTitleColor(maincolor, for: .normal)
        next.setTitle("Выбрать город", for: .normal)
        return next
    }()
    let Next : UIButton = {
        let next = UIButton()
        next.backgroundColor = maincolor
        next.layer.cornerRadius = 10.0
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
        self.addSubview(City)
        
        TitleView.setAnchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 50, paddingLeft: 30, paddingBottom: 0, paddingRight: 30, width: 100, height: 50)
        PhoneField.setAnchor(top: TitleView.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 50, paddingLeft: 30, paddingBottom: 0, paddingRight: 30, width: 100, height: 50)
       City.setAnchor(top: PhoneField.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 20, paddingLeft: 30, paddingBottom: 0, paddingRight: 30, width: 100, height: 50)
        Next.setAnchor(top: City.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 20, paddingLeft: 50, paddingBottom: 0, paddingRight: 50, width: 100, height: 50)
    }
}
