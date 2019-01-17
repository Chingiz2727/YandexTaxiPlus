//
//  TaxiOrdersTableViewCell.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 11/2/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit

class TaxiOrdersTableViewCell: UITableViewCell {
    var type : String? {
        didSet {
            type_label.text = type ?? "Такси"
        }
    }
    var AcceptButton : UIButton = UIButton()
  private  var AccepLabel : MainLabel = MainLabel()
    var DistanLabel : MainLabel = MainLabel()
    var CancelButton : MainLabel = MainLabel()
    var type_label : MainLabel = MainLabel()
  private  var CancelLabel : MainLabel = MainLabel()
    var from : MainLabel = MainLabel()
    var to : MainLabel = MainLabel()
    var price : MainLabel = MainLabel()
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
       self.addSubview(from)
        self.addSubview(type_label)
        type_label.initialize()
        from.initialize()
        to.initialize()
        price.initialize()
        DistanLabel.initialize()
        self.addSubview(to)
        self.addSubview(price)
        self.addSubview(DistanLabel)
    }
    
    func anchors() {
       from.setAnchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: price.rightAnchor, paddingTop: 20, paddingLeft: 10, paddingBottom: 10, paddingRight: 30,width: 0,height: 30)
        to.setAnchor(top: from.bottomAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: DistanLabel.leftAnchor, paddingTop: 15, paddingLeft: 10, paddingBottom: 0, paddingRight: 30,width: 0,height: 30)
        type_label.setAnchor(top: self.topAnchor, left: nil, bottom: nil, right: self.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 10, width: 100, height: 30)
        type_label.textAlignment = .right
        price.setAnchor(top: nil, left: nil, bottom: DistanLabel.topAnchor, right: self.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10)
        DistanLabel.setAnchor(top: nil, left: nil, bottom: nil, right: self.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10)
        price.textAlignment = .left
        price.textColor = maincolor
        DistanLabel.textColor = UIColor.red
        let center_price = price.centerYAnchor.constraint(equalTo: from.centerYAnchor)
        let center_distance = DistanLabel.centerYAnchor.constraint(equalTo: to.centerYAnchor)
        NSLayoutConstraint.activate([center_distance])
        from.numberOfLines = 3
        to.numberOfLines = 3
        from.text = "place1"
        to.text = "place2"
    }
    weak var viewModel : TableViewCellTaxiOrdersModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else {
                return
            }
            
            switch viewModel.order_type! {
            case "1":
                self.type = "Эконом"
            case "2":
                self.type = "Комфорт"
            case "3":
                self.type = "Корпоративный клиент"
            case "4":
                self.type = "Леди такси"
            case "5":
                self.type = "Трезвый водитель"
            default:
                break
            }
         
          
            GetDistance.getinfo(from_lat: viewModel.from_lat!, from_long: viewModel.from_long!, to_lat: viewModel.to_lat!, to_long: viewModel.to_long!) { (info) in
                for i in info.rows! {
                    for a in i.elements! {
                        self.DistanLabel.text = a.distance?.text!

                    }
                }
            }
            
            getfromgeo.get(lat: viewModel.from_lat!, long: viewModel.from_long!) { (palce) in
                self.to.text = palce
            }
            getfromgeo.get(lat: viewModel.to_lat!, long: viewModel.to_long!) { (place) in
                self.from.text = place
            }
            price.text = viewModel.price
            
        }
    }

}
