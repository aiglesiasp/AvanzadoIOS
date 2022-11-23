//
//  MapViewModel.swift
//  DragonBallApp
//
//  Created by Aitor Iglesias Pubill on 23/11/22.
//

import Foundation
import MapKit

final class MapMiewModel {
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            
        } else {
            //Errores
        }
    }
    
    private func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        default:
            break
        }
    }
}
