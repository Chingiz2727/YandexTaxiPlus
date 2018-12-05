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
  private  var AccepLabel : MainLabel = MainLabel()
    var DistanLabel : MainLabel = MainLabel()
    var CancelButton : MainLabel = MainLabel()
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
        price.setAnchor(top: nil, left: nil, bottom: nil, right: self.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10)
        DistanLabel.setAnchor(top: nil, left: nil, bottom: nil, right: self.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10)
        price.textAlignment = .left
        price.textColor = maincolor
        DistanLabel.textColor = UIColor.red
        let center_price = price.centerYAnchor.constraint(equalTo: from.centerYAnchor)
        let center_distance = DistanLabel.centerYAnchor.constraint(equalTo: to.centerYAnchor)
        NSLayoutConstraint.activate([center_price,center_distance])
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
            
            Geocoding.LocationName(lat: viewModel.from_lat!, long: viewModel.from_long!) { (first_loc) in
                let first_place2 = first_loc!.results![0].addressComponents![0].shortName ?? ""
                let first_place3 = first_loc!.results![0].addressComponents![1].shortName ?? ""
                let finist = "\(first_place3) \(first_place2)"
                
                print(first_place2)
                self.from.text = finist
            }
            
            
            Geocoding.LocationName(lat: viewModel.to_lat!, long: viewModel.to_long!) { (first_loc) in
                let first_place2 = first_loc!.results![0].addressComponents![0].shortName ?? ""
                let first_place3 = first_loc!.results![0].addressComponents![1].shortName ?? ""
                let finist = "\(first_place3) \(first_place2)"
                print(first_loc!.results![0].addressComponents!)
                self.to.text = finist
            }
            
            
            GetDistance.getinfo(from_lat: viewModel.from_lat!, from_long: viewModel.from_long!, to_lat: viewModel.to_lat!, to_long: viewModel.to_long!) { (info) in
                for i in info.rows! {
                    for a in i.elements! {
                        self.DistanLabel.text = a.distance.text!

                    }
                }
            }
            price.text = viewModel.price
        }
    }

}
