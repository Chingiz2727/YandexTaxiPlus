//
//  DistanceClass.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 11/21/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
struct Distance:Codable {
    var destination_addresses  : [String]?
    var origin_addresses : [String]?
    var rows : [Row]?
    var status : String?
    enum CodingKeys:String,CodingKey{
        case destination_addresses = "destination_addresses"
        case origin_addresses = "origin_addresses"
        case rows,status
    }
}

struct Row:Codable {
    var elements : [Elements]?
   
}
struct Elements:Codable {
    let distance,duration : Distan
    var status : String?
    
}
struct Distan:Codable {
    var text : String?
    var value : Int?
    enum CodingKeys:String,CodingKey {
        case text = "text"
        case value = "value"
    }
}

