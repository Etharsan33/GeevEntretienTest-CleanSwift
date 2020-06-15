//
//  Constants.swift
//  GeevEntretienTest
//
//  Created by ELANKUMARAN Tharsan on 13/06/2020.
//  Copyright © 2020 ELANKUMARAN Tharsan. All rights reserved.
//

import MapKit

struct Constants {
    
    // MARK: - Network
    struct Network {
        private static let version: String = "0.19"
        static let baseURL: String = "https://stage.geev.fr/api/v\(Network.version)"
        static let basePictureURL: String = "https://stage-images.geev.fr"
        
        enum Route: String {
            case getDonations = "/olditems"
        }
    }
    
    // MARK: - Static
    static let defaultCoordinate = CLLocationCoordinate2D(latitude: 44.837789, longitude: -0.5791799999999512)
    static let defaultDistance: Double = 5000
}
