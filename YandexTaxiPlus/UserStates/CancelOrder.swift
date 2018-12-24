//
//  CancelOrder.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 11/19/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class Cancel  {
    class func Cancel(order_id:String?,complition:@escaping(_ success:Bool)->()) {
        let url = baseurl + "/cancel-order/"
        let params = [
            "token":APItoken.getToken()!,
            "order_id":order_id!
            ] 
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
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
