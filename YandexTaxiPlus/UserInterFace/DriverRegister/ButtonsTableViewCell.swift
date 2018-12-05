//
//  ButtonsTableViewCell.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 25.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit

class ButtonsTableViewCell: UITableViewCell {
    var TaxiButton : UIImageView = UIImageView()
    var TaxiLabel : MainLabel = MainLabel()
    
  
    
    func anchors() {
        self.addSubview(TaxiLabel)
        TaxiLabel.initialize()
        self.addSubview(TaxiButton)
        TaxiButton.setAnchor(top: nil, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 0,width: 50,height: 50)
        TaxiLabel.setAnchor(top: nil, left: TaxiButton.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 0)
        TaxiButton.contentMode = .scaleAspectFit

          let CenterYLabel = TaxiLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
          let CenterYButton = TaxiButton.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        NSLayoutConstraint.activate([CenterYLabel,CenterYButton])
        self.backgroundColor = UIColor.clear

    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        super.awakeFromNib()
        anchors()
    }
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
