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
        mapView.centerLocation(location: CLLocation(latitude: 40.43, longitude: -3.70), regionRadius: 10000000)
    }
    
}
