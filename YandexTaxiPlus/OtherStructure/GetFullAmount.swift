//
//  GetFullAmount.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 12/10/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct Amount: Codable {
    let state, taxi, inva, gruzotaxi: String?
    let ekavuator, mejgorod: String?
}

class GetAmount {
    class func get(completion:@escaping(_ amount:Amount)->()) {
        let url = baseurl + "/get-amount/"
        let params = ["token":APItoken.getToken()!]
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if response.data != nil {
                switch response.result {
                case.failure(let error):
                    print(error)
                case.success(let val):
                    guard let data = response.data else {return}
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .useDefaultKeys
                        let root = try decoder.decode(Amount.self, from: data)
                        completion(root)
                    }
                    catch {
                        print(error)
                    }
                }
            }
        }
    }
}
