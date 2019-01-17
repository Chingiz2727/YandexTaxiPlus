//
//  ChatOrderStructure.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 11/5/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation


class ChatOrders {
    var price : String?
    var from_latitude : String?
    var to_latitude : String?
    var from_longitude : String?
    var phone : String?
    var id : String?
    var name : String?
    var created : String?
    var to_longitude : String?
    var from : String?
    var to : String?
    var order_type : String?
}

class TableViewCellViewModel:TableViewCellTaxiOrdersModelType {
    var from_lat: String? {
        return orders.from_latitude!
    }
    
    var from_long: String? {
        return orders.from_longitude!
    }
    
    var to_lat: String? {
        return orders.to_latitude!
    }
    
    var to_long: String? {
        return orders.to_longitude!
    }
    var order_type : String? {
        return orders.order_type!
    }
    
    private var orders:ChatOrders
    
    var price: String? {
        return orders.price! + "Тг"
    }
    
    var phone: String? {
        return orders.phone!
    }
    
    var name: String? {
        return orders.name!
    }
    
    var from: String? {
     
        return orders.from ?? ""
    }
    
    var to: String? {
        return orders.to ?? ""
    }
    
    init(orders:ChatOrders) {
      self.orders = orders
    }
    
}
