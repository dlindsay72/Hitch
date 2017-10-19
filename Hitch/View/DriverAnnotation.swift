//
//  DriverAnnotation.swift
//  Hitch
//
//  Created by Dan Lindsay on 2017-10-19.
//  Copyright © 2017 Dan Lindsay. All rights reserved.
//

import UIKit
import MapKit

class DriverAnnotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var key: String
    
    init(coordinate: CLLocationCoordinate2D, key: String) {
        self.coordinate = coordinate
        self.key = key
        
        super.init()
    }
    
    func update(annotationPosition annotation: DriverAnnotation, withCoordinate coordinate: CLLocationCoordinate2D) {
        var location = self.coordinate
        location.latitude = coordinate.latitude
        location.longitude = coordinate.longitude
        
        UIView.animate(withDuration: 0.2) {
            self.coordinate = location
        }
    }
    
}


