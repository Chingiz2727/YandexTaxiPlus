//
//  AcceptFunc.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 11/1/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class AcceptFunc {
    class func accept(order_id:String,completion:@escaping(_ state:Bool,_ exist:Bool)->()) {
        let url = baseurl + "/accept-order/"
        let param = ["token":APItoken.getToken()!,
                     "order_id":order_id]
        Alamofire.request(url, method: .post, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case.failure(let error):
                print(error)
                completion(false,true)

            case.success(let value):
                let json = JSON(value)
                
                print(json)
                if json["state"].stringValue == "success" {
                    completion(true,false)

                }
                else {
                    completion(false,false)
                }
                
            }
        }
    }
}
