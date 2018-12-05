struct InfoForDriver: Codable {
    let state: String?
    let order: Orders?
    let client: Clients?
    let driver: JSONNull?
}

struct Clients: Codable {
    let id: Int?
    let name, phone: String?
    let balance, roleID, isActive, taxiParkID: Int?
    let pushID: String?
    let created: Int?
    let lastEdit, token: String?
    let cityID: Int?
    let companyID: Int?
    let genderID, yearOfBirth: Int?
    let rating: Double?
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
        case rating
        case parentID = "parent_id"
        case platform
    }
}

struct Orders: Codable {
    let id, userID: Int?
    let driverID: Int?
    let taxiParkID: Int?
    let fromLatitude, fromLongitude, toLatitude, toLongitude: String?
    let orderType, isCommon: Int?
    let comment: String?
    let status, price: Int?
    let created: String?
    let lastEdit: String?
    let date: String?
    let isRated: Int?
    let companyID: Int?
    let deleted, paymentType: Int?
    let dispatcherID: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case driverID = "driver_id"
        case taxiParkID = "taxi_park_id"
        case fromLatitude = "from_latitude"
        case fromLongitude = "from_longitude"
        case toLatitude = "to_latitude"
        case toLongitude = "to_longitude"
        case orderType = "order_type"
        case isCommon = "is_common"
        case comment, status, price, created
        case lastEdit = "last_edit"
        case date
        case isRated = "is_rated"
        case companyID = "company_id"
        case deleted
        case paymentType = "payment_type"
        case dispatcherID = "dispatcher_id"
    }
}

// MARK: Encode/decode helper
