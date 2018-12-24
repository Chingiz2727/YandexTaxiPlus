//
//  SaveToken.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 12.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
//
//  APItoken.swift
//  University_app
//
//  Created by Чингиз on 21.05.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit

class APItoken: NSObject {
    
    class func saveapitoken(token:String)
    {
        let def = UserDefaults.standard
        def.set(token, forKey: "token")
        def.synchronize()
    }

    
    class func getToken() -> String?
    {
        let def = UserDefaults.standard
        return def.object(forKey: "token") as? String
    }
    
    class func savecolor(color:Int) {
        let def = UserDefaults.standard
        def.set(color, forKey: "color")
        def.synchronize()
    }

    
    class func getColorType() -> Int
    {
        let def = UserDefaults.standard
        return def.object(forKey: "color") as! Int
    }
   
    
}
