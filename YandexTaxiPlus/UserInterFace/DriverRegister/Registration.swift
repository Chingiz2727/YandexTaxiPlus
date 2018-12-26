//
//  Registration.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 26.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Register {
    class func register(gender:Int,car_number:String,car_model:String,year_of_birth:Int,car_year:String,seats_num:String,fac:Array<Any>,type:String,completion:@escaping(_ car:Bool)->()){
        let url = baseurl + "/driver-sign-up/"
        let params = [
            "token":APItoken.getToken()!,
            "gender_id":"\(gender)",
            "car_number":car_number,
            "car_model":car_model,
            "car_year":car_year,
            "seats_number":seats_num,
            "facilities":fac,
            "type":type
            ] as [String : Any]
     print(params)
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            if response.data != nil {
                switch response.result {
                case.failure(let error):
                    print(error)
                    completion(false)
                case.success(let value):
                    let json = JSON(value)
                    let state = json["state"].stringValue
                    if state == "success" {
                        completion(true)
                    }
                    else {
                        completion(false)
                    }
                    print(json.object)
                }
            }
        }
        
    }
}
