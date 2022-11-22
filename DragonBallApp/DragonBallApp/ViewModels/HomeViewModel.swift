//
//  HomeViewModel.swift
//  DragonBallApp
//
//  Created by Aitor Iglesias Pubill on 21/11/22.
//

import Foundation
import MapKit
import KeychainSwift

final class HomeViewModel {
    
    //MARK: Constant
    private let manager = CLLocationManager()
    private var network: NetworkModel
    private let keychain: KeychainSwift
    
    init(network: NetworkModel = NetworkModel(),
         keychain: KeychainSwift = KeychainSwift()) {
        self.network = network
        self.keychain = keychain
    }
    
    //MARK: - VARIABLES
    var heroes: [Hero] = []
    
    //MARK: - CICLO DE VIDA
    func viewWillAppear() {
        let keychain = KeychainSwift().get("KCToken")
        guard let keychain = keychain else {return}
        self.network = NetworkModel(token: keychain)
        
        self.network.getHeroes { [weak self] heroes, error in
            guard let self = self else {return}
            self.heroes = heroes
        }
        print(heroes.self)
    }
    
    
    
}
