//
//  NewsDetailViewController.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 12/7/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit

class NewsDetailViewController: UIViewController {
    var detail: String?
    var text : UITextView = UITextView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(text)
        text.setAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10)
        text.text = detail ?? ""
        text.textAlignment = .left
        // Do any additional setup after loading the view.
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
