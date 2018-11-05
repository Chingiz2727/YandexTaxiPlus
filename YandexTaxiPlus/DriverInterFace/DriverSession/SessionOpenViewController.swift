//
//  SessionOpenViewController.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 26.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit
import Toast_Swift
import SideMenu
class SessionOpenViewController: UIViewController,CLLocationManagerDelegate {
    var MainView : SessionOpenView!
    var locationManager:CLLocationManager!
    private var currentCoordinate: CLLocationCoordinate2D?
    var currentLocation:CLLocation?
    
    
    var six : Int? = 0 {
    didSet {
        MainView.six_price.text = "\(six!) тг"
    }
    }
    var tw : Int? = 0 {
        didSet
        {
            MainView.tw_price.text = "\(tw!) тг"

        }
    }
    var ostatok : Int? = 0 {
        didSet {
            MainView.ostatok_m.text = "\(ostatok!) тг"
        }
    }
    
    var balance : Int? = 0 {
        didSet {
            MainView.Coins_count.text = "\(balance!)"
        }
    }
    var tag : Int? = 0 {
        didSet {
            MainView.OpenButton.tag = tag!
        }
    }
    var session : String? = ""
    {
        didSet {
            MainView.OpenButton.setTitle(session, for: .normal)

        }
    }
    let customSideMenuManager = SideMenuManager()
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let sideMenuNavigationController = segue.destination as? UISideMenuNavigationController {
            sideMenuNavigationController.sideMenuManager = customSideMenuManager
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        let menubutton = UIBarButtonItem.init(image: UIImage(named: "hamburger-menu-icon"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(OpenMenu))
        self.navigationItem.leftBarButtonItem = menubutton
        
        navigationController?.navigationBar.barTintColor = maincolor
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.isHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupMainView()
        SessionPrice.GetPrice { (six, tw) in
            self.six = six
            self.tw = tw
        }
        
        
        
       
        
        MainView.six_check.addTarget(self, action: #selector(check(check:)), for: .touchUpInside)
        MainView.tw_check.addTarget(self, action: #selector(check1(check:)), for: .touchUpInside)
        view.backgroundColor = UIColor.white
        setupLocationManager()
        // Do any additional setup after loading the view.
        MainView.OpenButton.addTarget(self, action: #selector(SetSession(button:)), for: .touchUpInside)
    }
    
    func SetupMainView() {
        let mainView = SessionOpenView(frame: self.view.frame)
        self.MainView = mainView
        self.view.addSubview(mainView)
        
    }
    
    
    @objc func check(check:CheckboxButton) {
        if  MainView.six_check.on {
            MainView.tw_check.on = false
            ostatok = balance! - six!

        }
      
    }
    
    @objc func check1(check:CheckboxButton) {
        
        if MainView.tw_check.on {
            MainView.six_check.on = false
            ostatok = balance! - tw!
        }
    }

    
    
    func setupLocationManager(){
        self.locationManager?.requestAlwaysAuthorization()
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        self.locationManager?.requestAlwaysAuthorization()
        locationManager?.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager?.startUpdatingLocation()
    }
   @objc func OpenMenu() {
        
        present(SideMenuManager.defaultManager.menuLeftNavigationController!,animated: true,completion: nil)
    }
    
    // Below method will provide you current location.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let defaults = UserDefaults.standard
        if currentLocation == nil {
            currentLocation = locations.last
            locationManager?.stopMonitoringSignificantLocationChanges()
            let locationValue:CLLocationCoordinate2D = manager.location!.coordinate
            
            if APItoken.getToken() != nil {
                let token = defaults.string(forKey: "pushId")
                if token != nil {
                    sendPushId.send(token: token!, long_a: locationValue.longitude, lat_a: locationValue.latitude) { (session, balance, status,order_status,order_id) in
                        self.balance = balance
                        self.ostatok = balance
                        self.tag = session
                        if session == 0 {
                            self.session = "Открыть смену"
                        }
                        if session == 1 {
                            self.session = "Закрыть смену"
                        }
                    }
                }
                
            }
            print("locations = \(locationValue)")
            
            locationManager?.stopUpdatingLocation()
        }
    }
     @objc func SetSession(button:UIButton) {
        switch button.tag {
        case 0:
            if MainView.six_check.on {
                SessionPrice.OpenSession(params: ["token":APItoken.getToken()!]) { (success, error) in
                    if success {
                        print(123)
                    }
                    if error {
                        print(321)
                    }
                }
            }
            if MainView.tw_check.on {
                SessionPrice.OpenSession(params: ["token":APItoken.getToken()!,"duration":"akbdciamidoandnasu27ˆ81n"]) { (success, error) in
                    if success {
                    
                    }
                    if error {
                        print(456)
                    }
                }
            }
            view.makeToast("Сессия успешна открыта")
            self.session = "Закрыть смену"
            self.tag = 1
        case 1 :
            SessionPrice.closeSession()
            setupLocationManager()
            self.session = "Открыть смену"
            self.tag = 0
            view.makeToast("Сессия успешна закрыта")

        default:
            break
        }

    }
    // Below Mehtod will print error if not able to update location.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error")
    }

}
