//
//  HomeViewController.swift
//  DragonBallApp
//
//  Created by Aitor Iglesias Pubill on 21/11/22.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {

    //MARK: - IBOUTLETS
    @IBOutlet weak var mapView: MKMapView!
    
    //MARK: - Variables
    //var viewModel = HomeViewModel()
    
    
    //MARK: - Cicle of life
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //viewModel.checkLocationServices()
        //viewModel.viewWillAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupMap()
        //viewModel.getHeroesAnnotations { arrayAnnotations in
        //    mapView.addAnnotations(arrayAnnotations)
        //}
    }


    //MARK: - Configuration Maps
    func setupMap() {
        mapView.showsUserLocation = true
        //mapView.centerLocation(location: CLLocation(latitude: 21.282, longitude: -157.82944))
        
        
    }

}
