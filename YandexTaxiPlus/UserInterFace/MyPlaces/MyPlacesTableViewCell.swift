//
//  MyPlacesTableViewCell.swift
//  newtaxi
//
//  Created by Чингиз on 25.08.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit

class MyPlacesTableViewCell: UITableViewCell {

    let img = UIImageView()
    let label = MainLabel()
    let place = MainLabel()
    
    let view = UIView()
    let timeview = UIView()
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
        self.addSubview(view)
        view.addSubview(label)
        view.addSubview(timeview)
        view.addSubview(place)
        view.addSubview(img)
        view.addSubview(label)
        label.initialize()
        place.initialize()
        label.font = UIFont.systemFont(ofSize: 18)
        let centerY = img.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        let centerYtime = label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        let centerpolace = place.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        place.setAnchor(top: nil, left: img.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 20)
        label.setAnchor(top: nil, left: nil, bottom: nil, right: self.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 20)
        img.setAnchor(top: nil, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 0,width: 24,height: 24)
        NSLayoutConstraint.activate([centerY,centerYtime,centerpolace])
        self.backgroundColor = UIColor.clear

    }
    
}
