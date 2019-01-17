//
//  GetChatOrders.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 11/5/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class getcharorders {
    class func get(url:String,completion:@escaping(_ order:[ChatOrders]?)->()) {
        let url = baseurl + url
        let params = ["token":APItoken.getToken()!]
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if response.data != nil {
                switch response.result {
                case.failure(let error):
                    print(error)
                case.success(let val):
                    let json = JSON(val)
                    print(json)
                    var price = [ChatOrders]()
                    guard let dataarr = json["orders"].array else {
                        return
                    }
                    for add in dataarr {
                        guard let add = add.dictionary else { return }
                        let pricing = ChatOrders()
                      
                        pricing.id = add["id"]?.string ?? ""
                        pricing.created = add["created"]?.string ?? ""
                        pricing.from_latitude = add["from_latitude"]?.string ?? ""
                        pricing.from_longitude = add["from_longitude"]?.string ?? ""
                        pricing.name = add["name"]?.string ?? ""
                        pricing.phone = add["phone"]?.string ?? ""
                        pricing.price = add["price"]?.string ?? ""
                        pricing.to_latitude = add["to_latitude"]?.string ?? ""
                        pricing.to_longitude = add["to_longitude"]?.string ?? ""
                        pricing.order_type = add["order_type"]?.string ?? ""
                        price.append(pricing)
                    }
                    completion(price)
                }
            }
            }
        }
    }

