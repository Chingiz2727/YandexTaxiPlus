//
//  DriverRegisterApi.swift
//  newtaxi
//
//  Created by Чингиз on 03.09.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class DriverRegisterApi {
    class func DriverRegisterApi(name:String,phone:String,gender:Int,car_number:String,car_model:Int,taxi_park_id:Int,year_of_birth:Int,car_year:Int,facilities:Array<Any>,completion:@escaping(_ error:Bool,_ success:Bool)->Void) {
        let url = baseurl + "/driver-sign-up/"
        let params = [
            "name" : name,
            "phone" : phone,
            "gender" : gender,
            "car_number":car_number,
            "car_model":car_model,
            "year_of_birth":year_of_birth,
            "car_year":car_year,
            "taxi_park_id":taxi_park_id,
            "facilities":facilities,
            "token":APItoken.getToken()!
            ] as [String : Any]
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if response.data != nil {
                switch response.result {
                case.failure(let error):
                    print(error)
                case.success(let val):
                    print(val)
                    let json = JSON(val)
                    if json["state"] == "success" {
                        completion(false,true)
                    }
                    else {
                        completion(true,false)
                    }
                    print(json)
                    
                }
            }
        }
    }
    class func getOption(completion:@escaping(_ facilities:[Facilities])->Void){
        let url = baseurl + "/get-facilities/"
        Alamofire.request(url).responseJSON { (response) in
            if response.data != nil {
                switch response.result {
                case.failure(let err):
                    print(err)
                case.success(let val):
                    var json = JSON(val)
                    print(json)
                    var facilities = [Facilities]()
                    guard let dataarr = json["Facilities"].array else {
                        return
                    }
                    
                    for add in dataarr {
                        guard let add = add.dictionary else { return }
                        let address = Facilities()
                        address.id = add["id"]?.int ?? 0
                        address.name = add["name"]?.string ?? ""
                        facilities.append(address)
                    }
                    completion(facilities)
                    
                }
            }
        }
    
    }
}
