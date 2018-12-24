//
//  SendChat.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 12/18/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
import Alamofire

class SendChat {
    class func send(token:String,message:String) {
        let params = ["to":token,"text":message]
        let url = baseurl + "/message/"
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case.failure(let error):
                print(error)
            case.success(let val):
                print(val)
            }
        }
    }
}
