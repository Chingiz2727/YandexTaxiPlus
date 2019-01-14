struct OrderInfo: Codable {
    let car: [Card]?
    let order: Orderd?
    let dispatcher: Dispatcher?
    let rating, stars: Int?
    let state: String?
    let avatar: String?
    let client, driver: Clientd?
}

struct Card: Codable {
    let tonns: String?
    let carID, seatsNumber: String?
    let body: String?
    let number, year, type, model: String?
    let id, submodel: String?
    
    enum CodingKeys: String, CodingKey {
        case tonns
        case carID = "car_id"
        case seatsNumber = "seats_number"
        case body, number, year, type, model, id, submodel
    }
}
struct Dispatcher: Codable {
    let password: String?
    let companyID: Int?
    let firstName, lastName: String?
    let id: Int?
    let created, phone, token, lastEdit: String?
    let deleted, roleID, taxiParkID: Int?
    let email: String?
    
    enum CodingKeys: String, CodingKey {
        case password
        case companyID = "company_id"
        case firstName = "first_name"
        case lastName = "last_name"
        case id, created, phone, token
        case lastEdit = "last_edit"
        case deleted
        case roleID = "role_id"
        case taxiParkID = "taxi_park_id"
        case email
    }
}

struct Clientd: Codable {
    let roleID, isActive, balance: Int?
    let companyID: Int?
    let created: Int?
    let pushID, name: String?
    let yearOfBirth: Int?
    let rating, cityID, id: Int?
    let token, phone: String?
    let parentID, platform: Int?
    let lastEdit: String?
    let genderID, taxiParkID: Int?
    
    enum CodingKeys: String, CodingKey {
        case roleID = "role_id"
        case isActive = "is_active"
        case balance
        case companyID = "company_id"
        case created
        case pushID = "push_id"
        case name
        case yearOfBirth = "year_of_birth"
        case rating
        case cityID = "city_id"
        case id, token, phone
        case parentID = "parent_id"
        case platform
        case lastEdit = "last_edit"
        case genderID = "gender_id"
        case taxiParkID = "taxi_park_id"
    }
}

struct Orderd: Codable {
    let dispatcherID: Int?
    let userID, deleted, taxiParkID, paymentType: Int?
    let companyID: Int?
    let toLongitude: String?
    let status: Int?
    let created: String?
    let isCommon: Int?
    let orderType, isRated, price: Int?
    let fromLongitude, date: String?
    let driverID, id: Int?
    let comment, lastEdit, fromLatitude, toLatitude: String?
    
    enum CodingKeys: String, CodingKey {
        case dispatcherID = "dispatcher_id"
        case userID = "user_id"
        case deleted
        case taxiParkID = "taxi_park_id"
        case paymentType = "payment_type"
        case companyID = "company_id"
        case toLongitude = "to_longitude"
        case status, created
        case isCommon = "is_common"
        case orderType = "order_type"
        case isRated = "is_rated"
        case price
        case fromLongitude = "from_longitude"
        case date
        case driverID = "driver_id"
        case id, comment
        case lastEdit = "last_edit"
        case fromLatitude = "from_latitude"
        case toLatitude = "to_latitude"
    }
}
