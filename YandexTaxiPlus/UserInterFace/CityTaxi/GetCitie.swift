//
//  GetCitie.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 23.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Citylist {
    class func List(completion:@escaping(_ List:[CitiesList])->()) {
        let url = baseurl + "/get-regions/"
        Alamofire.request(url).responseJSON { (response) in
            if response.data != nil {
                switch response.result {
                case.failure(let error):
                    print(error)
                case.success(let val):
                    let json = JSON(val)
                    guard let dataarr = json["cities"].array else {
                        return
                    }
                    var list = [CitiesList]()
                    for cities in dataarr {
                        guard let city = cities.dictionary else {return}
                        let citizen = CitiesList()
                        citizen.id = city["id"]?.stringValue
                        citizen.regionId = city["region_id"]?.stringValue
                        citizen.Name = city["cname"]?.stringValue
                        citizen.Region = city["name"]?.stringValue
                        list.append(citizen)
                    }
                    completion(list)
                }
            }
        }
    }
}
