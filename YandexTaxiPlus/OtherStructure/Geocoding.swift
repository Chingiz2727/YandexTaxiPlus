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
    class func LocationName(lat:String,long:String,completion:@escaping(_ location:GeoCodable?)->()){
        let url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=\(lat),\(long)&result_type=street_address&key=AIzaSyAuSB9DXj45y7Ln8x45gTDOv-DhaFBm7Ys&language=ru"
        print(url)
        DispatchQueue.main.async {
            Alamofire.request(url).responseJSON { (response) in
                switch response.result {
                case.failure(let error):
                    print(error)
                case.success(let val):
                    guard let data = response.data else {return}
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .useDefaultKeys
                        let root = try decoder.decode(GeoCodable.self, from: data)
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
}
