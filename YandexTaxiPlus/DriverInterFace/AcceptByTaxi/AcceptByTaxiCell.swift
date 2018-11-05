//
//  AcceptTaxiCollectionViewCell.swift
//  newtaxi
//
//  Created by Чингиз on 10.09.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit

class AcceptByTaxiCell: UITableViewCell {
    var icon : UIImageView = UIImageView()
    var menu : UILabel = UILabel()
    var detail : UILabel = UILabel()
    var menuview : UIView = UIView()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        add()
        anchors()
    }
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    func add() {
        self.addSubview(menuview)
        menuview.addSubview(icon)
        menuview.addSubview(detail)
        menuview.addSubview(menu)
    }
    func anchors() {
        icon.setAnchor(top: nil, left: self.leftAnchor, bottom: nil, right: menu.leftAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 30, height: 30)
        menu.setAnchor(top: nil, left: icon.rightAnchor, bottom: nil, right: detail.leftAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 10)
        detail.setAnchor(top: nil, left: menu.rightAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 20)
        detail.textAlignment = .right
        menu.textAlignment = .left
        icon.contentMode = .scaleAspectFit
        menu.font = UIFont.systemFont(ofSize: 18)
        detail.font = UIFont.systemFont(ofSize: 18)
    }
}
