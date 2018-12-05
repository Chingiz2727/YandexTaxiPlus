//
//  ChangeRole.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 11/28/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ChangeRole {
    class func Change(complition:@escaping(_ toUser:Bool,_ toDriver:Bool,_ toRegister:Bool)->()) {
        let url = baseurl + "/change-role/"
        UserInformation.shared.getinfo { (info) in
            var role : Int?
            switch info.user?.roleID! {
            case 2:
                role = 1
            case 1:
                role = 2
            default:
                break
            }
            
            let params = ["token":APItoken.getToken()!,
                          "role_id":role!] as [String : Any]
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                switch response.result {
                case.failure(let error):
                    print(error)
                case.success(let val):
                    var json = JSON(val)
                    print(json)
                    
                    if json["state"].stringValue == "fail" {
                        complition(false,false,true)
                    }
                    if  json["state"].stringValue == "success" {
                        if json["cars"].isEmpty {
                            complition(true,false,false)
                        }
                        else {
                            complition(false,true,false)
                            
                        }
                    }
                }
            })
        }
      
    }
}
