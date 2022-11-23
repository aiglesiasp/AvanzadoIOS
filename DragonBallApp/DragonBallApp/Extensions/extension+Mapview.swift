//
//  extension+Mapview.swift
//  DragonBallApp
//
//  Created by Aitor Iglesias Pubill on 23/11/22.
//

import Foundation
import MapKit

extension MKMapView {
    func centerLocation(location: CLLocation, regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        self.setRegion(coordinateRegion, animated: true)
    }
    
}
