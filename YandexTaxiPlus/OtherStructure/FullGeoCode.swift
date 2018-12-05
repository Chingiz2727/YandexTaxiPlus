//
//  FullGeoCode.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 12/2/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation


class FullGeo {
    class func get(lat:String,long:String) -> String? {
        var places : String?
        Geocoding.LocationName(lat: lat, long: long) { (geo) in
            
            if (geo?.results?.count)! > 0 {
//                places = "\(geo!.results?[1].addressComponents?[1].longName) \(geo!.results?[0].addressComponents?[0].longName)"
            }
            else {
                places = ""
            }
            print(places)
        }
        if places == "" {
            return ""
        }
        else {
            return places
        }
    }
}
