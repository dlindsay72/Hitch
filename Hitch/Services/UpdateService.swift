//
//  UpdateService.swift
//  Hitch
//
//  Created by Dan Lindsay on 2017-10-19.
//  Copyright © 2017 Dan Lindsay. All rights reserved.
//

import UIKit
import MapKit
import Firebase

class UpdateService {
    static var instance = UpdateService()
    
    func updateUserLocation(withCoordinate coordinate: CLLocationCoordinate2D) {
        DataService.instance.REF_USERS.observeSingleEvent(of: .value) { (snapshot) in
            if let userSnapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for user in userSnapshot {
                    if user.key == Auth.auth().currentUser?.uid {
                        DataService.instance.REF_USERS.child(user.key).updateChildValues([DatabaseKeys.coordinate.rawValue: [coordinate.latitude, coordinate.longitude]])
                    }
                }
            }
        }
    }
    
    func updateDriverLocation(withCoordinate coordinate: CLLocationCoordinate2D) {
        DataService.instance.REF_DRIVERS.observeSingleEvent(of: .value) { (snapshot) in
            if let driverSnapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for driver in driverSnapshot {
                    if driver.key == Auth.auth().currentUser?.uid {
                        if driver.childSnapshot(forPath: DatabaseKeys.isPickupModeEnabled.rawValue).value as? Bool == true {
                            DataService.instance.REF_DRIVERS.child(driver.key).updateChildValues([DatabaseKeys.coordinate.rawValue: [coordinate.latitude, coordinate.longitude]])
                        }
                    }
                }
            }
        }
    }
}






