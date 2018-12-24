//
//  TestViewExtension.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 12/17/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
import GoogleMaps
extension TestViewController {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 13)
        self.mapview?.map.animate(to: camera)
        let coord = location?.coordinate
        let lat = coord?.latitude
        let long = coord?.longitude
        self.from_long = long
        self.from_lat = lat
        getfromgeo.get(lat: String(lat!), long: String(long!)) { (place) in
            self.first_name = place
        }

        self.manager.stopUpdatingLocation()
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D){
        if first_clicked == true {
           
                marker1.icon = self.imageWithImage(image: UIImage(named: "icon_point_a")!, scaledToSize: CGSize(width: 30, height: 30))
                from_lat = coordinate.latitude
                from_long = coordinate.longitude
                getfromgeo.get(lat: String(from_lat!), long: String(from_long!)) { (from_place) in
                    self.first_name = from_place
                }
                marker1.position = CLLocationCoordinate2D(latitude: from_lat!, longitude: from_long!)
                marker1.map = mapview?.map
            
        }
        
        if second_clicked == true {
                marker2.icon = self.imageWithImage(image: UIImage(named: "icon_point_b")!, scaledToSize: CGSize(width: 30, height: 30))
                to_lat = coordinate.latitude
                to_long = coordinate.longitude
                getfromgeo.get(lat: String(to_lat!), long: String(to_long!)) { (to_place) in
                    self.second_name = to_place
                }
                marker2.position = coordinate
                marker2.map = mapview?.map
            
        }
    }
   
    
    
    
    
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
}
