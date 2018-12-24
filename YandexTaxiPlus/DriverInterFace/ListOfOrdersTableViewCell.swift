//
//  ListOfOrdersTableViewCell.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 12/14/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit

class ListOfOrdersTableViewCell: UITableViewCell {
    let label : UILabel = UILabel()
    let time : UILabel = UILabel()
    override func awakeFromNib() {
        super.awakeFromNib()
//         Initialization code
        
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(label)
        self.addSubview(time)
        label.setAnchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 4, paddingLeft: 4, paddingBottom: 4, paddingRight: 4, width: 4, height: 50)
        time.setAnchor(top: label.bottomAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 4, paddingLeft: 4, paddingBottom: 4, paddingRight: 4, width: 4, height: 20)
        label.numberOfLines = 0
        label.textColor = maincolor
        label.textAlignment = .center
        time.textAlignment = .center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
