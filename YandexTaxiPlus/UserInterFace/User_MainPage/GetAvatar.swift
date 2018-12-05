//
//  GetAvatar.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 19.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class GetAvatar {
    class func get(completion:@escaping(_ data:String)->()) {
        let url = baseurl + "/get-avatar/"
        let params = ["token":APItoken.getToken()!]
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case.failure(let error):
                print(error)
            case.success(let value):
                let json = JSON(value)
                
                let avatar = json["avatar"].stringValue
                print("avatar")
                print(json)
                completion(avatar)
            }
        }
    }
}
