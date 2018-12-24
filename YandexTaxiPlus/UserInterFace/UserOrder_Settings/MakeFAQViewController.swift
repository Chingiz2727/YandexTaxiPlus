//
//  MakeFAQViewController.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 12/19/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit
import SwiftyStarRatingView
class MakeFAQViewController: UIViewController {
    var txtview = UITextView()
    var star = SwiftyStarRatingView()
    var label = UILabel()
    var send = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = false
        add()
        view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
    }
    
    @objc func makecomment() {
        addcoment.addcomnet(text: txtview.text, rating: Double(star.value)) { (success) in
            if success == true {
                self.navigationController?.popViewController(animated: true)
            }
            else {
                self.view.makeToast("Ошибка")
            }
        }
    }
    func add() {
        view.addSubview(txtview)
        view.addSubview(label)
        view.addSubview(star)
        view.addSubview(send)
        txtview.layer.cornerRadius = 1
        txtview.layer.borderWidth = 1
        txtview.layer.borderColor = UIColor.gray.cgColor
        txtview.setAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0,width: 0,height: 150)
        label.setAnchor(top: txtview.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 5, paddingLeft: 15, paddingBottom: 0, paddingRight: 0,width: 10,height: 20)
        label.text = "Оценить"
        star.setAnchor(top: label.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 5, paddingLeft: 70, paddingBottom: 0, paddingRight: 70)
        star.tintColor = maincolor
        send.backgroundColor = maincolor
        send.setAnchor(top: star.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 0, paddingRight: 5,width: 10,height: 40)
        send.layer.cornerRadius = 5
        send.setTitle("Отправить", for: .normal)
        send.setTitleColor(UIColor.white, for: .normal)
        send.addTarget(self, action: #selector(makecomment), for: .touchUpInside)
    }
    

}
