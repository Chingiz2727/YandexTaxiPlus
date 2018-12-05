//
//  BuyAccessStruct.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 11/26/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
import Foundation

struct BuyAccessStruct: Codable {
    let state: String
    let price: Price
}

struct Price: Codable {
    let id: Int?
    let type: String?
    let hourPrice, publishPrice: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, type
        case hourPrice = "hour_price"
        case publishPrice = "publish_price"
    }
}
