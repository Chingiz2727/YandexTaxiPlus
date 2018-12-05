// To parse the JSON, add this file to your project and do:
//
//   let empty = try? newJSONDecoder().decode(Empty.self, from: jsonData)

import Foundation

struct MainInfo: Codable {
    let taxiPark: String?
    let user: User?
    let facilities: [Int]?
    let cars: [Car]?
    let city: City?
    
    enum CodingKeys: String, CodingKey {
        case taxiPark = "taxi_park"
        case user, facilities, cars, city
    }
}

struct Car: Codable {
    let id, carID, seatsNumber: String?
    let tonns, body: String?
    let number, year, type, model: String?
    let submodel: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case carID = "car_id"
        case seatsNumber = "seats_number"
        case tonns, body, number, year, type, model, submodel
    }
}

struct City: Codable {
    let id: Int?
    let cname: String?
    let regionID: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, cname
        case regionID = "region_id"
    }
}

struct User: Codable {
    let id: Int?
    let name, phone: String?
    let balance, roleID, isActive, taxiParkID: Int?
    let pushID: String?
    let created: Int?
    let lastEdit, token: String?
    let cityID: Int?
    let companyID, genderID: Int?
    let yearOfBirth: Int?
    let parentID: Int?
    let platform: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, name, phone, balance
        case roleID = "role_id"
        case isActive = "is_active"
        case taxiParkID = "taxi_park_id"
        case pushID = "push_id"
        case created
        case lastEdit = "last_edit"
        case token
        case cityID = "city_id"
        case companyID = "company_id"
        case genderID = "gender_id"
        case yearOfBirth = "year_of_birth"
        case parentID = "parent_id"
        case platform
    }
}

// MARK: Encode/decode helpers

class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
