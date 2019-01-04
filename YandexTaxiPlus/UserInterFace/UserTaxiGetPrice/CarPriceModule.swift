//
//  carPrice.swift
//  Taxi+
//
//  Created by Чингиз on 20.08.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
class carPrice {
    var type : String = ""
    var price : Int = 0
    var img : String = ""
    var img1 : String = ""
    var service_id : Int = 0
    var available : Bool?
    //    init(type:String , price:String , img:Staring,img1:String,service_id:String) {
    //        self.type = type
    //        self.price = price
    //        self.img = img
    //        self.img1 = img1
    //        self.service_id = service_id
    //    }
}
class Payment {
    var type : String = ""
    var icon : String = ""
    var sec_icon:String = ""
    var pay_type : String = ""
    init(type:String,icon:String,sec_icon:String,pay_type:String) {
        self.icon = icon
        self.type = type
        self.pay_type = pay_type
        self.sec_icon = sec_icon
    }
}
