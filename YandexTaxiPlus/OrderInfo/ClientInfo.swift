//
//  UserInfo.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 29.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
struct client:Codable {
    var id : Int?
    var name : String?
    var phone : String?
    var balance : Int?
    var role_id : Int?
    var is_active : Int?
    var car : String?
    var taxi_park_id : Int?
    var car_number : String?
    var push_id : String?
    var service_id : String?
    var password : String?
    var created : Int?
    var last_edit : String?
    var last_visit : String?
    var email : String?
    var token : String?
    var city_id : String?
    var company_id : String?
    var gender_id : String?
    var year_of_birth : String?
    var car_year : String?
    var session_type  : Int?
    var rating : Int?
    var parent_id : String?
    var platform : Int?
    
    enum CodingKeys:String,CodingKey {
    case id = "id"
    case name =  "name"
    case phone =  "phone"
    case balance =   "balance"
    case role_id =  "role_id"
    case is_active = "is_active"
    case car = "car"
    case taxi_park_id = "taxi_park_id"
    case car_number = "car_number"
    case push_id =  "push_id"
    case service_id =  "service_id"
    case password = "password"
    case created = "created"
    case last_edit =  "last_edit"
    case last_visit = "last_visit"
    case email = "email"
    case token =  "token"
    case city_id = "city_id"
    case company_id = "company_id"
    case gender_id = "gender_id"
    case year_of_birth = "year_of_birth"
    case car_year = "car_year"
    case session_type =   "session_type"
    case rating = "rating"
    case parent_id = "parent_id"
    case platform = "platform"
    }
}
struct driver:Codable {
    var id : Int?
    var name : String?
    var phone : String?
    var balance : Int?
    var role_id : Int?
    var is_active : Int?
    var car : String?
    var taxi_park_id : Int?
    var car_number : String?
    var push_id : String?
    var service_id : String?
    var password : String?
    var created : Int?
    var last_edit : String?
    var last_visit : Int?
    var email : String?
    var token : String?
    var city_id : Int?
    var company_id : String?
    var gender_id : Int?
    var year_of_birth : Int?
    var car_year : Int?
    var session_type : Int?
    var rating : Double?
    var parent_id : Int?
    var platform : Int?
    enum CodingKeys:String,CodingKey {
    case id =  "id"
    case name =  "name"
    case phone = "phone"
    case balance = "balance"
    case role_id =  "role_id"
    case is_active = "is_active"
    case car = "car"
    case taxi_park_id = "taxi_park_id"
    case car_number = "car_number"
    case push_id = "push_id"
    case service_id = "service_id"
    case password = "password"
    case created = "created"
    case last_edit =  "last_edit"
    case last_visit =  "last_visit"
    case email = "email"
    case token = "token"
    case city_id = "city_id"
    case company_id = "company_id"
    case gender_id =  "gender_id"
    case year_of_birth = "year_of_birth"
    case car_year = "car_year"
    case session_type = "session_type"
    case rating = "rating"
    case parent_id = "parent_id"
    case platform = "platform"
    }
}
