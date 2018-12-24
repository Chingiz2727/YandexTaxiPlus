//
//  AddZayava.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 12/19/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
import Alamofire
class AddZayava {
    class func add(text:String,order_id:String,completion:@escaping(_ success:Bool)->()) {
        let url = baseurl + "/add-complaint/"
        let params = ["token":APItoken.getToken()!,"text":text,"order_id":order_id]
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case.failure(let error):
                print(error)
                completion(false)
            case.success(let val):
                completion(true)
            }
        }
    }
}
