//
//  DriverMapView.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 30.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit
import GoogleMaps
class DriverMapView: UIView {
    var mapview : GMSMapView!
    
    var SearchAction: (() -> Void)?
    var MenuAction: (() -> Void)?
    var menuimage : UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    let icon : UIImageView = UIImageView()
   
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
    @objc func Detection() {
        SearchAction?()
        print("Go")
    }
    
    func setup() {
        let mapWidth:CGFloat = self.bounds.size.width
        let mapHeight:CGFloat = self.bounds.size.height
        mapview = GMSMapView.map(withFrame: (CGRect(x: 0, y: 0, width: mapWidth, height: mapHeight)), camera: GMSCameraPosition.camera(withLatitude: 43.222015, longitude: 76.851250, zoom: 12.5))
        self.addSubview(mapview)
        self.addSubview(Detect)
        self.addSubview(menuimage)
        Detect.setAnchor(top: nil, left: nil, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 280, paddingRight: 35, width: 35, height: 35)
        menuimage.setAnchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 30, paddingBottom: 0, paddingRight: 0, width: 30, height: 25)
        menuimage.image = UIImage(named: "icon_menu")
       
        menuimage.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        menuimage.addGestureRecognizer(tapGestureRecognizer)
        if APItoken.getColorType() == 1 {
            do {
                mapview.mapStyle = try! GMSMapStyle(jsonString: MapStyle().kMapStyle)
            } catch {
                NSLog("One or more of the map styles failed to load. \(error)")
            }
        }
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        MenuAction?()
        // Your action
    }
}



