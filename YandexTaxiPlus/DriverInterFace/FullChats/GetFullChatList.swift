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

class GetFullChats {
    class func Get(type:Int,completion:@escaping(_ list:[FullChatList],_ yes:Bool,_ no:Bool)->())
    {
        let url = baseurl + "/get-specific-chats/"
        let params = ["token":APItoken.getToken()!,
                      "type":type] as [String : Any]
        print("getchat")
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if response.data != nil {
                switch response.result {
                case.failure(let error):
                    print(error)
                case.success(let val):
                    let json = JSON(val)
                    print(json)
                    var list = [FullChatList]()

                    if json["state"].stringValue == "success" {
                        guard let dataarr = json["chats"].array else {
                            return
                        }
                        for cities in dataarr {
                            guard let city = cities.dictionary else {return}
                            let citizen = FullChatList()
                            citizen.id = city["id"]?.stringValue
                            citizen.date = city["date"]?.stringValue
                            citizen.from_string = city["from_string"]?.stringValue
                            citizen.to_string = city["to_string"]?.stringValue
                            citizen.name = city["name"]?.stringValue
                            citizen.price = city["price"]?.stringValue
                            citizen.phone = city["phone"]?.stringValue
                            citizen.comment = city["comment"]?.stringValue
                            list.append(citizen)
                        }
                        completion(list,true,false)
                    }
                    
                    if json["state"].stringValue == "do not have access" {
                        completion(list,false,true)
                    }
                }
            }
        }
    }
}
