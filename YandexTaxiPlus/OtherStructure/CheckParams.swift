//
//  CheckParams.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 11/27/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
class CheckParams {
    class func check(params:[String:Any],complition:@escaping(_ Yes:Bool,_ No:Bool)->()) {
        if params.values.filter({ $0 == nil }).isEmpty
        {
           complition(true,false)
        }
        else
        {
            complition(false,true)
        }
    }
}
