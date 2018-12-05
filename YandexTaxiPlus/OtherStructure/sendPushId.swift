//
//  SendPushId.swift
//  newtaxi
//
//  Created by Чингиз on 10.09.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
import GoogleMaps
import GooglePlaces
class sendPushId {
    class func send(completion:@escaping(_ info:UserTypeInfo,_ order_id:Int?)->()) {
        let url = baseurl + "/set-push-id/"
        let defaults = UserDefaults.standard
        let token = defaults.string(forKey: "pushId")
        let params = [
            "token":APItoken.getToken()!,
            "push_id":token!,
            "platform": "1"
            ] as [String : Any]
        print(params)
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if response.data != nil {
                switch response.result {
                case.failure( let error):
                    print(error)
                case.success(let val):
                    let json = JSON(val)
                    print(json)
                    let order = json["order_id"].intValue
                    guard let data = response.data else {return}
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .useDefaultKeys
                        let root = try decoder.decode(UserTypeInfo.self, from: data)
                        completion(root,order)
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
