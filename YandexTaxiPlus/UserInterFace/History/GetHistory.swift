//
//  GetHistory.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 11/30/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class getHistory {
    class func get(date:Double,completion:@escaping(_ history:[History])->()){
        let url = baseurl + "/get-all-orders/"
        let params = [
            "token":APItoken.getToken()!,
            "date":date ] as [String : Any]
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case.failure(let err):
                print(err)
            case.success(let val):
                var json = JSON(val)
                print(json)
                guard let dataarr = json["orders"].array else {return}
                var history = [History]()
                for h in dataarr {
                    guard let istorya = h.dictionary else {return}
                    var hist = History()
                    hist.from_lat = istorya["from_latitude"]?.stringValue
                    hist.to_lat = istorya["to_latitude"]?.stringValue
                    hist.from_long = istorya["from_longitude"]?.stringValue
                    hist.to_long = istorya["to_longitude"]?.stringValue
                    hist.price = istorya["price"]?.intValue
                    hist.last_edit = istorya["last_edit"]?.stringValue
                    history.append(hist)
                }
                completion(history)
            }
        }
            
        
        
    }
}
