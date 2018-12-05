//
//  GetUserInfo.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 17.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class BuyAcessFunc {
    
    class func Buy(publish:String,type:String,completion:@escaping(_ yes:Bool,_ No:Bool)->()) {

        let url = baseurl + "/buy-access/"
        let params = [
            "token":APItoken.getToken()!,
            "type":type,
            "publish":publish
            
        ]
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case.failure(let err):
                print(err)
            case.success(let val):
                var json = JSON(val)
                print(json)
                if json["state"].stringValue == "success" {
                  completion(true,false)
                }
            if json["state"].stringValue == "Your balance not enought"
            {
                completion(false,true)

                }
            }
        }
       
    }
}
