//
//  SessionStruct.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 26.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
struct SessionStruct:Codable {
    var six_hours_price : Int?
    var unlim_price : Int?
    enum CodingKeys:String,CodingKey{
        case six_hours_price = "six_hours_price"
        case unlim_price = "unlim_price"
    }
}
