//
//  AddSpecificOrder.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 24.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AddSpecificOrder {
    class func City(seats_number:String,start_id:String,end_Id:String,date:CLong,price:String,completion:@escaping(_ success:Bool,_ fail:Bool)->()) {
        let url = baseurl + "/add-specific-order/"
        let params = ["token":APItoken.getToken()!,
                      "type":1,
                      "seats_number":seats_number,
                      "start_id":start_id,
                      "end_id":end_Id,
                      "price":price,
                      "date":date] as [String : Any]
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if response.data != nil {
                switch response.result {
                case.failure(let error):
                    print(error)
                case.success(let val):
                    let json = JSON(val)
                    print(json)
                    if json["state"] == "success" {
                        completion(true,false)
                    }
                    else {
                        completion(false,true)
                    }
                }
            }
        }
    }
}
