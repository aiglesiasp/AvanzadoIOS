//
//  HomeTableViewModel.swift
//  DragonBallApp
//
//  Created by Aitor Iglesias Pubill on 22/11/22.
//

import UIKit
import KeychainSwift

final class HomeTableViewModel {
    
    private var networkModel: NetworkModel
    private var keychain: KeychainSwift
    
    //DECLARAMOS UN ARRAY DE HEROES
    private(set)var heroesArray: [Hero] = []
    
    //Para comunicrme con la vista que hay un error
    var onError: ((String) -> Void)?
    var onSuccess: (() -> Void)?
    
    //init
    init(networkModel: NetworkModel = NetworkModel(),
         keychain: KeychainSwift = KeychainSwift(),
         onError: ((String) -> Void)? = nil,
         onSuccess: (() -> Void)? = nil)
    {
        self.networkModel = networkModel
        self.keychain = keychain
        self.onError = onError
        self.onSuccess = onSuccess
    }
    
    //llamada a red
    func viewDidLoad() {
        //MARK: CONSEGUIMOS EL TOKEN
        guard let token = keychain.get("KCToken") else {return}
        networkModel.token = token
        
        networkModel.getHeroes { [weak self] heroes, error in
            if let error = error {
                self?.onError?(error.localizedDescription)
            }
            self?.heroesArray = heroes
            self?.onSuccess?()
            
        }
    }
    
    
    
}
