//
//  Constants.swift
//  newtaxi
//
//  Created by Чингиз on 29.09.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

struct Constants
{
    struct refs {
        static let databaseRoot = Database.database().reference()
        static let databaseChats = databaseRoot.child("Message")
        
    }
}
