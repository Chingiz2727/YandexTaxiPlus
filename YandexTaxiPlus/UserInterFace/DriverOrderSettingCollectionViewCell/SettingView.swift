//
//  SettingView.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 11/16/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import GoogleMaps
import Toast_Swift
class SettingColectionVierw : NSObject,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    var paybaycard:payByCard?
    var Profview : FooterCollectionViewCell?
    let blackview = UIView()
    var Ordered : ordermaked?
    var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero , collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .white
        cv.layer.masksToBounds = false
        return cv
    }()
    var selectedindexpath : IndexPath!
    var selectedindexpath1 : IndexPath!

    var paytype = [Payment(type: "Наличные", icon: "icon_by_hand", sec_icon: "icon_by_hand_p",pay_type:"1"),
                   Payment(type: "Карта", icon: "icon_by_card", sec_icon: "icon_by_card_p",pay_type:"2"),
                   Payment(type: "Монеты", icon: "icon_by_bonuses", sec_icon: "icon_by_bonuses_p",pay_type:"3")]

    var PriceCar = [carPrice]()
    var cellid = "cellid"
    var cellid2 = "cellid2"
    var footerview = "foooter"
    var comment : String?
    var date : String?
    var service_id : Int?
    var payment_type : String?
    var first_lat : String?
    let window : UIWindow = UIApplication.shared.keyWindow!

    var first_long : String?
    var second_lat:String?
    var second_long : String?
    var button : MainButton = MainButton()
    override init() {
        super.init()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PriceCell.self, forCellWithReuseIdentifier: cellid)
        collectionView.register(CarCell.self, forCellWithReuseIdentifier: cellid2)
        collectionView.register(FooterCollectionViewCell.self, forCellWithReuseIdentifier: footerview)
        collectionView.bounces = false
    }
    func lets()
    {
            window.addSubview(blackview)
            window.addSubview(collectionView)
            blackview.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackview.frame = window.frame
            blackview.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            self.button.addTarget(self, action: #selector(makeorder), for: .touchUpInside)
            collectionView.setAnchor(top: nil, left: window.leftAnchor, bottom: window.bottomAnchor, right: window.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 400, height: 270)
            let height:CGFloat = 270

            let y = window.frame.height - height
            
            UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                self.blackview.alpha = 1
                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }, completion: nil)
        
    }
    
    @objc func handleDismiss() {
        UIView.animate(withDuration: 0.1) {
            if let window = UIApplication.shared.keyWindow {
                self.blackview.alpha = 0
                self.collectionView.removeFromSuperview()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
            //                _ = cell.img.restorationIdentifier
            var prevselected:IndexPath!
            var prevselected1: IndexPath!
        if indexPath.section == 1 {
            if selectedindexpath1 != nil {
                if selectedindexpath1 == indexPath  {
                    selectedindexpath1 = nil
                }
                else  {
                    prevselected1 = IndexPath(row: (selectedindexpath1?.row)!, section: (selectedindexpath1?.section)!)
                    selectedindexpath1 = indexPath
                }
            }
            else {
                selectedindexpath1 = indexPath
            }
            if prevselected1 != nil {
                collectionView.reloadItems(at: [indexPath,prevselected1!])
            }
            else {
                collectionView.reloadItems(at: [indexPath])
            }
            payment_type = paytype[indexPath.row].pay_type

        }
        if indexPath.section == 0 {
            if selectedindexpath != nil {
                if selectedindexpath == indexPath  {
                    selectedindexpath = nil
                }
                else  {
                    prevselected = IndexPath(row: (selectedindexpath?.row)!, section: (selectedindexpath?.section)!)
                    selectedindexpath = indexPath
                }
            }
            else {
                selectedindexpath = indexPath
            }
            if prevselected != nil {
                collectionView.reloadItems(at: [indexPath,prevselected!])
            }
            else {
                collectionView.reloadItems(at: [indexPath])
            }
            service_id = PriceCar[indexPath.row].service_id

        }
        
       
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellid, for: indexPath) as! PriceCell
        Alamofire.request(PriceCar[indexPath.row].img).response { (response) in
            cell.img.image = UIImage.init(data: response.data!)
        }
        if indexPath == selectedindexpath {
            cell.price.textColor = maincolor
            cell.type.textColor = maincolor
            Alamofire.request(PriceCar[indexPath.row].img1).responseJSON { (response) in
                cell.img.image = UIImage(data: response.data!)
            }
        }
        cell.type.textColor =  UIColor.black
        cell.price.textColor = UIColor.black
        cell.price.text = String(PriceCar[indexPath.row].price)
        cell.type.text = PriceCar[indexPath.row].type
        cell.type.textColor =  UIColor.black
        
        if indexPath.section == 1 {
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: cellid2, for: indexPath) as! CarCell
           
            cell2.img.image = UIImage.init(named: paytype[indexPath.row].icon)
            cell2.type.text = paytype[indexPath.row].type
            cell2.type.textColor = UIColor.black
            if indexPath == selectedindexpath1 {
                cell2.img.image = UIImage.init(named: paytype[indexPath.row].sec_icon)
                cell2.type.textColor = maincolor
            }
            return cell2
        }
        if indexPath.section == 2 {
            let cell3 = collectionView.dequeueReusableCell(withReuseIdentifier: footerview, for: indexPath) as! FooterCollectionViewCell
            cell3.button.addTarget(self, action: #selector(makeorder), for: .touchUpInside)
            return cell3
        }
        return cell
        
            }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 1 {
            return paytype.count
        }
        if section == 2 {
            return 1
        }
        
        return PriceCar.count
    }
    
    func datareload(first_long:String,first_lat:String,second_lat:String,second_long:String,comment:String,date:String,type:String) {
        self.first_long = first_long
        self.first_lat = first_lat
        self.second_lat = second_lat
        self.second_long = second_long
        self.comment = comment
        self.date = date
        getPrice.getprice(first_long: first_long, first_lat: first_lat, second_lat: second_lat, second_long: second_long, type: type) { (price) in
            self.PriceCar = price
            self.lets()
            self.collectionView.reloadData()
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    @objc func makeorder(){
        window.makeToastActivity(.center)
        button.isEnabled = false
        guard let window = UIApplication.shared.keyWindow else {return}
        window.makeKeyAndVisible()
        MakeOrder.OrderApi(second_long: self.second_long!, second_lat: self.second_lat!, first_long: self.first_long!, first_lat: self.first_lat!, service_id: service_id!, comment: comment!, date: date!, payment_type: String(payment_type!)) { (yes, no,url,order_id)  in
            if yes {
                if self.payment_type! == "2" {
                    self.paybaycard?.PayingByCard(url: url)
                }
                self.Ordered?.OrderMaked()
                window.hideToastActivity()
                self.handleDismiss()
            }
          
            if no == true {
                window.hideToastActivity()
                self.handleDismiss()
            }
           
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 1
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(PriceCar.count - 1))
        if indexPath.section == 1 {
            let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(paytype.count ))
            return CGSize(width: size, height: 80)
        }
        if indexPath.section == 2 {
            return CGSize(width: (collectionView.window?.width)!, height: 80)
        }
        let siz = CGFloat(collectionView.frame.width / CGFloat(PriceCar.count))

        return CGSize(width: siz, height: 80)
    }
    
    
    
    
}
