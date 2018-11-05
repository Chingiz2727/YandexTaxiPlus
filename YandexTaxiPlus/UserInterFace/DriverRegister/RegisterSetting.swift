//
//  RegisterSettingApi.swift
//  newtaxi
//
//  Created by Чингиз on 04.09.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class SetModel {
    var model : String = ""
    var id : Int = 0
    
}

class RegiterSettingApi {
    class func setting(completion:@escaping([SetModel])->Void) {
        let url = baseurl + "/get-car-models/"
        Alamofire.request(url).responseJSON {  (response) in
            if response.data != nil {
                switch response.result {
                case.failure(let error):
                    print(error)
                case.success(let val):
                    var json = JSON(val)
                    print(json)
                    var model = [SetModel]()
                
                        guard let dataar = json["models"].array else{return}
                        for data in dataar {
                            guard let add = data.dictionary else { return }
                            let models = SetModel()
                            
                            models.model = add["model"]?.string ?? ""
                            models.id = add["id"]?.int ?? 0
                            model.append(models)
                        }
                    completion(model)
                }
            }
        }
    }
    
    class func Mark(id:Int,completion:@escaping([SetModel])->()) {
        let params = ["id":id]
        print(params)
        let url  = baseurl + "/get-car-submodels/"
        Alamofire.request(url, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if response.data != nil {
                switch response.result {
                case.failure(let error):
                    print(error)
                case.success(let val):
                    let json = JSON(val)
                    var model = [SetModel]()
                    print(json)
                    guard let dataar = json["models"].array else{return}
                    for data in dataar {
                        guard let add = data.dictionary else { return }
                        let models = SetModel()
                        models.model = add["model"]?.string ?? ""
                        models.id = add["id"]?.int ?? 0
                        model.append(models)
                    }
                    completion(model)
                }
            }
        }
    }
}
