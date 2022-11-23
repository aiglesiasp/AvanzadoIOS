//
//  MapViewController.swift
//  DragonBallApp
//
//  Created by Aitor Iglesias Pubill on 23/11/22.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var viewModel = MapMiewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.checkLocationServices()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupMap()
    }
    
    //MARK: Funcion configurar mapa
    func setupMap() {
        mapView.showsUserLocation = true
        viewModel.getHeroesAnnotations { arrayAnnotations in
            mapView.addAnnotations([arrayAnnotations])
        }
        mapView.centerLocation(location: CLLocation(latitude: mapView.annotations.first?.coordinate.latitude ?? 40.43, longitude: mapView.annotations.first?.coordinate.longitude ?? -3.70), regionRadius: 1000000)
    }
    
    func set(model: Hero) {
        viewModel.hero = model
    }
}
