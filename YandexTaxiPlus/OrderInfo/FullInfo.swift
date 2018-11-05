//
//  FullInfo.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 29.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
struct OrderInfo:Codable {
    var client : client?
    var driver : driver?
    var order : order?
    var state : String?
    var car : [car]?
    enum CodingKeys:String,CodingKey{
        case client = "client"
        case driver = "driver"
        case order = "order"
        case state = "state"
        case car = "car"
    }
}
struct car:Codable {
    var id : String?
    var car_id : String?
    var seats_number : String?
    var tonns : String?
    var body : String?
    var number : String?
    var year : String?
    var type : String?
    var model : String?
    var submodel : String?
    enum CodingKeys:String,CodingKey{
        case id = "id"
        case car_id = "car_id"
        case seats_number = "seats_number"
        case tonns = "tonns"
        case body = "body"
        case number = "number"
        case year = "year"
        case type = "type"
        case model = "model"
        case submodel = "submodel"

    }
}
