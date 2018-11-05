//
//  GetChats.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 24.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class GetChats {
    class func Get(type:Int,completion:@escaping(_ list:[RoadList])->())
    {
        let url = baseurl + "/get-specific-chats/"
        let params = ["token":APItoken.getToken()!,
                      "type":type] as [String : Any]
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if response.data != nil {
                switch response.result {
                case.failure(let error):
                    print(error)
                case.success(let val):
                    let json = JSON(val)
                    print(json)
                    guard let dataarr = json["chats"].array else {
                        return
                    }
                    var list = [RoadList]()
                    for cities in dataarr {
                        guard let city = cities.dictionary else {return}
                        let citizen = RoadList()
                        citizen.Start = city["start"]?.stringValue
                        citizen.StartId = city["start_id"]?.stringValue
                        citizen.end = city["end"]?.stringValue
                        citizen.endId = city["end_id"]?.stringValue
                        list.append(citizen)
                    }
                    completion(list)
                }
            }
        }
    }
}
