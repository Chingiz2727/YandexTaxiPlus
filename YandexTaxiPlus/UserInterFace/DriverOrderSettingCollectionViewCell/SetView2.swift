//
//  SetView2.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 12/12/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
import UIKit
import Toast_Swift
import Alamofire
class SettingColectionView : NSObject,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    var user:UserMainPageProtocol?
    var CarsCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero , collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .white
        cv.layer.masksToBounds = false
        return cv
    }()
    
    var PayCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero , collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .white
        cv.layer.masksToBounds = false
        return cv
    }()
    
    var paybaycard:payByCard?
    var Profview : FooterCollectionViewCell?
    let blackview = UIView()
    var Ordered : ordermaked?
    
    var selectedindexpath : IndexPath!
    var selectedindexpath1 : IndexPath!
    
    var paytype = [Payment(type: "Наличные", icon: "icon_by_hand", sec_icon: "icon_by_hand_p"),
                   Payment(type: "Карта", icon: "icon_by_card", sec_icon: "icon_by_card_p"),
                   Payment(type: "Монеты", icon: "icon_by_bonuses", sec_icon: "icon_by_bonuses_p")]
    
    var PriceCar = [carPrice]()
    var cellid = "cellid"
    var cellid2 = "cellid2"
    var footerview = "foooter"
    var comment : String?
    var date : String?
    var service_id : Int?
    var payment_type : Int = 1
    var first_lat : String?
    let window : UIWindow = UIApplication.shared.keyWindow!
    
    var first_long : String?
    var second_lat:String?
    var second_long : String?
    var button : MainButton = MainButton()
    var fullview = UIView()
    
    
    
    override init() {
        super.init()
        CarsCollection.dataSource = self
        CarsCollection.delegate = self
        PayCollection.delegate = self
        PayCollection.dataSource = self
        CarsCollection.register(PriceCell.self, forCellWithReuseIdentifier: cellid)
        PayCollection.register(CarCell.self, forCellWithReuseIdentifier: cellid2)
        PayCollection.register(FooterCollectionViewCell.self, forCellWithReuseIdentifier: footerview)
        CarsCollection.bounces = false
        
    }
    
    func lets() {
        window.addSubview(blackview)
        window.addSubview(fullview)
        fullview.addSubview(CarsCollection)
        fullview.addSubview(PayCollection)
        blackview.backgroundColor = UIColor(white: 0, alpha: 0.5)
        blackview.frame = window.frame
        blackview.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
        fullview.setAnchor(top: nil, left: window.leftAnchor, bottom: window.bottomAnchor, right: window.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 400, height: 270)
        CarsCollection.setAnchor(top: fullview.topAnchor, left: fullview.leftAnchor, bottom: nil, right: fullview.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 400, height: 90)
        PayCollection.setAnchor(top: CarsCollection.bottomAnchor, left: fullview.leftAnchor, bottom: nil, right: fullview.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 400, height: 180)
        let height : CGFloat = 270
        let y = window.frame.height - height
        
        
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.blackview.alpha = 1
            self.fullview.frame = CGRect(x: 0, y: y, width: self.fullview.frame.width, height: self.fullview.frame.height)
        }, completion: nil)
        
    }
    
    
    @objc func handleDismiss() {
        UIView.animate(withDuration: 0.1) {
            if let window = UIApplication.shared.keyWindow {
                self.blackview.alpha = 0
                self.fullview.removeFromSuperview()
            }
        }
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
            self.PayCollection.reloadData()
            self.CarsCollection.reloadData()
        }
    }
    
    @objc func makeorder(){
        window.makeToastActivity(.center)
        button.isEnabled = false
        guard let window = UIApplication.shared.keyWindow else {return}
        window.makeKeyAndVisible()
        MakeOrder.OrderApi(second_long: self.second_long!, second_lat: self.second_lat!, first_long: self.first_long!, first_lat: self.first_lat!, service_id: service_id!, comment: comment!, date: date!, payment_type: String(payment_type)) { (yes, no,url,id)  in
            if yes {
                if self.payment_type == 2 {
                    self.paybaycard?.PayingByCard(url: url)
                    self.user?.order_id = id

                }
                self.Ordered?.OrderMaked()
                window.hideToastActivity()
                self.handleDismiss()
                self.user?.order_id = id
            }
            if no == true {
                window.hideToastActivity()
                self.handleDismiss()
            }
            
        }
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        switch collectionView {
        case PayCollection:
            return 2
        case CarsCollection:
            return 1
        default:
            break
        }
        return 0
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == PayCollection {
            if section == 1 {
                return 1
            }
            return paytype.count
           
        }
        
        if collectionView == CarsCollection {
            return PriceCar.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == CarsCollection {
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
            return cell
        }
        
        if collectionView == PayCollection {
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: cellid2, for: indexPath) as! CarCell
            
            cell2.img.image = UIImage.init(named: paytype[indexPath.row].icon)
            cell2.type.text = paytype[indexPath.row].type
            cell2.type.textColor = UIColor.black
            if indexPath == selectedindexpath1 {
                cell2.img.image = UIImage.init(named: paytype[indexPath.row].sec_icon)
                cell2.type.textColor = maincolor
            }
            if indexPath.section == 1 {
                let cell3 = collectionView.dequeueReusableCell(withReuseIdentifier: footerview, for: indexPath) as! FooterCollectionViewCell
                cell3.button.addTarget(self, action: #selector(makeorder), for: .touchUpInside)
                return cell3
            }
            return cell2
        }
        let cell = UICollectionViewCell()
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 1
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(PriceCar.count - 1))
        if collectionView == CarsCollection {
            let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(PriceCar.count ))
            return CGSize(width: size, height: 90)
        }
        if collectionView == PayCollection {
            let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(paytype.count ))
            if indexPath.section == 1 {
                return CGSize(width: (collectionView.window?.width)!, height: 90)
            }
            return CGSize(width: size, height: 90)
           
        }
        
        return CGSize(width: 0, height: 0)
        
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var prevselected:IndexPath!
        var prevselected1: IndexPath!
        
        switch collectionView {
        case CarsCollection:
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
        case PayCollection:
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
            payment_type = indexPath.row + 1
        default:
            break
        }
    }
    

}
