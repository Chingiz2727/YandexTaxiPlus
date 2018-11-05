//
//  AcceptTaxiModule.swift
//  newtaxi
//
//  Created by Чингиз on 10.09.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
class AccepTaxiModule {
    var img : String =  ""
    var menu : String =  ""
    var detail : String = ""
    init(detail:String,menu:String,img:String) {
        self.detail = detail
        self.menu = menu
        self.img = img
    }
}

