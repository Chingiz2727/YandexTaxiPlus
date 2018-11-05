//
//  Geocoding.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 01.11.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class Geocoding {
    class func LocationName(lat:String,long:String,completion:@escaping(_ location:String?)->()){
        let url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=\(lat),\(long)&location_type=ROOFTOP&result_type=street_address&key=AIzaSyAuSB9DXj45y7Ln8x45gTDOv-DhaFBm7Ys&language=ru"
        DispatchQueue.main.async {
            Alamofire.request(url).responseJSON { (response) in
                switch response.result {
                case.failure(let error):
                    print(error)
                case.success(let val):
                    let json = JSON(val)
                    guard let dataarr = json["results"].array else {
                        return
                    }
                    for cities in dataarr {
                        guard let city = cities.dictionary else {return}
                        let  location = city["formatted_address"]?.stringValue
                        completion(location)
                    }
                }
            }
        }
    }
}
