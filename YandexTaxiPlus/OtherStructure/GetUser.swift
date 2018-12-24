//
//  GetUser.swift
//  newtaxi
//
//  Created by Чингиз on 28.09.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import SideMenu
import Toast_Swift
import UIKit

class GetUser:UINavigationController
{
    let window = UIApplication.shared.keyWindow

    var fullview = UIView()
    var view0 = UIView()
    var view1 = UIView()
    var view2 = UIView()
    var view3 = UIView()
    var view4 = UIView()
    var view5 = UIView()
    var view6 = UIView()
    var label = UILabel()
    
    func addview() {
        self.view.addSubview(fullview)
        fullview.addSubview(label)
        fullview.addSubview(view0)
        fullview.addSubview(view1)
        fullview.addSubview(view2)
        fullview.addSubview(view3)
        fullview.addSubview(view4)
        fullview.addSubview(view5)
        fullview.addSubview(view6)
        
        label.text = "TAXI +"
        label.textColor = UIColor.yellow
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 60)
        fullview.setAnchor(top: label.topAnchor, left: view1.leftAnchor, bottom: view2.bottomAnchor, right: view0.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        label.setAnchor(top: fullview.topAnchor, left: fullview.leftAnchor, bottom: view1.topAnchor, right: fullview.rightAnchor, paddingTop: 0, paddingLeft: 30, paddingBottom: 10, paddingRight: 30, width: 0, height: 70)
        view1.setAnchor(top: label.bottomAnchor, left: fullview.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        view2.setAnchor(top: view1.bottomAnchor, left: view1.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        view3.setAnchor(top: view1.topAnchor, left: view2.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        view4.setAnchor(top: view1.bottomAnchor, left: view3.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
           view5.setAnchor(top: view1.topAnchor, left: view4.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
           view6.setAnchor(top: view1.bottomAnchor, left: view5.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        view0.setAnchor(top: view1.topAnchor, left: view6.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        view0.backgroundColor = UIColor.yellow
        view1.backgroundColor = UIColor.yellow
        view2.backgroundColor = UIColor.yellow
        view3.backgroundColor = UIColor.yellow
        view4.backgroundColor = UIColor.yellow
        view5.backgroundColor = UIColor.yellow
        view6.backgroundColor = UIColor.yellow
        let center = fullview.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        let center1 = fullview.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)

        NSLayoutConstraint.activate([center,center1])
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveLinear, animations: {
            self.fullview.frame.size.width += 10
            self.fullview.frame.size.height += 10        }) { (complet) in
            if complet == true {
                UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveLinear, animations: {
                    
                    self.view1.frame.size.width += 10
                    self.view1.frame.size.height += 10
                    
                }) { (complet) in
                    if complet == true {
                        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveLinear, animations: {
                            self.view1.frame.size.width -= 10
                            self.view1.frame.size.height -= 10
                            self.view2.frame.size.width += 10
                            self.view2.frame.size.height += 10
                        }) { (complet) in
                            if complet == true {
                                UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveLinear, animations: {
                                    self.view2.frame.size.width -= 10
                                    self.view2.frame.size.height -= 10
                                    self.view3.frame.size.width += 10
                                    self.view3.frame.size.height += 10
                                }) { (complet) in
                                    if complet == true {
                                        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveLinear, animations: {
                                            self.view3.frame.size.width -= 10
                                            self.view3.frame.size.height -= 10
                                            self.view4.frame.size.width += 10
                                            self.view4.frame.size.height += 10
                                        }) { (complet) in
                                            if complet == true {
                                                UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveLinear, animations: {
                                                    self.view4.frame.size.width -= 10
                                                    self.view4.frame.size.height -= 10
                                                    self.view5.frame.size.width += 10
                                                    self.view5.frame.size.height += 10
                                                }) { (complet) in
                                                    if complet == true {
                                                        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveLinear, animations: {
                                                            self.view5.frame.size.width -= 10
                                                            self.view5.frame.size.height -= 10
                                                            self.view6.frame.size.width += 10
                                                            self.view6.frame.size.height += 10
                                                        }) { (complet) in
                                                            if complet == true {
                                                                UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseIn, animations: {
                                                                    self.view6.frame.size.width -= 10
                                                                    self.view6.frame.size.height -= 10
                                                                    self.view0.frame.size.width += 10
                                                                    self.view0.frame.size.height += 10
                                                                }) { (complet) in
                                                                    if complet == true {
                                                                        self.view0.frame.size.width -= 10
                                                                        self.view0.frame.size.height -= 10
                                                                    }
                                                                }                                                    }
                                                        }                                            }
                                                }                                    }
                                        }                            }
                                }                    }
                        }            }
                }
                
            }
        }
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restartapp { (info) in

        }
        self.isNavigationBarHidden = true
        navigationController?.navigationBar.barTintColor = maincolor
        addview()
        view.backgroundColor = maincolor
       

     
        
        
    }
    
    
    
    
    
    

    
    func restartapp(comletion:@escaping(_ info:MainInfo)->()) {
        let url = baseurl + "/get-user/"
        
        let param = ["token":APItoken.getToken()!]
        window!.makeKeyAndVisible()
        Alamofire.request(url, method: .post, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case.failure(let err):
                print(err)
            case.success(let val):
                var json = JSON(val)
                DispatchQueue.main.async {
                    if json["user"]["role_id"].intValue == 2 {
                        self.fullview.removeFromSuperview()
                        self.label.removeFromSuperview()
                        self.isNavigationBarHidden = false

                        (self.window!.rootViewController as? UINavigationController)?.pushViewController(SessionOpenViewController(), animated: true)
                        let menuLeftNavigationController = UISideMenuNavigationController(rootViewController: DriverMenuTableViewController())
                        SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController
                        menuLeftNavigationController.sideMenuManager.menuWidth = self.window!.frame.width - self.window!.frame.width*0.2
                        SideMenuManager.default.menuFadeStatusBar = false
                        SideMenuManager.default.menuPushStyle = .replace
                        menuLeftNavigationController.sideMenuManager.menuPresentMode = .menuSlideIn
                    }
                    if json["user"]["role_id"].intValue == 1 {
                        self.fullview.removeFromSuperview()
                        self.label.removeFromSuperview()
                        self.isNavigationBarHidden = false

                        (self.window!.rootViewController as? UINavigationController)?.pushViewController(TestViewController(), animated: true)
                    }
                    if json["user"]["role_id"].intValue == 0 {
                        self.fullview.removeFromSuperview()
                        self.label.removeFromSuperview()
                        (self.window!.rootViewController as? UINavigationController)?.pushViewController(EnterPhone(), animated: true)
                        
                    }
                }
            
                guard let data = response.data else {return}
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .useDefaultKeys
                    let root = try decoder.decode(MainInfo.self, from: data)
                    comletion(root)
                }
                catch {
                    print("ErrorMan")
                    print(error)
                }
            }
        }
    }
    
    
    
    
    
}
