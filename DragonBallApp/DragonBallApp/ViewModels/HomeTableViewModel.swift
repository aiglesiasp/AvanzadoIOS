//
//  HomeTableViewModel.swift
//  DragonBallApp
//
//  Created by Aitor Iglesias Pubill on 22/11/22.
//

import UIKit
import KeychainSwift

class HomeTableViewModel {
    
    private var networkModel: NetworkModel
    private var keychain: KeychainSwift
    private var coreDataManager:  CoreDataManager
    
    private(set)var heroesArray: [Hero] = []
    
    var onError: ((String) -> Void)?
    var onSuccess: (() -> Void)?
    
    init(networkModel: NetworkModel = NetworkModel(),
         keychain: KeychainSwift = KeychainSwift(),
         coreDataManager: CoreDataManager = .shared,
         onError: ((String) -> Void)? = nil,
         onSuccess: (() -> Void)? = nil)
    {
        self.networkModel = networkModel
        self.keychain = keychain
        self.coreDataManager = coreDataManager
        self.onError = onError
        self.onSuccess = onSuccess
    }
    
    func viewDidLoad() {
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.loadHeroes()
        }
    }
    
    func loadHeroes() {
        let cdHeros = coreDataManager.fetchHeros()
        
        guard let date = LocalDataModel.getSyncDate(),
              date.addingTimeInterval(1) > Date(),
              !cdHeros.isEmpty else {
            
            print("Heroes Network Call")
            guard let token = keychain.get("KCToken") else {return}
            networkModel.token = token
            print(token)
            
            networkModel.getHeroes { [weak self] heroes, error in
                
                if let error = error {
                    self?.onError?("Heroes \(error)")
                } else {
                    self?.save(heroes: heroes)
                    
                    let group = DispatchGroup()
                    
                    heroes.forEach { hero in
                        group.enter()
                        self?.donwloadLocations(for: hero) {
                            group.leave()
                        }
                    }
                    
                    group.notify(queue: DispatchQueue.global()) {
                        LocalDataModel.saveSyncDate()
                        if let cdHeroes = self?.coreDataManager.fetchHeros() {
                            self?.heroesArray = cdHeroes.map {$0.hero}
                        }
                        self?.onSuccess?()
                    }
                }
            }
            return
        }
        
        print("Heroes from Core Data")
        heroesArray = cdHeros.map{ $0.hero }
        onSuccess?()
    }
    
    func donwloadLocations(for hero: Hero, completion: @escaping() -> Void) {
        let cdLocations = coreDataManager.fetchLocations(for: hero.id)
        if cdLocations.isEmpty {
            print("Locations Network Call")
            guard let token = keychain.get("KCToken") else {
                completion()
                return
            }
            networkModel.token = token
            networkModel.getLocalizacionHeroes(id: hero.id)
            { [weak self] locations, error in
                if let error = error {
                    self?.onError?("Error: \(error.localizedDescription)")
                } else {
                    self?.save(locations: locations, for: hero)
                    self?.onSuccess?()
                }
                completion()
            }
        }else {
            completion()
        }
    }
}

private extension HomeTableViewModel {
    func save(heroes: [Hero]) {
        _ = heroes.map { CDHero.create(from: $0, context: coreDataManager.context) }
        coreDataManager.saveContext()
    }
    
    func save(locations: [HeroCoordenates], for hero: Hero) {
        guard let cdHero = coreDataManager.fetchHeros(id: hero.id) else {return}
        _ = locations.map{ CDLocations.create(from: $0, for: cdHero, context: coreDataManager.context) }
        coreDataManager.saveContext()
    }
}
