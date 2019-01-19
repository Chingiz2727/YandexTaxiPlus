//
//  AddComent.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 12/19/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
import Alamofire

class  addcoment {
    class func addcomnet(text:String,rating:Double,completion:@escaping(_ success:Bool)->()) {
        let url = baseurl + "/add-recomendation/"
        let params = ["token":APItoken.getToken()!,
                      "text":text,
                      "rating":rating] as [String : Any]
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if response.data != nil {
                switch response.result {
                case.failure(let _):
                    completion(false)
                case.success(let val):
                    print(val)
                    completion(true)
                }
            }
        }
        
    }
}
