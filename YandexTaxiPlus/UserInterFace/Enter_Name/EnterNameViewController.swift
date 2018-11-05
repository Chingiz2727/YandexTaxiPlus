//
//  EnterNameViewController.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 12.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import Toast_Swift
class EnterNameViewController: UIViewController,FromCitiesTableViewControllerDelegate {
    var updateView : EnterNameView!

    var id_city : String?
    var region : String?
    var name : String?
    var cname : String? = "Выберите город" {
        didSet {
            updateView.City.setTitle(cname!, for: .normal)
        }
    }
    func CityFromData(id: String, region_id: String, name: String, cname: String) {
        self.id_city = id
        self.region = region_id
        self.name = name
        self.cname = cname
    }
    
    
    var phone:String!
    var window: UIWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupview()
        updateView.City.addTarget(self, action: #selector(gotoCity), for: .touchUpInside)
        updateView.loginAction = accessing
    }
    
    func setupview()
    {   let mainView = EnterNameView(frame: self.view.frame)
        self.updateView = mainView
        view.addSubview(mainView)
        view.backgroundColor = UIColor.white
    }
    func goToMain(){
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController.init(rootViewController: UserMainPageViewController())
    }
    
    @objc func  gotoCity() {
        print("lol")
        let city = CitiesTableViewController()
        city.tag = 0
        city.delegateFrom = self
        navigationController?.present(city, animated: true, completion: nil)
    }
    func accessing(){
        let name = updateView.PhoneField.text
        let url = baseurl + "/sign-up/"
        let url2 = baseurl + "/set-city/"
        let parametr = [
            "phone":phone!,
            "name":name!
        ]
        print(parametr)
        if id_city! == "" {
            view.makeToast("Выберите город")
        }
        else {
            Alamofire.request(url, method: .post, parameters: parametr, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                if response.data != nil {
                    switch response.result {
                    case.failure(let err):
                        print(err)
                    case.success(let val):
                        var json = JSON(val)
                        let token = json["token"].string
                        let param2 = ["token":token!,
                                      "city_id":self.id_city!]
                        Alamofire.request(url2, method: .post, parameters: param2, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (cresp) in
                            if cresp.data != nil {
                                switch cresp.result {
                                case.failure(let error):
                                    print(error)
                                case.success(let val2):
                                    let js = JSON(val2)
                                    print(js)
                                    APItoken.saveapitoken(token: token!)
                                    self.goToMain()
                                }
                            }
                        })
                        
                    }
                }
        }
       
        }
    }

}
