//
//  HistoryTableViewCell.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 12/7/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    let label : MainLabel = MainLabel()
    let time : MainLabel = MainLabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
     self.addSubview(label)
    self.addSubview(time)
    label.setAnchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 10, paddingBottom: 5, paddingRight: 2, width: self.width/2, height: 0)
        time.setAnchor(top: self.topAnchor, left: nil, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 5, paddingLeft: 2, paddingBottom: 5, paddingRight: 10, width: self.width/2, height: 0)
        time.textAlignment = .right
        label.textAlignment = .left
        let labelc = label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        let timec = time.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        NSLayoutConstraint.activate([labelc,timec])
        self.selectionStyle = .none
        time.numberOfLines = 0
        label.numberOfLines = 0
    }
    
    
    func add() {
      
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
