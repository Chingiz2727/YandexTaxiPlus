//
//  PayByCardViewController.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 11/30/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit

class PayByCardViewController: UIViewController {
    var url : String = ""

    let WebView : UIWebView = UIWebView()
    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.isTranslucent = true
        super.viewDidLoad()
        view.addSubview(WebView)
        WebView.setAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        let myurl = URL(string: url)
        WebView.loadRequest(URLRequest(url: myurl!))
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
