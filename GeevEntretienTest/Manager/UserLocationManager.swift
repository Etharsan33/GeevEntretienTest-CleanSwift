//
//  UserLocationManager.swift
//  GeevEntretienTest
//
//  Created by ELANKUMARAN Tharsan on 13/06/2020.
//  Copyright © 2020 ELANKUMARAN Tharsan. All rights reserved.
//

import Foundation
import MapKit

struct UserLocationManager {
    
    static let shared = UserLocationManager()
    
    let userLocation = CLLocation(latitude: Constants.defaultCoordinate.latitude, longitude: Constants.defaultCoordinate.longitude)
    
    func getDistanceByUserLocation(_ location: Location) -> String? {
        let destinationLoc = CLLocation(latitude: location.latitude, longitude: location.longitude)
        let distance = userLocation.distance(from: destinationLoc)
        
        if distance >= 1000 {
            return String(format: "%.1f", distance / 1000) + " km"
        }
        return String(format: "%.1f", distance) + " m"
    }
}
