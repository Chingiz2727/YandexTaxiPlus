//
//  UserTypeInfo.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 11/14/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
struct UserTypeInfo:Codable {
    var state : String?
    var balance : Int?
    var is_active : Int?
    var status : Int?
    var order_id : Int?
    var is_session_opened : Int?

    enum CodingKeys:String,CodingKey {
        case state = "state"
        case balance = "balance"
        case is_active = "is_active"
        case status = "status"
        case order_id = "order_id"
        case is_session_opened = "is_session_opened"

    }
}
