//
//  GetDriverCoins.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 12/5/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct GetCoins: Codable {
    let monets,balance,orders_monets,added_monets: Int?
}


class GetCoinsDriver {
    class func get(completion:@escaping(GetCoins)->()) {
        let url = baseurl + "/get-my-balance/"
        let params = ["token":APItoken.getToken()!]
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case.failure(let err):
                print(err)
            case.success(let val):
                let json = JSON(val)
                guard let data = response.data else {return}
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .useDefaultKeys
                    let root = try decoder.decode(GetCoins.self, from: data)
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
