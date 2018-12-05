////
////  MakeAlert.swift
////  YandexTaxiPlus
////
////  Created by Чингиз on 11/26/18.
////  Copyright © 2018 Чингиз. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//
//class MakeAlert:NSObject {
//    
//    class func MakeAlert(publish:Int,type:Int,navigation:UINavigationController) {
//        AccessShowFunc.Show { (info) in
//            let alert = UIAlertController.init(title: "Покупка", message: "Для публикации необходимо оплатить \(info.types[type].publishPrice!) тг", preferredStyle: .alert)
//            let image = UIImage.init(named: "icon_error")
//            alert.addimage(image: image!)
//            alert.addAction(UIAlertAction(title: "Оплатить", style: .default, handler: { (action) in
//                sendPushId.send { (info, order) in
//                    BuyAcessFunc.Buy(publish: "\(publish)", type: "\(type)", completion: { (yes, no) in
//                        if yes {
//                            alert.dismiss(animated: true, completion: nil)
//                        }
//                        if no {
//                            let NoMonet = UIAlertController.init(title: "Нет Денег", message: "У вас не хватает денег для просмотра публикации", preferredStyle: .alert)
//                            NoMonet.addAction(UIAlertAction.init(title: "Закрыть", style: .cancel, handler: { (action) in
//                                navigation.popViewController(animated: true)
//                            }))
//                            NoMonet.show()
//                        }
//                    })
//                    
//                    
//                }
//            }))
//            alert.addAction(UIAlertAction(title: "Нет", style: .cancel, handler: { (action) in
//                navigation.popViewController(animated: true)
//            }))
//            alert.show()
//        }
//      
//    }
//}
//
