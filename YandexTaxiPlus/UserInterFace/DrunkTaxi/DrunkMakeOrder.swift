//
//  DrunkMakeOrder.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 12/1/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class DrunkMakerOrder {
    class func make(lat_a:Double,long_a:Double,lat_b:Double,long_b:Double,comment:String,kpp:Int,complition:@escaping(_ success:Bool)->()) {
        let url = baseurl + "/make-order/"
        
        let params = [
            "token":APItoken.getToken()!,
            "longitude_b":long_b,
            "latitude_b":lat_b,
            "longitude_a":long_a,
            "latitude_a":lat_a,
            "service_id":"5",
            "comment":comment,
            "payment_type":"1",
            "kpp":kpp
            ] as [String : Any]
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if response.data != nil {
                switch response.result {
                case.failure(let error):
                    print(error)
                case.success(let val):
                    let json = JSON(val)
                    print(json)
                    if json["state"].stringValue == "success" {
                        complition(true)
                    }
                    else {
                        complition(false)
                    }
                }
            }
        }
    }
}
