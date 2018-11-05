//
//  GetOrderInfo.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 29.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class GetOrderInfo {
    class func GetInfo(order_id:String,completion:@escaping(_ info:OrderInfo)->()) {
        let url = baseurl + "/get-order-info/"
        let params = ["order_id":order_id]
        
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if response.data != nil {
                switch response.result {
                case.failure(let error):
                    print(error)
                case.success(let val):
                    let json = JSON(val)
                    guard let data = response.data else {return}
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let root = try decoder.decode(OrderInfo.self, from: data)
                        completion(root)
                    }
                    catch {
                        print("Bigerror")
                        print(error)
                    }
                    
                }
            }
        }
    }
}
