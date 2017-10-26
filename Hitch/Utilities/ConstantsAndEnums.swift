//
//  Constants.swift
//  Hitch
//
//  Created by Dan Lindsay on 2017-10-16.
//  Copyright © 2017 Dan Lindsay. All rights reserved.
//

import UIKit

enum StoryBoardIdentifiers: String {
    case leftSidePanelVC = "LeftSidePanelVC"
    case homeVC = "HomeVC"
    case loginVC = "LoginVC"
    case signUpVC = "SignUpVC"
}

enum DatabaseKeys: String {
    case isPickupModeEnabled = "isPickupModeEnabled"
    case driverIsOnTrip = "driverIsOnTrip"
    case provider = "provider"
    case userIsDriver = "userIsDriver"
    case coordinate = "coordinate"
    case tripCoordinate = "tripCoordinate"
}

enum CellIdentifiers: String {
    case locationCell = "locationCell"
}

// Font
public let fontSize20 = UIFont.systemFont(ofSize: 20)

