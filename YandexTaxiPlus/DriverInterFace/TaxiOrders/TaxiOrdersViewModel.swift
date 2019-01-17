//
//  TaxiOrdersViewModel.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 11/17/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
class TaxiOrdersViewModel:TableViewTaxiOrdersModelType {
    
    private var selectedIndexPath : IndexPath?
    func viewmodelforselectodRow() -> InfoTableViewModel? {
        guard let selectedIndexPath = selectedIndexPath else {return nil}
        return InfoTableViewModel(chat: chats[selectedIndexPath.row])
    }
    
    func selecRow(atIndexPath indexpath: IndexPath) {
        self.selectedIndexPath = indexpath
    }
    
    var numofrows: Int  {
        return chats.count
    }
    
    var chats = [ChatOrders]()
    
    func cellViewModile(forIndexPath indexPath: IndexPath) -> TableViewCellTaxiOrdersModelType? {
        let  chat = chats[indexPath.row]
        return TableViewCellViewModel(orders: chat)
    }

    }

protocol TableViewTaxiOrdersModelType {
    var numofrows : Int {get}
    func cellViewModile(forIndexPath indexPath:IndexPath) -> TableViewCellTaxiOrdersModelType?
    func viewmodelforselectodRow() -> InfoTableViewModel?
    func selecRow(atIndexPath indexpath:IndexPath)
}


protocol TableViewCellTaxiOrdersModelType: class {
    var price : String? {get}
    var phone : String? {get}
    var name : String? {get}
    var from_lat : String? {get}
    var from_long : String? {get}
    var to_lat : String? {get}
    var to_long : String? {get}
    var from : String? {get}
    var to : String? {get}
    var order_type : String? {get}
}

