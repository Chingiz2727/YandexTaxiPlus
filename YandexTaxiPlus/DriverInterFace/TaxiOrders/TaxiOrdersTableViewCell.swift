//
//  TaxiOrdersTableViewCell.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 11/2/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit

class TaxiOrdersTableViewCell: UITableViewCell {
    var AcceptButton : UIButton = UIButton()
    var AccepLabel : UILabel = UILabel()
    var DistanLabel : UILabel = UILabel()
    var CancelButton : UIButton = UIButton()
    var CancelLabel : UILabel = UILabel()
    var from : UILabel = UILabel()
    var to : UILabel = UILabel()
    var price : UILabel = UILabel()
    var bottomView : UIView = UIView()
    var bot : UIView = UIView()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addview()
        anchors()
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    func addview() {
        self.addSubview(bot)
        self.addSubview(from)
        self.addSubview(to)
        self.addSubview(price)
        bot.addSubview(bottomView)
        self.addSubview(DistanLabel)
        bottomView.addSubview(AcceptButton)
        bottomView.addSubview(CancelButton)
        bottomView.addSubview(AccepLabel)
        bottomView.addSubview(CancelLabel)
    }
    
    func anchors() {
        from.setAnchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 0)
        to.setAnchor(top: from.bottomAnchor, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 0)
        price.setAnchor(top: self.topAnchor, left: nil, bottom: nil, right: self.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 20)
        DistanLabel.setAnchor(top: price.bottomAnchor, left: nil, bottom: nil, right: self.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 20)
        bottomView.setAnchor(top: bot.topAnchor, left: AccepLabel.leftAnchor, bottom: bot.bottomAnchor, right: CancelLabel.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 20, paddingRight: 0)
        AcceptButton.setAnchor(top: bottomView.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        CancelButton.setAnchor(top: bottomView.topAnchor, left: AcceptButton.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 70, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        AccepLabel.setAnchor(top: AcceptButton.bottomAnchor, left: bottomView.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        CancelLabel.setAnchor(top: CancelButton.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        bot.setAnchor(top: to.bottomAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        let CenterXview = bottomView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        let CenterYView = bottomView.centerYAnchor.constraint(equalTo: bot.centerYAnchor)
        let CenterXAccept = AccepLabel.centerXAnchor.constraint(equalTo: AcceptButton.centerXAnchor)
        let CenterXCancle = CancelLabel.centerXAnchor.constraint(equalTo: CancelButton.centerXAnchor)
        NSLayoutConstraint.activate([CenterXview,CenterXAccept,CenterXCancle,CenterYView])
        bot.backgroundColor = maincolor
        
        CancelLabel.text = "На карте"
        AccepLabel.text = "Принять"
        AcceptButton.setImage(UIImage(named: "icon_accept"), for: .normal)
        CancelButton.setImage(UIImage(named: "icon_onmap"), for: .normal)
        from.text = "Manasa 32"
        to.text = "Abaya 1"
        DistanLabel.text = "5 km"
        price.text = "500tg"
        DistanLabel.textColor = maincolor
        AccepLabel.textColor = UIColor.white
        CancelLabel.textColor = UIColor.white

    }

}
