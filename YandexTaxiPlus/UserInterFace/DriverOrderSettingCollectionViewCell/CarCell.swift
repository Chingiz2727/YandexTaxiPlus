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
    
    var type:UILabel = UILabel()
    var img:UIImageView = UIImageView()
    func setup() {
        self.addSubview(type)
        self.addSubview(img)
        type.numberOfLines = 0
        img.contentMode = .scaleAspectFit
        img.setAnchor(top: type.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 2, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 20, height: 20)
        type.setAnchor(top: self.topAnchor, left: self.leftAnchor , bottom: nil, right: self.rightAnchor, paddingTop: 1, paddingLeft: 20, paddingBottom: 0, paddingRight: 20,width: 50,height: 40)
        type.font = UIFont.systemFont(ofSize: 15)
        type.textAlignment = .center
        let centerY = img.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        let centerYLabel = type.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        NSLayoutConstraint.activate([centerY,centerYLabel])
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
