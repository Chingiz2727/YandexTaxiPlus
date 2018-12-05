//
//  EvoMakeOrder.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 11/18/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class EvoMakeOrder {
    class func MakeOrder(type:String,comment:String,start:String,end:String,price:String,date:String,state:@escaping(_ success:Bool)->()) {
        let url = baseurl + "/add-specific-order/"
        let params = [
            "token":APItoken.getToken()!,
            "type":type,
            "comment":comment,
            "start_string":start,
            "end_string":end,
            "price":price,
            "date":date
        ]
      
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                if response.data != nil {
                    switch response.result {
                    case.failure(let error):
                        print(error)
                    case.success(let val):
                        let json = JSON(val)
                        print(json)
                        if json["state"] == "success" {
                            state(true)
                        }
                        if json["state"] == "do not have access" {
                            state(false)
                        }
                    }
                }
            }
        
   
    }

}

