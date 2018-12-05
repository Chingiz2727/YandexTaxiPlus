//
//  RoadedTaxi.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 24.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class RoadedTaxi {
    class func get(start_id:String,end_id:String,completion:@escaping(_ list:[RoadedList],_ success:Bool,_ pay:Bool)->()) {
        let url = baseurl + "/get-mejdugorodniy-chat/"
        let params = ["token": APItoken.getToken()!,
                      "start_id":start_id,
                      "end_id":end_id]
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if response.data != nil {
                switch response.result {
                case.failure( let error):
                    print(error)
                case.success(let value):
                    let json = JSON(value)
                    print(json)
                    var list = [RoadedList]()
                    print(json["state"].stringValue)
                    if json["state"].stringValue == "success" {
                        guard let dataarr = json["orders"].array else {
                            return
                        }
                        for cities in dataarr {
                            guard let city = cities.dictionary else {return}
                            let citizen = RoadedList()
                            citizen.name = city["name"]?.stringValue
                            citizen.start = city["start"]?.stringValue
                            citizen.end = city["end"]?.stringValue
                            citizen.price = city["price"]?.stringValue
                            citizen.phone = city["phone"]?.stringValue
                            citizen.date = city["date"]?.stringValue
                            citizen.submodel = city["submodel"]?.stringValue
                            citizen.model = city["model"]?.stringValue
                            citizen.seatsnum = city["seats_number"]?.stringValue
                            citizen.comment = city["comment"]?.stringValue
                            list.append(citizen)
                        }
                         completion(list,true,false)
                    }
                    if  json["state"].stringValue == "do not have access"  {
                        completion(list,false,true)

                    }
                }
            }
        }
    }
}
class RoadedList {
    var end:String?
    var start:String?
    var phone:String?
    var price : String?
    var submodel : String?
    var model : String?
    var name : String?
    var date : String?
    var comment : String?
    var seatsnum : String?
}
