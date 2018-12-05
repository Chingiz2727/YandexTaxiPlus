//
//  AccessShowTypes.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 11/26/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)


struct AccessShowTypes: Codable {
    let state: String?
    let types: [TypeElement]
}

struct TypeElement: Codable {
    let id: Int?
    let type: String?
    let hourPrice, publishPrice: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, type
        case hourPrice = "hour_price"
        case publishPrice = "publish_price"
    }
}
