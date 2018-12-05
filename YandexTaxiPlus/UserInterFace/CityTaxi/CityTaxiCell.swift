//
//  BaseTaxiTableViewCell.swift
//  newtaxi
//
//  Created by Чингиз on 29.08.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit

class CityTaxiTableViewCell: UITableViewCell {
    var name : MainLabel = MainLabel()
    var phone : MainLabel = MainLabel()
    var from : MainLabel = MainLabel()
    var to : MainLabel = MainLabel()
    var car : MainLabel = MainLabel()
    var price : MainLabel = MainLabel()
    var time : MainLabel = MainLabel()
    var sits : MainLabel = MainLabel()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        add()
        
        attr()
        anchors()
    }
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    func add() {
        self.addSubview(name)
        self.addSubview(phone)
        self.addSubview(from)
        self.addSubview(to)
        self.addSubview(car)
        self.addSubview(sits)
        self.addSubview(price)
        self.addSubview(time)
        name.initialize()
        phone.initialize()
        from.initialize()
        to.initialize()
        car.initialize()
        sits.initialize()
        price.initialize()
        time.initialize()
    }
    
    func attr(){
        name.font = UIFont.systemFont(ofSize: 15)
        phone.font = UIFont.systemFont(ofSize: 15)
        from.font = UIFont.boldSystemFont(ofSize: 15)
        to.font = UIFont.systemFont(ofSize: 15)
        car.font = UIFont.systemFont(ofSize: 15)
        sits.font = UIFont.systemFont(ofSize: 15)
        price.font = UIFont.systemFont(ofSize: 15)
        time.font = UIFont.systemFont(ofSize: 15)
    }
    
    func anchors() {
        name.setAnchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 20, paddingBottom: 0, paddingRight: 0)
        phone.setAnchor(top: self.topAnchor, left: name.rightAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 2, paddingBottom: 0, paddingRight: 0)
        from.setAnchor(top: name.bottomAnchor, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 20, paddingBottom: 0, paddingRight: 0)
        to.setAnchor(top: from.bottomAnchor, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 20, paddingBottom: 0, paddingRight: 0)
        car.setAnchor(top: to.bottomAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 20, paddingBottom: 5, paddingRight: 0)
        price.setAnchor(top: phone.bottomAnchor, left: nil, bottom: nil, right: self.rightAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 5)
        time.setAnchor(top: from.bottomAnchor, left: nil, bottom: nil, right: self.rightAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 5)
        sits.setAnchor(top: to.bottomAnchor, left: nil, bottom: nil, right: self.rightAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 5)
        self.backgroundColor = UIColor.clear
    }
    
    
    weak var viewModel : TableViewCellFullChatsModelType?  {
        willSet(viewModel)  {
            guard  let viewModel = viewModel else {
                return
            }
            var timer = Double(viewModel.date!)
            let data = Date(timeIntervalSince1970: timer!)
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone(abbreviation: "GMT+06:00") //Set timezone that you want
            dateFormatter.dateFormat = "MM/dd/yyyy HH:mm:ss" //Specify your format that you want
            let strDate = dateFormatter.string(from: data)
        
            name.text = viewModel.name!
            time.text = strDate
            price.text = viewModel.price!
            phone.text = "("+viewModel.phone!+")"
            from.text = viewModel.from!
            to.text = viewModel.to!
            car.text = viewModel.comment!
        }
    }
    
    
}
