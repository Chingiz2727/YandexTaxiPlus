//
//  MainButton.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 11/13/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
import UIKit

class ButtonTemplate : UIButton {
    func setColorTitle(color:UIColor) {
        
    }
    
    func setBackGround() {
        
    }
    
   
    func setCornerColor() {
        
    }
    func Title(title:String) {
        
    }
    func setShadow() {
        
    }
    func setShadowColor() {
        
    }
    
    func setShadowOpacity() {
        
    }
    func setShadowRadius() {
        
    }
    func setCornerRadius(){
        
    }
    
    func initialize() {
        setColorTitle(color: UIColor.white)
        setBackGround()
        setCornerColor()
        setShadow()
        setShadowColor()
        setShadowRadius()
        setShadowOpacity()
        setCornerRadius()
    }
}

class MainButton:ButtonTemplate {
    override func setColorTitle(color:UIColor) {
        self.setTitleColor(color, for: .normal)
    }
    
    override func setBackGround() {
        if APItoken.getColorType() == 0 {
            self.backgroundColor = maincolor
        }
        else {
            self.backgroundColor = background_bl
        }
    }
    override func setCornerRadius() {
        self.layer.cornerRadius = 10
    }
    override func setShadow() {
        
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
    }
    override func Title(title: String) {
        self.setTitle(title, for: .normal)
    }
    
    override func setShadowColor(){
        self.layer.shadowColor = UIColor.black.cgColor
    }
    override func setShadowOpacity() {
        self.layer.shadowOpacity = 0.4
    }
}


class LabelTemplate : UILabel {
    func setColor() {
        
    }
    func initialize(){
        setColor()
    }
}
class TextFieldTemplate : UITextField {
    func setColor() {
        
    }
    func initialize() {
        setColor()
    }
}

class MainLabel:LabelTemplate {
    override func setColor() {
        if APItoken.getColorType() == 0 {
            self.textColor = UIColor.black
            
        }
        else {
            self.textColor = UIColor.white
        }
    }
}
class MainTxf : TextFieldTemplate {
    override func setColor() {
        if APItoken.getColorType() == 0 {
            self.textColor = UIColor.black
            self.attributedPlaceholder = NSAttributedString(string: "",
                                                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])        }
        else {
            self.textColor = UIColor.white
            self.attributedPlaceholder = NSAttributedString(string: "",
                                                            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            
        }
    }
}
