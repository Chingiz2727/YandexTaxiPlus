//
//  SavePlacePost.swift
//  newtaxi
//
//  Created by Чингиз on 28.08.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//
import UIKit
import GoogleMaps
import GooglePlaces
import GooglePlacePicker
import Alamofire
import SwiftyJSON

class SavePlace {
    class func save(name:String,lat:CLLocationDegrees,long:CLLocationDegrees,token:String) {
        let url = baseurl + "/save-address/"
        let params = ["token":token,
            "address": name,
            "latitude": lat ,
            "longitude": long
            ] as [String : Any]
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if response.data != nil {
                switch response.result {
                case.failure(let err):
                    print(err)
                case.success(let val):
                    let json = JSON(val)
                    print(json)
                }
            }
        }
    }
}
