//
//  FooterCollectionViewCell.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 11/16/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit

class FooterCollectionViewCell: UICollectionViewCell {
    var makeorder : (() -> Void)?

    var button:MainButton = MainButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(button)
        button.initialize()
        button.isUserInteractionEnabled = true
        button.setAnchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 15, paddingLeft: 10, paddingBottom: 15, paddingRight: 10)
        button.addTarget(self, action: #selector(go), for: .touchUpInside)
        button.Title(title: "Заказать")
        self.backgroundColor = UIColor.clear

    }
    @objc func go() {
        makeorder?()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
