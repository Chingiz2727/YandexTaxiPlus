//
//  Rating.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 18.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
import SwiftyStarRatingView
import UIKit
extension UserMainPageViewController {
    func addRating() {
        view.addSubview(StarBack)
        StarBack.tag = 123
        StarBack.addSubview(StarRateTopImage)
        StarBack.addSubview(StarRateLabel)
        StarBack.addSubview(starRatingView)
        StarBack.addSubview(starRateTextView)
        StarBack.addSubview(starRateButton)
        StarBack.addSubview(starRateLine)
        starRateLine.setAnchor(top: StarBack.topAnchor, left: StarBack.leftAnchor, bottom: nil, right: StarBack.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 2)
        starRateLine.backgroundColor = maincolor
        StarRateTopImage.image = UIImage(named: "icon_rate")
        StarRateTopImage.setAnchor(top: StarBack.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 30, paddingBottom: 0, paddingRight: 0,width: 60,height: 60)
        StarRateLabel.setAnchor(top: StarRateTopImage.bottomAnchor, left: nil, bottom: starRatingView.topAnchor, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 10, paddingRight: 0)
        starRateTextView.setAnchor(top: starRatingView.bottomAnchor, left: nil, bottom: starRateButton.topAnchor, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, width: 250, height: 50)
        starRateButton.setAnchor(top: starRateTextView.bottomAnchor, left: nil, bottom: StarBack.bottomAnchor, right: nil, paddingTop: 3, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, width: 250, height: 50)
        starRateButton.setTitle("Оценить", for: .normal)
        starRateButton.setTitleColor(maincolor, for: .normal)
        starRateButton.backgroundColor = UIColor.clear
        starRateTextView.backgroundColor = #colorLiteral(red: 0.8881154853, green: 0.8992578747, blue: 0.8756574555, alpha: 1)
        starRateTextView.placeholder = "Коментарий к поездке"
        StarRateLabel.text = "Оцените поездку"
        StarRateLabel.font = UIFont.systemFont(ofSize: 16)
        let centerYImage = StarRateTopImage.centerXAnchor.constraint(equalTo: StarBack.centerXAnchor)
        let centerYLabel = StarRateLabel.centerXAnchor.constraint(equalTo: StarBack.centerXAnchor)
        let centerYStar = starRatingView.centerXAnchor.constraint(equalTo: StarBack.centerXAnchor)
        let centerYText = starRateTextView.centerXAnchor.constraint(equalTo: StarBack.centerXAnchor)
        let centerYButton = starRateButton.centerXAnchor.constraint(equalTo: StarBack.centerXAnchor)
        let centerXBack = StarBack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        NSLayoutConstraint.activate([centerXBack,centerYLabel,centerYImage,centerYStar,centerYText,centerYButton])
        StarBack.backgroundColor = UIColor.white
        StarBack.setAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: starRateButton.bottomAnchor, right: view.rightAnchor, paddingTop: 200, paddingLeft: 20, paddingBottom: -20, paddingRight: 20)
        starRatingView.backgroundColor = UIColor.clear
        starRatingView.setAnchor(top: StarRateLabel.bottomAnchor, left: nil, bottom: starRateTextView.topAnchor, right: nil, paddingTop: 10, paddingLeft: 70, paddingBottom: 10, paddingRight: 70,width: 0,height: 30)
        //        starRatingView.frame = CGRect(x: 100, y: 100, width: 100, height: 50)
        starRatingView.allowsHalfStars = false
        starRatingView.maximumValue = 5         //default is 5
        starRatingView.minimumValue = 0         //default is 0
        starRatingView.value = 1                //default is 0
        starRatingView.tintColor = maincolor
        starRatingView.addTarget(self, action: #selector(function(start:)), for: .valueChanged)
        starRateButton.addTarget(self, action: #selector(addratin), for: .touchUpInside)
    }
   @objc func addratin() {
    AddRecomend.recomendation(text: starRateTextView.text!, rating: Double(starRatingView.value)) { (yes, no) in
            if yes {
                self.view.makeToast("Спасибо за рекомендацию")
                let viewwith = self.view.viewWithTag(123)
                let vie = self.view.viewWithTag(23)
                let vie2 = self.view.viewWithTag(22)
                vie?.removeFromSuperview()
                vie2?.removeFromSuperview()
                viewwith?.removeFromSuperview()
                self.MainMapview.mapview.clear()
                self.SetupMainView()
            }
            
        }
    }
}
