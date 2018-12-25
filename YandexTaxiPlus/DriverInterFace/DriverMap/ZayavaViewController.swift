//
//  ZayavaViewController.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 12/19/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit

class ZayavaViewController: UIViewController,UITextViewDelegate {
    let txtview = UITextView()
    let button = UIButton()
    var order_id : String!
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(txtview)
        view.addSubview(button)
        txtview.delegate = self
        txtview.text = "Причина жалобы"
        txtview.textColor = UIColor.lightGray
        txtview.setAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0,width: 10,height: 100)
        button.setAnchor(top: txtview.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0,width: 0,height: 40)
        button.backgroundColor = maincolor
        button.setTitle("Отправить", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(addzaya), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    @objc func addzaya() {
        AddZayava.add(text: txtview.text, order_id: order_id) { (succ) in
            if succ == true {
                self.dismiss(animated: true, completion: nil)
            }
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
