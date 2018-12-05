//
//  Quit.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 11/28/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class Quit {
    class func quit(complition:@escaping(_ success:Bool)->()) {
        let url = baseurl + "/logout/"
        let params = ["token":APItoken.getToken()!]
        
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if response.data != nil {
                switch response.result {
                case.failure(let error):
                    print(error)
                case.success(let val):
                    let json = JSON(val)
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
}
