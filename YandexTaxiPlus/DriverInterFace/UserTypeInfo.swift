import Foundation

struct UserTypeInfo: Codable {
    let isActive: Int?
    let state: String?
    let stars: Int?
    let avatar: String?
    let rating, balance, isSessionOpened, status: Int?
    let activeOrders: [ActiveOrder]?
    
    enum CodingKeys: String, CodingKey {
        case isActive = "is_active"
        case state, stars, avatar, rating, balance
        case isSessionOpened = "is_session_opened"
        case status
        case activeOrders = "active_orders"
    }
}

struct ActiveOrder: Codable {
    let status: Int?
    let driverID: Int?
    let paymentType, id, isRated, userID: Int?
    let companyID: Int?
    let taxiParkID: Int?
    let fromLongitude, lastEdit, date, toLongitude: String?
    let price: Int?
    let toLatitude, created, comment: String?
    let dispatcherID: Int?
    let orderType: Int?
    let fromLatitude: String?
    let isCommon, deleted: Int?
    
    enum CodingKeys: String, CodingKey {
        case status
        case driverID = "driver_id"
        case paymentType = "payment_type"
        case id
        case isRated = "is_rated"
        case userID = "user_id"
        case companyID = "company_id"
        case taxiParkID = "taxi_park_id"
        case fromLongitude = "from_longitude"
        case lastEdit = "last_edit"
        case date
        case toLongitude = "to_longitude"
        case price
        case toLatitude = "to_latitude"
        case created, comment
        case dispatcherID = "dispatcher_id"
        case orderType = "order_type"
        case fromLatitude = "from_latitude"
        case isCommon = "is_common"
        case deleted
    }
}
