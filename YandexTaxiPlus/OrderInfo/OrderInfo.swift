//
//  OrderInfo.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 29.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
struct order:Codable {
    var id : Int?
    var user_id : Int?
    var driver_id : Int?
    var taxi_park_id : String?
    var from_latitude : String?
    var from_longitude : String?
    var to_latitude : String?
    var to_longitude : String?
    var order_type : Int?
    var is_common : String?
    var comment : String?
    var status : Int?
    var price : Int?
    var  created : String?
    var last_edit : String?
    var date : String?
    var is_rated : Int?
    var company_id : Int?
    var deleted : Int?
    var payment_type : String?
    
    enum CodingKeys:String,CodingKey {
    case id = "id"
    case user_id = "user_id"
    case driver_id =   "driver_id"
    case taxi_park_id =  "taxi_park_id"
    case from_latitude = "from_latitude"
    case from_longitude = "from_longitude"
    case to_latitude = "to_latitude"
    case to_longitude = "to_longitude"
    case order_type = "order_type"
    case is_common =  "is_common"
    case comment =  "comment"
    case status = "status"
    case price = "price"
    case  created = "created"
    case last_edit = "last_edit"
    case date = "date"
    case is_rated = "is_rated"
    case company_id = "company_id"
    case deleted = "deleted"
    case payment_type = "payment_type"
    }
}
