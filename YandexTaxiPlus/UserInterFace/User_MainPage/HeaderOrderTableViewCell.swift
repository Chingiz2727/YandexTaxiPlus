//
//  HeaderOrderTableViewCell.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 12/20/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit

class HeaderOrderTableViewCell: UITableViewCell {

    var avatarImageView : UIImageView = UIImageView()
    var starsAvatar : UIImageView = UIImageView()
    var button : UIButton = UIButton()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        makeadd()
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func makeadd() {
        self.addSubview(avatarImageView)
        self.addSubview(starsAvatar)
        self.addSubview(button)
        avatarImageView.image = UIImage(named: "userjpg")
        starsAvatar.clipsToBounds = true
        avatarImageView.layer.cornerRadius = 35
        avatarImageView.clipsToBounds = true
        starsAvatar.contentMode = .scaleAspectFit
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.backgroundColor = UIColor.gray
        let centerXphoto = avatarImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        let centerXphotor = starsAvatar.centerXAnchor.constraint(equalTo: avatarImageView.centerXAnchor)
        let centeyphoto = starsAvatar.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor)
        NSLayoutConstraint.activate([centerXphoto,centerXphotor,centeyphoto])
        button.setAnchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 40)
        button.backgroundColor = maincolor
        button.setTitle("Информация о заказе", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        avatarImageView.setAnchor(top: button.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 70, height: 70)
        starsAvatar.setAnchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 95, height: 95)
    }

}
