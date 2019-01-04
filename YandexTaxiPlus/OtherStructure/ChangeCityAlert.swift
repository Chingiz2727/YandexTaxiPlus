//
//  ChangeCityAlert.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 1/4/19.
//  Copyright © 2019 Чингиз. All rights reserved.
//

import UIKit

class ChangeCityAlert: UIAlertController,JKDropDownDelegate,CLLocationManagerDelegate {
    var latitude : Double?
    var longitude : Double?
    var citie = [CitiesList]()
    var items = [String]()
    var ids = [String]()
    var id : String?
    var buttonFrame : CGRect?
    let window = UIApplication.shared.keyWindow!
    var dropDownObject:JKDropDown!
    var locationManager = CLLocationManager()
    var button : UIButton = UIButton()
    var sendbutton : UIButton = UIButton()
    var img : UIImageView = UIImageView()
    var label : UILabel = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        data()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        // Do any additional setup after loading the view.
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        self.latitude = locValue.latitude
        self.longitude = locValue.longitude
        manager.stopUpdatingLocation()
    }

    func data() {
        Citylist.List { (list:[CitiesList]) in
            self.citie = list
            print(self.citie)
            for i in list {
                self.items.append(i.Region!)
                self.ids.append(i.regionId!)
                print(i.regionId!)
                print(i.Region!)
            }
            self.addview()
        }
    }
    func addview () {
        view.backgroundColor = UIColor.white
        button.setTitle("Выберите город", for: .normal)
        sendbutton.setTitle("Выбрать", for: .normal)
        view.addSubview(label)
        label.textColor = maincolor
        label.text = "Кажется вы в другом городе , смените область"
        label.textAlignment = .center
        label.font = UIFont(name: "Arial", size: 13)
        label.setAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 2, paddingLeft: 5, paddingBottom: 0, paddingRight: 5, width: 0, height: 40)
        label.numberOfLines = 0
        view.addSubview(button)
        view.addSubview(img)
        view.addSubview(sendbutton)
        img.sizeToFit()
        let centerImg = img.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        NSLayoutConstraint.activate([centerImg])
        img.setAnchor(top: label.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 50, height: 30)
        button.setAnchor(top: img.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 5, paddingBottom: 0, paddingRight: 5, width: 240, height: 40)
        button.titleLabel?.textColor = maincolor
        sendbutton.titleLabel?.textColor = maincolor
        button.backgroundColor = maincolor
        sendbutton.backgroundColor = maincolor
        button.addTarget(self, action: #selector(tapsOnButton), for: .touchUpInside)
        sendbutton.addTarget(self, action: #selector(sendcity), for: .touchUpInside)
        sendbutton.setAnchor(top: button.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 5, paddingBottom: 10, paddingRight: 5, width: 0, height: 40)
        img.image = #imageLiteral(resourceName: "icon_city")
        
    }
    
    
    
    @objc func tapsOnButton() {
        if dropDownObject == nil {
            dropDownObject = JKDropDown()
            dropDownObject.dropDelegate = self
            let frame = view.convert(button.frame, to: view)
            self.buttonFrame = frame
           dropDownObject.showJKDropDown(senderObject: button, height: CGFloat(citie.count*10), arrayList: items , arrayImages: [""],buttonFrame:frame,direction : "down")
            view.addSubview(dropDownObject)
        }
            
        else {
            dropDownObject.hideDropDown(senderObject: button,buttonFrame:buttonFrame!)
            dropDownObject = nil
        }
    }
    func recievedSelectedValue(name: String, imageName: String) {
        let index = items.firstIndex(of: name)
        self.id = ids[index!]
        dropDownObject.hideDropDown(senderObject: button, buttonFrame: buttonFrame!)
        dropDownObject = nil
        button.setTitle(name, for: .normal)
        print(name)
    }
    @objc func sendcity() {
        view.makeToastActivity(.center)
        if id == nil {
            self.view.makeToast("Выберите город")
            view.hideToastActivity()
        }
        else {
            ChangeCity.ChangeCity(city_id: id!, latitude: latitude!, longitude: longitude!) { (success) in
                if success == "success" {
                    self.view.hideToastActivity()
                    self.dismiss(animated: true, completion: nil)
                }
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
