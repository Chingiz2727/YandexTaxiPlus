//
//  TaxiOrdersDetailOrderId.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 11/29/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
protocol TaxiOrdersDetailOrderId {
    var order_id : String {get}
}


class InfoTableViewModel : TaxiOrdersDetailOrderId {
    var order_id: String {
        return chats.id!
    }
    private var chats: ChatOrders
    
    init(chat:ChatOrders) {
        self.chats = chat
    }
    
}
