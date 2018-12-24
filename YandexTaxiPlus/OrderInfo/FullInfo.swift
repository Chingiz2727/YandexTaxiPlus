// To parse the JSON, add this file to your project and do:
//
//   let orderInfo = try? newJSONDecoder().decode(OrderInfo.self, from: jsonData)

import Foundation

struct OrderInfo: Codable {
    let rating: Int?
    let state: String?
    let driver: Clientd?
    let car: [Car]?
    let stars: Int?
    let order: Orderd?
    let client: Clientd?
    let avatar: String?
}

struct Card: Codable {
    let id, submodel, type, seatsNumber: String?
    let number: String?
    let tonns, body: String?
    let model, year, carID: String?
    
    enum CodingKeys: String, CodingKey {
        case id, submodel, type
        case seatsNumber = "seats_number"
        case number, tonns, body, model, year
        case carID = "car_id"
    }
}

struct Clientd: Codable {
    let isActive, rating, taxiParkID, balance: Int?
    let name, pushID: String?
    let companyID: Int?
    let lastEdit: String?
    let yearOfBirth: Int?
    let phone: String?
    let parentID: JSONNull?
    let platform, roleID, id, cityID: Int?
    let genderID: Int?
    let token: String?
    let created: Int?
    
    enum CodingKeys: String, CodingKey {
        case isActive = "is_active"
        case rating
        case taxiParkID = "taxi_park_id"
        case balance, name
        case pushID = "push_id"
        case companyID = "company_id"
        case lastEdit = "last_edit"
        case yearOfBirth = "year_of_birth"
        case phone
        case parentID = "parent_id"
        case platform
        case roleID = "role_id"
        case id
        case cityID = "city_id"
        case genderID = "gender_id"
        case token, created
    }
}

struct Orderd: Codable {
    let deleted: Int?
    let date: String?
    let dispatcherID: Int?
    let toLongitude: String?
    let taxiParkID: Int?
    let toLatitude, created: String?
    let paymentType, price: Int?
    let companyID: Int?
    let isCommon, driverID: Int?
    let lastEdit, comment: String?
    let orderType: Int?
    let fromLongitude: String?
    let id, status, isRated: Int?
    let fromLatitude: String?
    let userID: Int?
    
    enum CodingKeys: String, CodingKey {
        case deleted, date
        case dispatcherID = "dispatcher_id"
        case toLongitude = "to_longitude"
        case taxiParkID = "taxi_park_id"
        case toLatitude = "to_latitude"
        case created
        case paymentType = "payment_type"
        case price
        case companyID = "company_id"
        case isCommon = "is_common"
        case driverID = "driver_id"
        case lastEdit = "last_edit"
        case comment
        case orderType = "order_type"
        case fromLongitude = "from_longitude"
        case id, status
        case isRated = "is_rated"
        case fromLatitude = "from_latitude"
        case userID = "user_id"
    }
}

// MARK: Encode/decode helpers

