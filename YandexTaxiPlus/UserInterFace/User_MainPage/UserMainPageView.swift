//
//  UserMainPageView.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 15.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit
import GoogleMaps

class UserMainPageView: UIView {
    var mapview : GMSMapView!
    var ToAction: (() -> Void)?
    var FromAction: (() -> Void)?
    var SearchAction: (() -> Void)?
    var ChooseAction: (() -> Void)?
    var MenuAction: (() -> Void)?
    var menuimage : UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        To.tag = 1
        From.tag = 0
        Call.tag = 2
        mapview.tag = 3
       
        NotificationCenter.default.addObserver(self, selector: #selector(self.remove(notification:)), name: NSNotification.Name(rawValue: "delete"), object: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func remove(notification:NSNotification) {
        setup()
        From.removeFromSuperview()
        To.removeFromSuperview()
        Call.removeFromSuperview()
        Route.Draw(startlat: first_lat, startlong: first_long, endlat: second_lat, englong: second_long, map: mapview)
    }
    
  
    
    let From : UIButton = {
        let next = UIButton()
        next.backgroundColor = UIColor.white
        next.layer.cornerRadius = 10.0
        next.layer.shadowRadius = 3.0
        next.layer.shadowColor = UIColor.black.cgColor
        next.layer.shadowOffset = CGSize(width: 1, height: 1)
        next.layer.shadowOpacity = 0.4
        next.setTitle("Откуда", for: .normal)
        next.setTitleColor(UIColor.init(r: 104, g: 205, b: 179), for: .normal)
        next.addTarget(self, action: #selector(FromGo), for: .touchUpInside)

        return next
    }()
    let To : UIButton = {
        let next = UIButton()
        next.backgroundColor = UIColor.white
        next.layer.cornerRadius = 10.0
        next.layer.shadowRadius = 3.0
        next.layer.shadowColor = UIColor.black.cgColor
        next.layer.shadowOffset = CGSize(width: 1, height: 1)
        next.layer.shadowOpacity = 0.4
        next.setTitle("Куда", for: .normal)
        next.setTitleColor(UIColor.init(r: 104, g: 205, b: 179), for: .normal)
        next.addTarget(self, action: #selector(ToGo), for: .touchUpInside)

        return next
    }()
    let Call : UIButton = {
        let next = UIButton()
        next.backgroundColor = UIColor.init(r: 104, g: 205, b: 179)
        next.layer.cornerRadius = 10.0
        next.layer.shadowRadius = 3.0
        next.layer.shadowColor = UIColor.black.cgColor
        next.layer.shadowOffset = CGSize(width: 1, height: 1)
        next.layer.shadowOpacity = 0.4
        next.setTitle("Начать поездку", for: .normal)
        next.setTitleColor(UIColor.white, for: .normal)
        next.addTarget(self, action: #selector(Calling), for: .touchUpInside)
        return next
    }()
    let Detect : UIButton = {
        let next = UIButton()
        next.backgroundColor = UIColor.init(r: 104, g: 205, b: 179)
        next.layer.cornerRadius = 18.0
        next.layer.shadowRadius = 3.0
        next.layer.shadowColor = UIColor.black.cgColor
        next.layer.shadowOffset = CGSize(width: 1, height: 1)
        next.layer.shadowOpacity = 0.4
        next.setImage(UIImage(named: "location-marker"), for: .normal)
        next.imageView?.contentMode = .scaleAspectFit
        next.addTarget(self, action: #selector(Detection), for: .touchUpInside)
        return next
    }()
    @objc func ToGo(sender:UIButton)
    {
        print("Go")
        ToAction?()
    }
    @objc func FromGo(sender:UIButton) {
        FromAction?()
        print("To")
        
    }
    @objc func Calling() {
        ChooseAction?()
        print("Call")
        
    }
    @objc func Detection() {
        SearchAction?()
        print("Go")
        
    }
    func setup() {
        let mapWidth:CGFloat = self.bounds.size.width
        let mapHeight:CGFloat = self.bounds.size.height
        mapview = GMSMapView.map(withFrame: (CGRect(x: 0, y: 0, width: mapWidth, height: mapHeight)), camera: GMSCameraPosition.camera(withLatitude: 43.222015, longitude: 76.851250, zoom: 12.5))
        
        do {
            mapview.mapStyle = try! GMSMapStyle(jsonString: MapStyle().kMapStyle)
        }
        catch
        {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
        self.addSubview(mapview)
        self.addSubview(From)
        self.addSubview(To)
        self.addSubview(Call)
        self.addSubview(Detect)
        self.addSubview(menuimage)
        From.setAnchor(top: nil, left: self.leftAnchor, bottom: To.topAnchor, right: self.rightAnchor, paddingTop: 0, paddingLeft: 40, paddingBottom: 10, paddingRight: 40, width: 50, height: 50)
        To.setAnchor(top: nil, left: self.leftAnchor, bottom: Call.topAnchor, right: self.rightAnchor, paddingTop: 0, paddingLeft: 40, paddingBottom: 10, paddingRight: 40, width: 50, height: 50)
        Call.setAnchor(top: nil, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 0, paddingLeft: 40, paddingBottom: 40, paddingRight: 40, width: 50, height: 50)
        Detect.setAnchor(top: nil, left: nil, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 280, paddingRight: 35, width: 35, height: 35)
        menuimage.setAnchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 30, paddingBottom: 0, paddingRight: 0, width: 20, height: 20)
        menuimage.image = UIImage(named: "hamburger-menu-icon")
        menuimage.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        menuimage.addGestureRecognizer(tapGestureRecognizer)
        
    }
    

    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        MenuAction?()
        // Your action
    }

}
