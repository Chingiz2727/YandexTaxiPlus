//
//  GetSessionPrice.swift
//  newtaxi
//
//  Created by Чингиз on 21.09.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
class SessionPrice {
    class func GetPrice(completion:@escaping(_ six:Int?,_ tw:Int?)->()) {
        let url = baseurl + "/get-session-price/"
        let params = ["token":APItoken.getToken()!]
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if response.data != nil {
                switch response.result {
                case.failure(let error):
                    print(error)
                case.success(let val):
                    var json = JSON(val)
                    print(json)
                    let six = json["six_hours_price"].int
                    let unlim = json["unlim_price"].int
                    completion(six,unlim)
                    
                }
            }
        }
    }
    class func OpenSession(params:Dictionary<String,Any>,completion:@escaping(_ yes:Bool,_ no:Bool)->()) {
        let url = baseurl + "/start-session/"
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if response.data != nil {
                switch response.result {
                case.failure(let error):
                    print(error)
                case.success(let val):
                    let json = JSON(val)
                    print(json)
                    if json["message"].stringValue == "Сессия успешно открыта" {
                        completion(true,false)
                    }
                }
            }
        }
    }
    class func closeSession() {
        let url = baseurl + "/close-session/"
        let params = ["token":APItoken.getToken()!]
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if response.data != nil {
                switch response.result {
                case.failure(let err):
                    print(err)
                case.success(let val):
                    var json = JSON(val)
                    print(json)
                }
            }
        }
    }
}
