//
//  CheckForChats.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 11/29/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class CheckForChats {
    class func check(complition:@escaping(_ contain:MyChats?)->()) {
        let url = baseurl + "/how-many-chats/"
        let params = ["token":APItoken.getToken()!]
        
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if response.data != nil {
                switch response.result {
                case.failure(let error):
                    print(error)
                case.success(let _):
                    guard response.data != nil else {return}
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .useDefaultKeys
                        let root = try decoder.decode(MyChats.self, from: response.data!)
                        complition(root)
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
