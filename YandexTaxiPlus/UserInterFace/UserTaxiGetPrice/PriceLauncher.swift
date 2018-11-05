    //
    //  PriceAndCar.swift
    //  Taxi+
    //
    //  Created by Чингиз on 17.08.2018.
    //  Copyright © 2018 Чингиз. All rights reserved.
    //
    
    import UIKit
    import Alamofire
    import SwiftyJSON
    import Toast_Swift
    extension UserMainPageViewController : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
      
     
        
        func showSettings() {
                blackview.backgroundColor = UIColor(white: 0, alpha: 0.5)
                blackview.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
                view.addSubview(blackview)
                view.addSubview(mainview)
                view.addSubview(colletionView)
                
                //            mainview.addSubview(colletionView)
                view.addSubview(collview)
                mainview.addSubview(button)
                button.layer.cornerRadius = 18.0
                button.setAnchor(top: nil, left: mainview.leftAnchor, bottom: mainview.bottomAnchor, right: mainview.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 15, paddingRight: 20,width: 50,height: 50)
                button.setTitle("Вызвать", for: .normal)
                button.backgroundColor = UIColor.init(r: 104, g: 205, b: 179)
                button.setTitleColor(UIColor.white, for: .normal)
                button.addTarget(self, action: #selector(makeorder), for: .touchUpInside)
                mainview.backgroundColor = UIColor.white
                let height:CGFloat = 220
                let y = view.frame.height - height
                mainview.frame = CGRect(x: 0, y: y, width: view.frame.width, height: height)
                colletionView.frame = CGRect(x: 0, y: y, width: view.frame.width, height: 70)
                collview.frame = CGRect(x: 0, y: y+colletionView.height+1, width: view.frame.width, height: 70)
                blackview.frame = view.frame
                blackview.alpha = 0
                UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                    self.blackview.alpha = 1
                    
                    self.mainview.frame = CGRect(x: 0, y: y, width: self.mainview.frame.width, height: self.mainview.frame.height)
                }, completion: nil)
                
                
                
            
            
        }
        
       @objc func data() {
        getPrice.getprice(type: "1") { (PriceCar:[carPrice]?) in
                self.view.makeToastActivity(.center)
                if let PriceCar = PriceCar {
                    self.PriceCar = PriceCar
                    self.view.hideToastActivity()
                    self.showSettings()
                    self.colletionView.reloadData()
                }
        }
        }
        
        @objc func handleDismiss() {
            UIView.animate(withDuration: 0.5) {
                self.blackview.alpha = 0
                if UIApplication.shared.keyWindow != nil {
                    self.mainview.frame = CGRect(x: 0, y: self.view.frame.height, width: self.mainview.frame.width, height: self.mainview.frame.height)
                    self.colletionView.frame = CGRect(x: 0, y: self.view.frame.height, width: self.colletionView.frame.width, height: self.colletionView.frame.height)
                    self.collview.frame = CGRect(x: 0, y: self.view.frame.height, width: self.collview.frame.width, height: self.collview.frame.height)
                    
                }
            }
        }
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            if collectionView == colletionView {
                let cell = collectionView.cellForItem(at: indexPath) as! PriceCell
                _ = cell.img.restorationIdentifier
                var prevselected:IndexPath!
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
                    colletionView.reloadItems(at: [indexPath,prevselected!])
                }
                else {
                    collectionView.reloadItems(at: [indexPath])
                }
                
                service_id = PriceCar[indexPath.row].service_id
                
            }
            
        }
        
        
        @objc func makeorder() {
            self.view.makeToastActivity(.center)
            MakeOrder.OrderApi(service_id: service_id, comment: "", date: "", payment_type: "1") { (success, fail) in
                if success {
                    self.view.hideToastActivity()
                    
                    Route.Draw(startlat: first_lat, startlong: first_long, endlat: second_lat, englong: second_long, map: self.MainMapview.mapview)
                    self.handleDismiss()
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "delete"), object: nil, userInfo: nil)
                }
                if fail {
                    self.view.hideToastActivity()
                    self.view.makeToast("Ошибка")
                }
            }
          
            
        }
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if collectionView == self.colletionView {
                return PriceCar.count
            }
            if collectionView == self.collview {
                return paytype.count
                
            }
            return 0
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
            flowLayout.minimumLineSpacing = 0
            flowLayout.minimumInteritemSpacing = 1
            if collectionView == self.colletionView {
                let totalSpace = flowLayout.sectionInset.left
                    + flowLayout.sectionInset.right
                    + (flowLayout.minimumInteritemSpacing * CGFloat(PriceCar.count - 1))
                let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(PriceCar.count ))
                return CGSize(width: size, height: 70)
            }
            let totalSpace = flowLayout.sectionInset.left
                + flowLayout.sectionInset.right
                + (flowLayout.minimumInteritemSpacing * CGFloat(paytype.count - 1))
            let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(paytype.count ))
            return CGSize(width: size, height: 70)
            
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            if collectionView == colletionView {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellid, for: indexPath) as! PriceCell
                Alamofire.request(PriceCar[indexPath.row].img).responseJSON { (response) in
                    cell.img.image = UIImage(data: response.data!)
                }
                if indexPath == selectedindexpath {
                    Alamofire.request(PriceCar[indexPath.row].img1).responseJSON { (response) in
                        cell.img.image = UIImage(data: response.data!)
                    }
                }
                cell.img.restorationIdentifier  = PriceCar[indexPath.row].img
                cell.price.text = String(PriceCar[indexPath.row].price)
                cell.type.text = PriceCar[indexPath.row].type
                return cell
            }
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: cellid2, for: indexPath) as! CarCell
            cell2.img.image = UIImage(named: paytype[indexPath.row].icon)
            cell2.type.text = paytype[indexPath.row].type
            return cell2
        }
        
      
    func register() {
    colletionView.register(PriceCell.self, forCellWithReuseIdentifier: cellid)
    collview.register(CarCell.self, forCellWithReuseIdentifier: cellid2)
    colletionView.delegate = self
    collview.delegate = self
    colletionView.dataSource = self
    collview.dataSource = self
    }
    }
