//
//  DriverRegisterTableViewCell.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 24.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit

class DriverRegisterTableViewCell: UITableViewCell {
    let TextField : UITextField = UITextField()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        super.awakeFromNib()
        self.addSubview(TextField)
        TextField.setAnchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 5, paddingRight: 10)
        TextField.textAlignment = .center
        TextField.layer.cornerRadius = 10.0
        TextField.layer.borderColor = maincolor.cgColor
        TextField.layer.borderWidth = 1
    }
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
  
    

}
class DriverRegisterTableViewCell2: UITableViewCell {
    let TextField : UITextField = UITextField()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        super.awakeFromNib()
        self.addSubview(TextField)
        TextField.setAnchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 5, paddingRight: 10)
        TextField.textAlignment = .center
        TextField.layer.cornerRadius = 10.0
        TextField.layer.borderColor = maincolor.cgColor
        TextField.layer.borderWidth = 1
        self.backgroundColor = UIColor.clear

    }
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    
    
}
