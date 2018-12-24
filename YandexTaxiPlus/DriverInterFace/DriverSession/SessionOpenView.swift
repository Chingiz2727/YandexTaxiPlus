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
    
    let Coins : MainLabel = MainLabel()
    let Coins_count : MainLabel = MainLabel()
    let Label_six: MainLabel = MainLabel()
    let Label_tw : MainLabel = MainLabel()
    let six_price : MainLabel = MainLabel()
    let tw_price : MainLabel = MainLabel()
    let six_check : CheckboxButton = CheckboxButton()
    let tw_check : CheckboxButton = CheckboxButton()
    
    let ostatok : MainLabel = MainLabel()
    let ostatok_m : MainLabel = MainLabel()
    
    let OpenButton : MainButton = MainButton()
    let view3 : UIView = UIView()
    
    func add() {
        self.addSubview(view)
        self.addSubview(view2)
        self.addSubview(view3)
        Coins.initialize()
        Coins_count.initialize()
        view3.addSubview(Coins)
        view3.addSubview(Coins_count)
        Label_tw.initialize()
        Label_six.initialize()
        view.addSubview(Label_six)
        view.addSubview(Label_tw)
        six_price.initialize()
        tw_price.initialize()
        view.addSubview(six_price)
        view.addSubview(tw_price)
        
        view.addSubview(six_check)
        view.addSubview(tw_check)
        ostatok.initialize()
        ostatok_m.initialize()
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
        view.setAnchor(top: view3.bottomAnchor, left: Label_six.leftAnchor, bottom: six_check.bottomAnchor, right: Label_tw.rightAnchor, paddingTop: 40, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        Label_six.setAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        six_price.setAnchor(top: Label_six.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        six_check.setAnchor(top: six_price.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0,width: 20,height: 20)
        
        Label_tw.setAnchor(top: view.topAnchor, left: Label_six.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 40, paddingBottom: 0, paddingRight: 0)
        tw_price.setAnchor(top: Label_tw.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        tw_check.setAnchor(top: tw_price.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0,width: 20,height: 20)
        view2.setAnchor(top: view.bottomAnchor, left: ostatok.leftAnchor, bottom: nil, right: ostatok_m.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        ostatok.setAnchor(top: view2.topAnchor, left: view2.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        ostatok_m.setAnchor(top: view2.topAnchor, left: ostatok.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 0)
        OpenButton.setAnchor(top: view2.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 50, paddingLeft: 10, paddingBottom: 20, paddingRight: 10,width: 0,height: 40)
        
    
        Coins.setAnchor(top: view3.topAnchor, left: view3.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        Coins_count.setAnchor(top: view3.topAnchor, left: Coins.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 40, paddingBottom: 0, paddingRight: 0)
        OpenButton.initialize()
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
   
        six_check.containerColor = maincolor
        tw_check.containerColor = maincolor
   
        six_check.tag = 0
        tw_check.tag = 1
       
        NSLayoutConstraint.activate([CenterX2,CenterX4,center,centerX5,centerX6,centerv2,centerv3])
        
        
        
    }
}
