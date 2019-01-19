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
class AccessShowFunc {
    
    class func Show(completion:@escaping(_ info:AccessShowTypes?)->()) {
        
        let url = baseurl + "/get-access-price/"
        Alamofire.request(url, method: .post, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case.failure(let err):
                print(err)
            case.success( _):
                guard response.data != nil else {return}
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .useDefaultKeys
                    let root = try decoder.decode(AccessShowTypes.self, from: response.data!)
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
