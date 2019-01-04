//
//  Вк.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 12/1/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class GetDrunkPrice {
    class func GetPrice(from_lat:Double,from_long:Double,to_lat:Double,to_long:Double,comment:String,completion:@escaping(_ price:String)->()) {
        let url = baseurl + "/get-trezvy-price/"
        let params = [
            "token" :APItoken.getToken()!,
            "latitude_a":from_lat,
            "longitude_a":from_long,
            "latitude_b":to_lat,
            "longitude_b":to_long,
            "comment":comment
            ]
            as [String : Any]
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if response.data != nil {
                switch response.result {
                case.failure(let err):
                    print(err)
                case.success(let val):
                    let json = JSON(val)
                    print(json)
                    let price = json["price"].stringValue
                    completion(price)
                }
            }
            
        }
        
    }
}
