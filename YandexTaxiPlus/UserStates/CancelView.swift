//
//  CancelView.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 11/20/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
import UIKit

class CancelView : NSObject {
    var window : UIView?
    var cancel : UIButton = UIButton()
    var can : orderCanceled?
    var label:MainLabel = MainLabel()
    func addcancel(view:UIView) {
        self.window = view
        view.addSubview(cancel)
        view.addSubview(label)
        label.initialize()
        cancel.setAnchor(top: view.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 40, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 180, height: 20)
        label.text = "Заявка принята ожидайте водителя"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 23)
        label.setAnchor(top: nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 20,width: 0,height: 100)
        let centerYlabel = label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        NSLayoutConstraint.activate([centerYlabel])
        cancel.setTitle("Отменить Заказ", for: .normal)
        cancel.setTitleColor(maincolor, for: .normal)
        cancel.addTarget(self, action: #selector(showCancel), for: .touchUpInside)
    }
    
    @objc func showCancel(){
        
        let alert = UIAlertController.init(title: "Отмена", message: "Вы хотите отменить заказ?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Да", style: .default, handler: { (action) in
            sendPushId.send { (info, order) in
                Cancel.Cancel(order_id:String(order!))
                self.can?.Canceled()
                self.cancel.removeFromSuperview()
                self.label.removeFromSuperview()
                
            }
        }))
        alert.addAction(UIAlertAction(title: "Нет", style: .cancel, handler: nil))
        alert.show()
    }
    
}
public extension UIAlertController {
    func show() {
        let win = UIWindow(frame: UIScreen.main.bounds)
        let vc = UIViewController()
        vc.view.backgroundColor = .clear
        win.rootViewController = vc
        win.windowLevel = UIWindow.Level.alert + 1
        win.makeKeyAndVisible()
        vc.present(self, animated: true, completion: nil)
    }
}
