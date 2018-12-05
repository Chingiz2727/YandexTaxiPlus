//
//  protocols.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 11/8/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation

protocol firstplacedelegate:Any {
    func firstadded()
    var first_lat : Double {get set}
    var first_long : Double {get set}
    var first_name : String {get set }
}
protocol Rated : Any {
    func rated()
}


protocol secondplacedelegate:Any {
    
    func secondadded()
    var second_lat :Double {get set}
    var second_long : Double {get set}
    var second_name : String {
        get set
    }
}
protocol payByCard {
    func PayingByCard(url:String)
}

protocol firstplacebuttonclicked:Any {
    var first_clicked : Bool {get set}
}

protocol commentAndDate: Any {
    func getdata(coment:String,data:String)
}

protocol secondplaceclicked:Any {
    var second_clicked : Bool {get set}
}

protocol CarModelDelegate{
    var car_model_id : Int {get set}
    var car_model_name : String {get set}
    func remove()

}
protocol CarMarkDelegate{
    var car_mark_name : String {get set}
}

protocol FromCitiesTableViewControllerDelegate {
    func CityFromData(id:String,region_id:String,name:String,cname:String)
}
protocol  ToCitiesTableViewControllerDelegate{
    func CityToData(id:String,region_id:String,name:String,cname:String)
}
protocol orderCanceled {
    func Canceled()
}
protocol ordermaked {
    func OrderMaked()
}
protocol GetDate {
    var date : Int? {get set}
    func reload()
}
