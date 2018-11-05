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
    class  func getinfo(completion:@escaping(_ info:MainInfo)->()) {
        var url = baseurl + "/get-user/"
        var param = ["token":APItoken.getToken()!]
        Alamofire.request(url, method: .post, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case.failure(let err):
                print(err)
            case.success(let val):
                var json = JSON(val)
                print(json)
                guard let data = response.data else {return}
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
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
