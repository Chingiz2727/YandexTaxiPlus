//
//  DriverProtocol.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 12/14/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
protocol DriverProtocol {
    var from_long : String? {get set}
    var to_long : String? {get set}
    var from_lat : String? {get set}
    var to_lat : String? {get set}
    var status : Int? {get set}
    var order_id : Int? {get set}
    
    func DrawMap()
    
    func showButton()
    
}
