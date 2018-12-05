//
//  FullChatsStruct.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 11/27/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
class FullChatList {
    var id : String?
    var from_string : String?
    var to_string : String?
    var date : String?
    var price : String?
    var comment : String?
    var name : String?
    var phone : String?
}
class TableViewFullChatCellViewModel : TableViewCellFullChatsModelType {
    var id: String? {
        return orders.id!
    }
    
    var from: String? {
        return orders.from_string!
    }
    
    var to: String? {
        return  orders.to_string!
    }
    
    var date: String? {
        return orders.date!
    }
    
    var price: String? {
        return orders.price! + " тг"
    }
    
    var comment: String? {
        return orders.comment!
    }
    
    var name: String? {
        return orders.name!
    }
    
    var phone: String? {
        return "\( (orders.phone!))"
    }
    
    private var orders:FullChatList
    
    init(orders:FullChatList) {
        self.orders = orders
    }
}
