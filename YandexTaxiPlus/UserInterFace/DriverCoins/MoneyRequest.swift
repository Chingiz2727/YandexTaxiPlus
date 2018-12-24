//
//  MoneyRequest.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 12/7/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class MoneyRequest {
    class func makerequest(card_num:String,amount:String,completion:@escaping(_ success:Bool ,_ nomoney:Bool)->()) {
        
        let url = baseurl + "/money-request/"
        let params = [
            "token":APItoken.getToken()!,
            "amount":amount,
            "card_number":card_num
        ]
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if response.data != nil {
                switch response.result {
                case.failure(let error):
                    completion(false,false)
                case.success(let val):
                    let json = JSON(val)
                    if json["state"].stringValue == "success" {
                        completion(true,false)
                    }
                    if json["state"].stringValue == "fail" {
                        completion(false,true)
                    }
                }
            }
        }

    }
}
