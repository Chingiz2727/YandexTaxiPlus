//
//  AddRecomend.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 29.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AddRecomend {
    class func recomendation(text:String,rating:Double,completion:@escaping(_ Yes:Bool, _ No:Bool)->()) {
        let url =  baseurl + "/add-recomendation/"
        let params = [
            "token": APItoken.getToken()!,
            "text": text,
            "rating":rating
            ] as [String : Any]
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
