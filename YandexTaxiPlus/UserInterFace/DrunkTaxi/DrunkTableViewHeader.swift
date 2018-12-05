//
//  AddTaxiTableViewCell.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 23.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit

class DrunkHeader: UITableViewCell {
   
    var frombutton = UIButton()
    var tobutton = UIButton()
    var HeadView = UIView()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func addview() {
    self.addSubview(HeadView)
    HeadView.addSubview(frombutton)
    HeadView.addSubview(tobutton)
        self.backgroundColor = maincolor
   frombutton.backgroundColor = UIColor.white
    tobutton.backgroundColor = UIColor.white
    tobutton.setTitleColor(maincolor, for: .normal)
        frombutton.setTitleColor(maincolor, for: .normal)
     frombutton.setAnchor(top: HeadView.topAnchor, left: HeadView.leftAnchor, bottom: nil, right: HeadView.rightAnchor, paddingTop: 10, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: 50, height: 50)
        tobutton.setAnchor(top: frombutton.bottomAnchor, left: HeadView.leftAnchor, bottom: nil, right: HeadView.rightAnchor, paddingTop: 10, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: 50, height: 50)
        frombutton.setTitle("Откуда", for: .normal)
        frombutton.tag = 0
        tobutton.tag = 1
        tobutton.setTitle("Куда", for: .normal)
    }
}

