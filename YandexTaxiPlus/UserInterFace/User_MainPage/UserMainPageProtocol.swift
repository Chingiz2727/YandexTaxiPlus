//
//  UserMainPageProtocol.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 12/15/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
protocol UserMainPageProtocol {
    func addbuttons()
    func newOrders()
    func first_added()
    func second_added()
    var first_clicked:Bool? {get set}
    var second_clicked:Bool? {get set}
    var first_name : String? {get set}
    var second_name : String {get set}
    var from_lat : Double? {get set}
    var from_long : Double?  {get set}
    var to_lat : Double? {get set}
    var to_long : Double? {get set}
    var state_type : Int? {get set}
    var order_id : Int? {get set}
}
