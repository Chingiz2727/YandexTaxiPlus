//
//  GetPrice.swift
//  newtaxi
//
//  Created by Чингиз on 12.09.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import GoogleMaps
import GooglePlaces
import Alamofire
import SwiftyJSON

class getPrice {
    class func getprice(first_long:String,first_lat:String,second_lat:String,second_long:String,type:String,completion:@escaping(_ price:[carPrice])->Void){
        let params = [
            "token":APItoken.getToken()!,
            "longitude_a":first_long,
            "latitude_a":first_lat,
            "latitude_b":second_lat,
            "longitude_b":second_long,
            "type":type
            ] as [String : Any]
        let url = baseurl + "/get-price/"
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if response.data != nil {
                switch response.result {
                case.failure(let error):
                    print(error)
                case.success(let value):
                    var json = JSON(value)
                    var price = [carPrice]()
                    guard let dataarr = json["price_list"].array else {
                        return
                    }
                    print(json)
                    
                    for add in dataarr {
                        guard let add = add.dictionary else { return }
                        let pricing = carPrice()
                        pricing.img = add["img"]?.string ?? ""
                        pricing.img1 = add["img1"]?.string ?? ""
                        pricing.price = add["price"]?.int ?? 0
                        pricing.type = add["service_name"]?.string ?? ""
                        pricing.service_id = add["service_id"]?.int ?? 0
                        price.append(pricing)
                    }
                    completion(price)
                }
            }
        }
    }
}
