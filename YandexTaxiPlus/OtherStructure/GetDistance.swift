//
//  GetUserInfo.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 17.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class GetDistance {
    
  class func getinfo(from_lat:String,from_long:String,to_lat:String,to_long:String,completion:@escaping(_ info:Distance)->()) {
    let orig = "origins=\(from_lat),\(from_long)"
    let des = "&destinations=\(to_lat),\(to_long)"
    let all = "&mode=car&language=ru-RU&key=AIzaSyAuSB9DXj45y7Ln8x45gTDOv-DhaFBm7Ys"
    let url = "https://maps.googleapis.com/maps/api/distancematrix/json?" + orig + des + all

    
    Alamofire.request(url).responseJSON { (response) in
        switch response.result {
        case.failure(let err):
            print(err)
        case.success( _):
            guard let data = response.data else {return}
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .useDefaultKeys
                let root = try decoder.decode(Distance.self, from: data)
                completion(root)
            }
            catch {
                print("Bigerrorbek")
                print(error)
            }
        }
    }
    }
}
