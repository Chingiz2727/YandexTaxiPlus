//
//  GetChatsList.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 23.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class GetChatList {
    class func Get(type:Int) {
        let url = baseurl + "/get-specific-chats/"
        let params = ["token": APItoken.getToken()!,
                      "type" : type] as [String : Any]
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if response.data != nil {
                switch response.result {
                case.failure(let error):
                    print(error)
                case.success(let value):
                var json = JSON(value)
                    print(json)
                }
            }
        }
    }
}
