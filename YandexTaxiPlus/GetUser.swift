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
class GetUser:UINavigationController
{
    override func viewDidLoad() {
        super.viewDidLoad()
        restartapp { (info) in
            print(info.user.name!)
        }
    }
    
    func restartapp(comletion:@escaping(_ info:MainInfo)->()) {
        guard let window = UIApplication.shared.keyWindow else {return}
        let url = baseurl + "/get-user/"
        let param = ["token":APItoken.getToken()!]
        window.makeKeyAndVisible()
        Alamofire.request(url, method: .post, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case.failure(let err):
                print(err)
            case.success(let val):
                var json = JSON(val)
                print(json)
                DispatchQueue.main.async {
                    if json["user"]["role_id"].intValue == 2 {
                        (window.rootViewController as? UINavigationController)?.pushViewController(SessionOpenViewController(), animated: true)
                        let menuLeftNavigationController = UISideMenuNavigationController(rootViewController: DriverMenuTableViewController())
                        SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController
                        menuLeftNavigationController.sideMenuManager.menuWidth = window.frame.width - window.frame.width*0.2
                        SideMenuManager.default.menuFadeStatusBar = false
                        SideMenuManager.default.menuPushStyle = .replace
                        menuLeftNavigationController.sideMenuManager.menuPresentMode = .menuSlideIn
                    }
                    if json["user"]["role_id"].intValue == 1 {
                        (window.rootViewController as? UINavigationController)?.pushViewController(UserMainPageViewController(), animated: true)
                    }
                    if json["user"]["role_id"].intValue == 0 {
                        (window.rootViewController as? UINavigationController)?.pushViewController(EnterPhone(), animated: true)
                    }
                }
                guard let data = response.data else {return}
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let root = try decoder.decode(MainInfo.self, from: data)
                    comletion(root)
                }
                catch {
                    print("Bigerror")
                    print(error)
                }
            }
        }
    }
    
}
