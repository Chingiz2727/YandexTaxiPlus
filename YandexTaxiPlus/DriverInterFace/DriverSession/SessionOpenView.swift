//
//  SessionOpenView.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 26.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit

class SessionOpenView: UIView {
    var view : UIView = UIView()
    var view2 : UIView = UIView()
    
    let Coins : UILabel = UILabel()
    let Coins_count : UILabel = UILabel()
    let Label_six: UILabel = UILabel()
    let Label_tw : UILabel = UILabel()
    let six_price : UILabel = UILabel()
    let tw_price : UILabel = UILabel()
    let six_check : CheckboxButton = CheckboxButton()
    let tw_check : CheckboxButton = CheckboxButton()
    
    let ostatok : UILabel = UILabel()
    let ostatok_m : UILabel = UILabel()
    
    let OpenButton : UIButton = UIButton()
    let view3 : UIView = UIView()
    
    func add() {
        self.addSubview(view)
        self.addSubview(view2)
        self.addSubview(view3)

        view3.addSubview(Coins)
        view3.addSubview(Coins_count)
        
        view.addSubview(Label_six)
        view.addSubview(Label_tw)
        
        view.addSubview(six_price)
        view.addSubview(tw_price)
        
        view.addSubview(six_check)
        view.addSubview(tw_check)
        
        view2.addSubview(ostatok)
        view2.addSubview(ostatok_m)
        
        self.addSubview(OpenButton)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        add()
        anchors()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func anchors() {
        view3.setAnchor(top: self.topAnchor, left: Coins.leftAnchor, bottom: nil, right: Coins_count.rightAnchor, paddingTop: 100, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        view.setAnchor(top: view3.bottomAnchor, left: Label_six.leftAnchor, bottom: six_check.bottomAnchor, right: Label_tw.rightAnchor, paddingTop: 50, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        Label_six.setAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        six_price.setAnchor(top: Label_six.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        six_check.setAnchor(top: six_price.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0,width: 20,height: 20)
        
        Label_tw.setAnchor(top: view.topAnchor, left: Label_six.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 40, paddingBottom: 0, paddingRight: 0)
        tw_price.setAnchor(top: Label_tw.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        tw_check.setAnchor(top: tw_price.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0,width: 20,height: 20)
        
        
        view2.setAnchor(top: view.bottomAnchor, left: ostatok.leftAnchor, bottom: nil, right: ostatok_m.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        ostatok.setAnchor(top: view2.topAnchor, left: view2.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        ostatok_m.setAnchor(top: view2.topAnchor, left: ostatok.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 0)
        OpenButton.setAnchor(top: view2.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 50, paddingLeft: 10, paddingBottom: 20, paddingRight: 10,width: 0,height: 40)
        
    
        Coins.setAnchor(top: nil, left: view3.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        Coins_count.setAnchor(top: nil, left: Coins.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 40, paddingBottom: 0, paddingRight: 0)
        OpenButton.backgroundColor = maincolor
        OpenButton.layer.cornerRadius = 5
        OpenButton.setTitleColor(UIColor.white, for: .normal)
        let center = view.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        let centerv2 = view2.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        let centerv3 = view3.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        
        let CenterX2 = six_price.centerXAnchor.constraint(equalTo: Label_six.centerXAnchor)
        
        let CenterX4 = tw_price.centerXAnchor.constraint(equalTo: Label_tw.centerXAnchor)
        
        let centerX5 = six_check.centerXAnchor.constraint(equalTo: six_price.centerXAnchor)
        let centerX6 = tw_check.centerXAnchor.constraint(equalTo: tw_price.centerXAnchor)
        six_check.circular = true
        tw_check.circular = true
        Label_six.text = "6 часов"
        Label_tw.text = "12 часов"
        ostatok.text = "Остаток:"
        Coins.text = "Монеты:"
        Coins_count.textColor = maincolor
        six_check.checkColor = maincolor
        six_check.tintColor = maincolor
        tw_check.checkColor = maincolor
        six_check.containerColor = maincolor
        tw_check.containerColor = maincolor
        six_price.textColor = maincolor
        Label_six.textColor = maincolor
        six_check.tag = 0
        tw_check.tag = 1
        Label_tw.textColor = maincolor
        tw_price.textColor = maincolor
        ostatok_m.textColor = maincolor
        NSLayoutConstraint.activate([CenterX2,CenterX4,center,centerX5,centerX6,centerv2,centerv3])
        
        
        
    }
}
