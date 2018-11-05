//
//  AcceptDriverOrder.swift
//  newtaxi
//
//  Created by Чингиз on 01.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AcceptDriverOrder {
    class func accept(url:String,order_id:String,completion:@escaping(_ state:String)->()){
        let params = ["token":APItoken.getToken()!,
                      "order_id":order_id]
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if response.data != nil {
                switch response.result {
                case.failure(let err):
                    print(err)
                case.success(let val):
                    let json = JSON(val)
                    print(json)
                    var state = json["state"].stringValue
                    completion(state)
                }
            }
        }
    }
}
