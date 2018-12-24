//
//  PriceAndCarCollectionViewCell.swift
//  Taxi+
//
//  Created by Чингиз on 20.08.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit

class CarCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        backgroundColor = UIColor.white
    }
    
    var type:MainLabel = MainLabel()
    var img:UIImageView = UIImageView()
    func setup() {
        self.clipsToBounds = false
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.5
        self.addSubview(type)
        self.addSubview(img)
        type.numberOfLines = 0
        img.contentMode = .scaleAspectFit
        img.setAnchor(top: type.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 2, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 20, height: 20)
        type.setAnchor(top: self.topAnchor, left: self.leftAnchor , bottom: nil, right: self.rightAnchor, paddingTop: 1, paddingLeft: 5, paddingBottom: 0, paddingRight: 5,width: 50,height: 40)
        type.font = UIFont.systemFont(ofSize: 13)
        type.textAlignment = .center
        type.initialize()
        let centerY = img.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        let centerYLabel = type.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        NSLayoutConstraint.activate([centerY,centerYLabel])
        self.backgroundColor = UIColor.clear

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class PriceCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var price:UILabel = UILabel()
    var type:UILabel = UILabel()
    var img:UIImageView = UIImageView()
    func setup() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.5
        self.addSubview(type)
        self.addSubview(img)
        self.addSubview(price)
        type.numberOfLines = 0
        img.contentMode = .scaleAspectFit
        img.setAnchor(top: self.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 40, height: 20)
        type.setAnchor(top: img.bottomAnchor, left: self.leftAnchor , bottom: nil, right: self.rightAnchor, paddingTop: 2, paddingLeft: 5, paddingBottom: 0, paddingRight: 5)
        price.setAnchor(top: type.bottomAnchor, left: self.leftAnchor , bottom: nil, right: self.rightAnchor, paddingTop: 2, paddingLeft: 5, paddingBottom: 0, paddingRight: 5)
        type.font = UIFont.systemFont(ofSize: 13)
        type.textAlignment = .center
        price.font = UIFont.systemFont(ofSize: 13)
        price.textAlignment = .center
        let centerY = img.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        let centerXprice = price.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        let centerYLabel = type.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        NSLayoutConstraint.activate([centerY,centerYLabel,centerXprice])
    }
}
