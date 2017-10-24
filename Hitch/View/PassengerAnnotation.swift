//
//  PassengerAnnotation.swift
//  Hitch
//
//  Created by Dan Lindsay on 2017-10-23.
//  Copyright © 2017 Dan Lindsay. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class PassengerAnnotation: NSObject, MKAnnotation {
    
    dynamic var coordinate: CLLocationCoordinate2D
    var key: String
    
    init(coordinate: CLLocationCoordinate2D, key: String) {
        self.coordinate = coordinate
        self.key = key
        
        super.init()
    }
    
}
