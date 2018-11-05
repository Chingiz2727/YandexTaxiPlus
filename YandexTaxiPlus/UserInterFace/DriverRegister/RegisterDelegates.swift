//
//  RegisterDelegates.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 26.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
protocol CarModelDelegate{
    func CarModel(Id:Int,Name:String)
}
protocol CarMarkDelegate{
    func CarMark(Id:Int,Name:String)
}
