//
//  UserSetting.swift
//  newtaxi
//
//  Created by Чингиз on 25.08.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
class UserSetting {
    var placeholder:String = ""
    var name:String = ""
    init(name:String,placeholder:String) {
        self.name = name
        self.placeholder = placeholder
    }
}
