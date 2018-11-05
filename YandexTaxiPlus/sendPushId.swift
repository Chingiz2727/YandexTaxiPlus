//
//  SendPushId.swift
//  newtaxi
//
//  Created by Чингиз on 10.09.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
import GoogleMaps
import GooglePlaces
class sendPushId {
    class func send(token:String,long_a:CLLocationDegrees,lat_a:CLLocationDegrees,completion:@escaping(_ session:Int,_ balance:Int, _ status:Int,_ orderStatus:Int,_ order_id:Int)->()) {
        let url = baseurl + "/set-push-id/"
        let params = [
            "token":APItoken.getToken()!,
            "push_id":token,
            "lat":lat_a,
            "long":long_a,
            "platform": "1"
            ] as [String : Any]
        print(params)
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if response.data != nil {
                switch response.result {
                case.failure( let error):
                    print(error)
                case.success(let val):
                    var json = JSON(val)
                    print(json)
                    
                    if json["state"] != "fail" {
                        let status = json["is_active"].int
                        let balance = json["balance"].int
                        let session = json["is_session_opened"].int
                        let orderStatus = json["status"].int
                        let order_id = json["order_id"] as? Int ?? 0
                        
                        completion(session!,balance!,status!,orderStatus!,order_id)
                    }
                    else {
                        completion(0,0,0,0,0)
                        
                    }
                    
                }
            }
        }
       
    }
}
