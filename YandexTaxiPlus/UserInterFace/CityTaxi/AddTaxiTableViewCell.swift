//
//  AddTaxiTableViewCell.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 23.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit

class AddTaxiTableViewCell: UITableViewCell {
    let icon : UIImageView = UIImageView()
    var textfield : UITextField = UITextField()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addview()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func addview() {
        self.addSubview(icon)
        self.addSubview(textfield)
        icon.setAnchor(top: nil, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 15, paddingBottom: 0, paddingRight: 0, width: 25, height: 25)
        icon.contentMode = .scaleAspectFit
        textfield.setAnchor(top: nil, left: icon.rightAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 0, paddingLeft: 15, paddingBottom: 0, paddingRight: 5, width: 25, height: 0)
        let centerY = icon.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        let centerYLabel = textfield.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        NSLayoutConstraint.activate([centerY,centerYLabel])

    }
}
class MenuCity {
    var text : String!
    var img : String!
    init(text:String,img:String) {
        self.text = text
        self.img = img
    }
}
