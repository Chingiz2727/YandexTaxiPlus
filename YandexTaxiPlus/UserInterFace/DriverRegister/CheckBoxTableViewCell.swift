//
//  CheckBoxTableViewCell.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 25.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit
//
//  File.swift
//  newtaxi
//
//  Created by Чингиз on 03.09.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

class Facilities {
    var id : Int = 0
    var name : String = ""
}

class CheckBoxTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        super.awakeFromNib()
        add()
    }
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    let label:MainLabel = MainLabel()
    let check:CheckboxButton = CheckboxButton()
    func add()
    {
        
        self.addSubview(label)
        self.addSubview(check)
        label.initialize()
        label.setAnchor(top: nil, left: check.rightAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 20)
        check.setAnchor(top: nil, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 20,width: 20,height: 20)
        check.checkColor = maincolor
        check.containerColor = maincolor
        let CenterX1 = label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        let CenterX2 = check.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        NSLayoutConstraint.activate([CenterX1,CenterX2])
        label.font = UIFont.systemFont(ofSize: 16)
        self.backgroundColor = UIColor.clear

    }

}
