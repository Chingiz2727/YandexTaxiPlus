//
//  UserStruct.swift
//  newtaxi
//
//  Created by Чингиз on 10.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
struct User:Codable {
    var balance:Int?
    var company_id:String?
    var platform : Int?
    var created : Int?
    var last_visit : Int?
    var service_id : String?
    var car:String?
    var token:String?
    var email:String?
    var year_of_birth:Int?
    var city_id : Int?
    var car_year:Int?
    var name:String?
    var car_number:String?
    var session_type : Int?
    var phone : String?
    var gender_id : String?
    var push_id:String?
    var taxi_park_id:Int?
    var id:Int?
    var last_edit : String?
    var role_id:String?
    var rating : Double?
    var password : String?
    var is_active : Int?
    var parent_id : String?
    enum CodingKeys:String,CodingKey {
        case balance = "balance"
        case company_id = "company_id"
        case platform = "platform"
        case created = "created"
        case last_visit = "last_visit"
        case service_id = "service_id"
        case car = "car"
        case token = "token"
        case email = "email"
        case year_of_birth = "year_of_birth"
        case city_id = "city_id"
        case car_year = "car_year"
        case name = "name"
        case car_number = "car_number"
        case parent_id = "parent_id"
        case session_type = "session_type"
        case phone = "phone"
        case gender_id = "gender_id"
        case push_id = "push_id"
        case taxi_park_id = "taxi_park_id"
        case id = "id"
        case last_edit = "last_edit"
        case role_id = "role_id"
        case rating = "rating"
        case password = "password"
        case is_active = "is_active"
    }
}
struct MainInfo : Codable {
    var model : String?
    var submodel:String?
    var user:User
    var taxi_park : String?
    var facilities : [Int?]?
    var city : city?
    var cars : [car]?
    enum CodingKeys:String,CodingKey{
        case model = "model"
        case submodel = "submodel"
        case user = "user"
        case taxi_park = "taxi_park"
        case facilities = "facilities"
        case city = "city"
        case cars = "cars"
    }
}
struct city : Codable {
    var cname : String?
    var region_id : Int?
    var id : Int?
    enum CodingKeys:String,CodingKey{
        case cname = "cname"
        case region_id = "region_id"
        case id = "user"
        
    }
}
