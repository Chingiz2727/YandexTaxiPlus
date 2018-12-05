//
//  SavePlaceView.swift
//  newtaxi
//
//  Created by Чингиз on 28.08.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
class SavePlaceView: UIView {
    var saveAction: (() -> Void)?
    var map : GMSMapView = GMSMapView()
    var label : MainLabel = MainLabel()
    var name : MainTxf = MainTxf()
    var savebutton : UIButton = UIButton()
   @objc func Save() {
        saveAction?()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        self.addSubview(label)
        label.initialize()
        name.initialize()
        label.setAnchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 20, paddingLeft: 10, paddingBottom: 20, paddingRight: 10, width: 20, height: 40)
        label.text = "Выберите место на карте"
        label.textAlignment = .center
        label.numberOfLines = 0
        self.addSubview(map)
        map.setAnchor(top: label.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 300)
        self.addSubview(name)
        name.setAnchor(top: map.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 40)
        name.layer.borderColor = maincolor.cgColor
        name.layer.cornerRadius = 10
        name.layer.borderWidth = 1
        name.textAlignment = .center
        name.attributedPlaceholder = NSAttributedString(string: "Введите описание",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        self.addSubview(savebutton)
        savebutton.setAnchor(top: name.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 40)
        savebutton.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        savebutton.setTitleColor(UIColor.white, for: .normal)
        savebutton.setTitle("Добавить место", for: .normal)
    }

  

}
