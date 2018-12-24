//
//  GeoPlace.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 12/14/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
class getfromgeo {
    class func get(lat:String,long:String,completion:@escaping(_ location:String)->()) {
        DispatchQueue.main.async {
            Geocoding.LocationName(lat: lat, long: long) { (first_loc) in
                if first_loc?.status! != "ZERO_RESULTS" {
                    let  place = "\(first_loc?.results![0].addressComponents![1].shortName ?? "") \(first_loc!.results![0].addressComponents![0].shortName ?? "")"
                    completion(place)
                }
                else {
                    completion("")
                }
               
                
            }
        }
       
    }
}
