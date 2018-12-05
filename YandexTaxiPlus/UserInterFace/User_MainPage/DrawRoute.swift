//
//  DrawRoute.swift
//  newtaxi
//
//  Created by Чингиз on 11.09.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit
import MapKit
import NotificationCenter
import GoogleMaps
import GooglePlaces
import Alamofire
import SwiftyJSON

class Route {
    class func Draw(startlat:Double,startlong:Double,endlat:Double,englong:Double,map:GMSMapView) {
        let origin = "\(startlat),\(startlong)"
        let destionation = "\(endlat),\(englong)"
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destionation)&key=AIzaSyAuSB9DXj45y7Ln8x45gTDOv-DhaFBm7Ys"
        Alamofire.request(url).responseJSON { (response) in
            let datar = response.data
            let json = JSON(datar!)
            let routes = json["routes"].arrayValue
            
            for route in routes
            {
                let routepolyline = route["overview_polyline"].dictionary
                let points = routepolyline?["points"]?.stringValue
                let path = GMSPath.init(fromEncodedPath: points!)
                let polyline = GMSPolyline.init(path: path)
                polyline.strokeWidth = 4
                polyline.strokeColor = maincolor
                
                polyline.map = map
            }
        }
    }
}
