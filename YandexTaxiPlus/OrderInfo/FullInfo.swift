
struct OrderInfo: Codable {
    let state: String?
    let order: Orderd?
    let car: [Card]?
    let driver, client: Clientd?
}

struct Card: Codable {
    let tonns: String?
    let seatsNumber, model, number, id: String?
    let type: String?
    let body: String?
    let carID, year, submodel: String?
    
    enum CodingKeys: String, CodingKey {
        case tonns
        case seatsNumber = "seats_number"
        case model, number, id, type, body
        case carID = "car_id"
        case year, submodel
    }
}

struct Clientd: Codable {
    let platform, taxiParkID: Int?
    let pushID: String?
    let parentID: Int?
    let created: Int?
    let phone, token: String?
    let genderID: Int?
    let id, cityID, isActive: Int?
    let name, lastEdit: String?
    let companyID: Int?
    let rating, roleID, balance: Double?
    let yearOfBirth: Int?
    
    enum CodingKeys: String, CodingKey {
        case platform
        case taxiParkID = "taxi_park_id"
        case pushID = "push_id"
        case parentID = "parent_id"
        case created, phone, token
        case genderID = "gender_id"
        case id
        case cityID = "city_id"
        case isActive = "is_active"
        case name
        case lastEdit = "last_edit"
        case companyID = "company_id"
        case rating
        case roleID = "role_id"
        case balance
        case yearOfBirth = "year_of_birth"
    }
}

struct Orderd: Codable {
    let comment: String?
    let taxiParkID: Int?
    let dispatcherID: Int?
    let isCommon, isRated, price: Int?
    let created: String?
    let userID: Int?
    let toLongitude, fromLatitude: String?
    let driverID: Int?
    let toLatitude: String?
    let id, paymentType: Int?
    let fromLongitude, lastEdit: String?
    let companyID: Int?
    let status, deleted, orderType: Int?
    let date: String?
    
    enum CodingKeys: String, CodingKey {
        case comment
        case taxiParkID = "taxi_park_id"
        case dispatcherID = "dispatcher_id"
        case isCommon = "is_common"
        case isRated = "is_rated"
        case price, created
        case userID = "user_id"
        case toLongitude = "to_longitude"
        case fromLatitude = "from_latitude"
        case driverID = "driver_id"
        case toLatitude = "to_latitude"
        case id
        case paymentType = "payment_type"
        case fromLongitude = "from_longitude"
        case lastEdit = "last_edit"
        case companyID = "company_id"
        case status, deleted
        case orderType = "order_type"
        case date
    }
}
