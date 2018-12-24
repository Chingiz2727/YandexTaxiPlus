//
//  getNews.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 12/7/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class GetNews {
    class func getnews(completion:@escaping(_ news:[NewsModule])->()) {
        let url = baseurl + "/get-news/"
        let post = ["token":APItoken.getToken()!]
        Alamofire.request(url, method: .post, parameters: post, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case.failure(let error):
                print(error)
            case.success(let val):
                let json = JSON(val)
                var price = [NewsModule]()
                guard let dataarr = json["messages"].array else {
                    return
                }
                for add in dataarr {
                    guard let add = add.dictionary else { return }
                    let pricing = NewsModule()
                    pricing.id = add["id"]?.string ?? ""
                    pricing.created = add["created"]?.string ?? ""
                    pricing.sender_id = add["sender_id"]?.string ?? ""
                    pricing.title = add["title"]?.string ?? ""
                    pricing.text = add["text"]?.string ?? ""
                    pricing.last_edit = add["last_edit"]?.string ?? ""
                    pricing.role_id = add["role_id"]?.string ?? ""
                    pricing.taxi_park_id = add["taxi_park_id"]?.string ?? ""
                    price.append(pricing)
                }
                completion(price)
            }
        }
    }
}
