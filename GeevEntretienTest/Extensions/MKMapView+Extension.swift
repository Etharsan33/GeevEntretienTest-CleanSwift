//
//  MKMapView+Extension.swift
//  GeevEntretienTest
//
//  Created by ELANKUMARAN Tharsan on 11/06/2020.
//  Copyright © 2020 ELANKUMARAN Tharsan. All rights reserved.
//

import MapKit

extension MKMapView {
    
    func centerMap(_ coordinate: CLLocationCoordinate2D, distance: CLLocationDistance = 1000, animated: Bool = true) {
        let coordinateRegion = MKCoordinateRegion(center: coordinate,
                                                  latitudinalMeters: distance, longitudinalMeters: distance)
        self.setRegion(coordinateRegion, animated: animated)
    }
}
