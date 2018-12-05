//
//  UserSettingTableViewCell.swift
//  newtaxi
//
//  Created by Чингиз on 25.08.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit

class UserSettingTableViewCell: UITableViewCell {

    let name = MainLabel()
    let label = UITextField()
    let UiView = UITableViewCell()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    func setView() {
        self.addSubview(UiView)
        UiView.addSubview(label)
        UiView.addSubview(name)
        name.font = UIFont.systemFont(ofSize: 14)
        name.initialize()
        let centerY = name.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        let centerYLabel = label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        UiView.setAnchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        label.setAnchor(top: self.topAnchor, left: name.rightAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 10,width: self.frame.width,height: self.frame.height)
        name.setAnchor(top: nil, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 0,width: 120,height: 20)
        NSLayoutConstraint.activate([centerY,centerYLabel])
        self.backgroundColor = UIColor.clear

    }

}
