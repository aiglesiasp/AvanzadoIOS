//
//  MapViewModel.swift
//  DragonBallApp
//
//  Created by Aitor Iglesias Pubill on 23/11/22.
//

import Foundation
import MapKit

final class MapMiewModel {
    
    let coreDataManager: CoreDataManager
    var locations: [CDLocations]
    var hero: Hero?
    
    init(
        coreDataManager: CoreDataManager = CoreDataManager(),
        locations: [CDLocations] = [],
        hero: Hero? = nil)
    {
        self.coreDataManager = coreDataManager
        self.locations = locations
        self.hero = hero
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            checkLocationAuthorization()
        } else {
            //Errores
        }
    }
    
    private func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
           break
        default:
            break
        }
    }
    
    func getHeroesLocationCoreData(for heroId: String) {
        self.locations = self.coreDataManager.fetchLocations(for: heroId)
        
    }
    
    func getHeroesAnnotations(completion: (MKPointAnnotation) -> Void) {
        guard let hero = hero else {return}
        getHeroesLocationCoreData(for: hero.id)
    
        let latitud = Double(locations.first!.latitud)
        let longitud = Double(locations.first!.longitud)
        guard let latitud = latitud,
              let longitud = longitud else {return}
        let annotations = MKPointAnnotation()
        annotations.title = hero.name
        annotations.coordinate = CLLocationCoordinate2D(latitude:latitud, longitude: longitud)
        
        completion(annotations)
    }

}
