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
        icon.setAnchor(top: nil, left: self.leftAnchor, bottom: nil, right: menu.leftAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 25, height: 25)
        menu.setAnchor(top: nil, left: icon.rightAnchor, bottom: nil, right: detail.leftAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 10)
        detail.setAnchor(top: nil, left: menu.rightAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 20)
        detail.textAlignment = .right
        menu.textAlignment = .left
        icon.contentMode = .scaleAspectFit
        let icony = icon.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        let menuy = menu.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        let detaily = detail.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        menu.font = UIFont.systemFont(ofSize: 13)
        detail.font = UIFont.systemFont(ofSize: 13)
        NSLayoutConstraint.activate([icony,menuy,detaily])

    }
}





class CellFooterInfo:UITableViewCell {
    var chat:UIButton = UIButton()
    var call:UIButton = UIButton()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(chat)
        self.addSubview(call)
        chat.setAnchor(top: nil, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 60, height: 60)
        call.setAnchor(top: nil, left: nil, bottom: nil, right: self.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 60, height: 60)
        call.layer.cornerRadius = 30
        chat.layer.cornerRadius = 30
        chat.setImage(UIImage.init(named: "icon_message"), for: .normal)
        call.setImage(UIImage.init(named: "icon_call"), for: .normal)
        call.backgroundColor = maincolor
        chat.backgroundColor = maincolor
        chat.imageView?.sizeToFit()
        call.imageView?.sizeToFit()
        call.imageView?.frame.size = CGSize(width: 20, height: 20)
        chat.imageView?.frame.size = CGSize(width: 20, height: 20)

        chat.imageView?.contentMode = .scaleAspectFit
        call.imageView?.contentMode = .scaleAspectFit
        call.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        chat.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let centercall = call.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        let centerchat = chat.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        NSLayoutConstraint.activate([centercall,centerchat])
    }
    
 
    required init?(coder aDecoder: NSCoder) {
        fatalError("not")
    }
}
