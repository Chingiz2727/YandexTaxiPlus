//
//  GetMyPlace.swift
//  newtaxi
//
//  Created by Чингиз on 28.08.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import GoogleMaps
import GooglePlaces
import GooglePlacePicker

class GetMyPlace {
    class func get(completion:@escaping(_ place:[MyPlace])->Void) {
        let url = baseurl + "/get-addresses/"
        let params = ["token": APItoken.getToken()!]
        
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if response.data != nil {
                switch response.result {
                case.failure(let err):
                    print(err)
                case.success(let val):
                    let json = JSON(val)
                    
                    var myPlace = [MyPlace]()
                    guard let dataarr = json["addresses"].array else {
                        return
                    }
                    
                    for add in dataarr {
                        guard let add = add.dictionary else { return }
                        let address = MyPlace()
                        address.lat = add["latitude"]?.string ?? ""
                        address.lang = add["longitude"]?.string ?? ""
                        address.place = add["address"]?.string ?? ""
                        myPlace.append(address)
                    }
                    completion(myPlace)
                }
            }
        }
        
    }
}
