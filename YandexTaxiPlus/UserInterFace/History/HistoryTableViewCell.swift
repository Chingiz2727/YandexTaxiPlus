//
//  HistoryTableViewCell.swift
//  newtaxi
//
//  Created by Чингиз on 24.08.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    let img = UIImageView()
    let label = UILabel()
    let date = UILabel()
    let place = UILabel()

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
        timeview.addSubview(date)
        timeview.addSubview(label)
        date.font = UIFont.systemFont(ofSize: 8)
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "che tam"
       
        let centerY = img.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        let centerYtime = timeview.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        let centerpolace = place.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        place.setAnchor(top: nil, left: img.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 20)
        label.setAnchor(top: nil, left: nil, bottom: nil, right: self.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 20)
        date.setAnchor(top: label.bottomAnchor, left: nil, bottom: nil, right: self.rightAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 20)
        img.setAnchor(top: nil, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 0,width: 24,height: 24)
        timeview.setAnchor(top: label.topAnchor, left: label.leftAnchor, bottom: date.bottomAnchor, right: label.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)

        NSLayoutConstraint.activate([centerY,centerYtime,centerpolace])
        
    }

}