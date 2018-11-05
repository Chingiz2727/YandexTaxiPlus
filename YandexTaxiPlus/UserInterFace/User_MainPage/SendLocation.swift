//
//  SendLocation.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 29.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import GoogleMaps
import GooglePlaces
import IQKeyboardManagerSwift
import Firebase
import FirebaseMessaging
import UserNotifications
import CoreLocation
import MapKit
import FirebaseInstanceID
import FirebaseMessaging

extension UserMainPageViewController {
    
    func setupLocationManager(){
        self.locationManager?.requestAlwaysAuthorization()
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        self.locationManager?.requestAlwaysAuthorization()
        locationManager?.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager?.startUpdatingLocation()
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
                        self.order_id = String(order_id)
                        self.ShowInfo()

                    }
                }
                
            }
            print("locations = \(locationValue)")
            
            locationManager?.stopUpdatingLocation()
        }
    }
    
    // Below Mehtod will print error if not able to update location.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error")
    }
}
