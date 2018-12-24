//
//  GetReferal.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 12/12/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
import Alamofire
struct Referal: Codable {
    let state: String?
    let link: String?
}


class GetReferal {
    class func get(completion:@escaping(_ referal:Referal?)->()) {
        let url = baseurl + "/get-referal-link/"
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
                        let root = try decoder.decode(Referal.self, from: data)
                        completion(root)
                    }
                    catch {
                        print("Bigerror")
                        print(error)
                    }
                    
                }
        }
    }
    }
    
}
