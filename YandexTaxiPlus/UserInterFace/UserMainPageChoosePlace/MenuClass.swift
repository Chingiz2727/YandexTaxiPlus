//
//  MenuClass.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 16.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
class MenuPlace  {
    var name : String?
    var lat : Double?
    var long : Double?
    init(name:String,lat:Double,long:Double){
        self.name = name
        self.lat = lat
        self.long = long
    }
}
