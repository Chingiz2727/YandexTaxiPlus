//
//  CoinAlertViewController.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 12/7/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit
import SwiftPhoneNumberFormatter
import Toast_Swift
class CoinAlertViewController: UIViewController {
    var img : UIImageView = UIImageView()
    var coins : PhoneFormattedTextField = PhoneFormattedTextField()
    var card_num : PhoneFormattedTextField = PhoneFormattedTextField()
    var send : UIButton = UIButton()
    let window = UIApplication.shared.keyWindow
    override func viewDidLoad() {
        super.viewDidLoad()
        add()
        view.backgroundColor = UIColor.white
        send.addTarget(self, action: #selector(Request), for: .touchUpInside)
    }
    func add() {
        view.addSubview(img)
        view.addSubview(coins)
        view.addSubview(card_num)
        view.addSubview(send)
        let center_img = img.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        NSLayoutConstraint.activate([center_img])
        img.setAnchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 0,width: 50,height: 50)
        img.image = UIImage.init(named: "icon_by_card_p")
        img.contentMode = .scaleAspectFill
        coins.setAnchor(top: img.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 20,width: 0,height: 40)
        card_num.setAnchor(top: coins.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 20,width: 0,height: 40)
        send.setAnchor(top: card_num.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 10, paddingRight: 20,width: 0,height: 40)
        coins.layer.borderColor = maincolor.cgColor
        coins.layer.borderWidth = 1
        card_num.config.defaultConfiguration = PhoneFormat(defaultPhoneFormat: "####-####-####-####")
        card_num.layer.borderWidth = 1
        card_num.layer.borderColor = maincolor.cgColor
        card_num.textAlignment = .center
        
        coins.textAlignment = .center
        send.setTitleColor(maincolor, for: .normal)
        send.setTitle("Вывод средств", for: .normal)
        coins.placeholder = "Введите количество монет"
        card_num.placeholder = "Введите 16-значный номер карты"
    }
    
    
    @objc func Request() {
        let card = card_num.text!
        let phone = card.replacingOccurrences(of:" ", with: "").replacingOccurrences(of: "-", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "(", with: "").replacingOccurrences(of: "+", with: "")
        self.window?.makeToastActivity(.center)

        MoneyRequest.makerequest(card_num: phone, amount: coins.text!) { (success, nomoney) in
            self.window?.hideToastActivity()
            if success == true {
                self.window?.makeToast("Успешно")
            }
            
            if nomoney == true {
                self.window?.makeToast("Не достаточно момент")
            }
            
            self.dismiss(animated: true, completion: nil)

        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
