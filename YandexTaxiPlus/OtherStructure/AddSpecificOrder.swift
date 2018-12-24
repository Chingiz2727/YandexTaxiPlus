//
//  AddSpecificOrder.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 24.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AddSpecificOrder {
    class func City(params:[String:Any],completion:@escaping(_ success:Bool,_ fail:Bool)->()) {
        let url = baseurl + "/add-specific-order/"
        
     
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if response.data != nil {
                
                switch response.result {
                case.failure(let error):
                    print(error)
//                    completion(false,true)
                case.success(let val):
                    let json = JSON(val)
                    if json["state"] == "success" {
                        completion(true,false)
                    }
                    if json["state"] == "do not have access" {
                        completion(false,true)
                    }
                    
                    
                }
            }
           
        }
    }
}
