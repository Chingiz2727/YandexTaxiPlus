//
//  SendLocation.swift
//  newtaxi
//
//  Created by Чингиз on 27.09.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
import GoogleMaps
import GooglePlaces

class SendLocation {
    class func sendloc(longitude:String,latitude:String,order_id:String) {
        let params = ["token":APItoken.getToken()!,
                      "longitude":longitude,
                      "latitude":latitude,
                      "order_id":order_id ]
        let url = baseurl + "/check-location/"
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if response.data != nil {
                switch response.result {
                case.failure( let err):
                    print(err)
                case.success(let val):
                    let json = JSON(val)
                    print(json)
                }
            }
        }
    }
}
