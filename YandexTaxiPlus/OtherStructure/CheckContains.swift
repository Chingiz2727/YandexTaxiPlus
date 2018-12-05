//
//  CheckContains.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 11/22/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation


class CheckCarContains {
    class func check(type:String,completion:@escaping(_ contains:Bool,_ not:Bool)->()) {
        var yes = false
        UserInformation.shared.getinfo { (info) in
            for i in info.cars! {
                if (i.type?.contains(type))! {
                    yes = true
                }
            }
            if yes == true {
                completion(true,false)
            }
            else {
                completion(false,true)
            }
        }
    }
}
