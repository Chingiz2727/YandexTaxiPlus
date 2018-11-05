//
//  HistoryRoute.swift
//  newtaxi
//
//  Created by Чингиз on 25.08.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
class HistoryModule {
    var img : String = ""
    var date : String = ""
    var price : String = ""
    var place : String = ""
    init(img:String,price:String,date:String,place:String) {
        self.img = img
        self.date = date
        self.price = price
        self.place = place
    }
    
}
