// To parse the JSON, add this file to your project and do:
//
//   let orderInfo = try? newJSONDecoder().decode(OrderInfo.self, from: jsonData)

import Foundation

struct MyChats: Codable {
    let showChat: Bool?
    let state: String?
    let amountShared, amountOwn: Int?
    
    enum CodingKeys: String, CodingKey {
        case showChat = "show_chat"
        case state
        case amountShared = "amount_shared"
        case amountOwn = "amount_own"
    }
}
