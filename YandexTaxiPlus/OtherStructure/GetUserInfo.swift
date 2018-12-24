//
//  GetUserInfo.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 17.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class UserInformation {
    static let shared = UserInformation()
    
        func getinfo(completion:@escaping(_ info:MainInfo)->()) {
        let url = baseurl + "/get-user/"
            let param = ["token":APItoken.getToken()!]
        Alamofire.request(url, method: .post, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case.failure(let err):
                print(err)
            case.success(let val):
             let json = JSON(val)
             print(json)
                guard let data = response.data else {return}
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .useDefaultKeys
                    
                    let root = try decoder.decode(MainInfo.self, from: data)
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
