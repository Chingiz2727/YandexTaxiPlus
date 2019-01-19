//
//  TaxiOrdersViewModel.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 11/17/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
class FullChatsViewModel:TableViewFullChatsModelType {
    var numofrows : Int  {
        return chats.count
    }
    
    var chats = [FullChatList]()
    func cellViewModile(forIndexPath indexPath: IndexPath) -> TableViewCellFullChatsModelType? {
        let chat = chats[indexPath.row]
        return TableViewFullChatCellViewModel(orders: chat)
    }
    
}

protocol TableViewFullChatsModelType {
    var numofrows : Int {get}
    func cellViewModile(forIndexPath indexPath:IndexPath) -> TableViewCellFullChatsModelType?
}


protocol TableViewCellFullChatsModelType: class {
    var id : String? {get}
    var from : String? {get}
    var to : String? {get}
    var date : String? {get}
    var price : String? {get}
    var comment : String? {get}
    var name : String? {get}
    var phone : String? {get}

}

