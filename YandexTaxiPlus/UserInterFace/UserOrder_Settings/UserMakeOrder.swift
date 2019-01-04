//
//  MakeOrderApi.swift
//  newtaxi
//
//  Created by Чингиз on 06.09.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import GooglePlacePicker
import Alamofire
import SwiftyJSON
import Toast_Swift
class MakeOrder {
    class func OrderApi(second_long:String,second_lat:String,first_long:String,first_lat:String,service_id:Int,comment:String,date:String,payment_type:String,completion:@escaping (_ success:Bool,_ fail:Bool,_ url:String,_ order_id:Int )->Void) {
        let fields = [
            "token":APItoken.getToken()!,
            "longitude_b":second_long,
            "latitude_b":second_lat,
            "longitude_a":first_long,
            "latitude_a":first_lat,
            "service_id":service_id,
            "comment":comment,
            "date":date,
            "payment_type":payment_type
            ] as [String : Any]
        let url = baseurl + "/make-order/"
        Alamofire.request(url, method: .post, parameters: fields, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if response.data != nil {
                switch response.result {
                case.failure(let fail):
                    print(fail)
                case.success(let val):
                    let json = JSON(val)
                    print(json)
                    let state = json["state"].stringValue
                     let url = json["url"].string
                    let orderid = json["message"].intValue
                    if state == "success"
                    {
                        print(orderid)
                        completion(true,false, url ?? "", orderid)
                    }
                    if state == "city" {
                        
                        completion(true,true,url ?? "",0)
                    }
                
                    if state == "fail" {
                        completion(false,true,"",0)
                    }
                }
            }
        }
    }
}
