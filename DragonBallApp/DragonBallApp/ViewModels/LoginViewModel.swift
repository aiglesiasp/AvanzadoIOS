//
//  LoginViewModel.swift
//  DragonBallApp
//
//  Created by Aitor Iglesias Pubill on 21/11/22.
//

import Foundation
import KeychainSwift

final class LoginViewModel {
    
    //MARK: Constant
    private let network: NetworkModel
    private let keychain: KeychainSwift
    
    init(network: NetworkModel = NetworkModel(),
         keychain: KeychainSwift = KeychainSwift()) {
        self.network = network
        self.keychain = keychain
    }
    
    //MARK: Funcion que al pulsar llame al login
    func callLoginService(user: String, password: String, completion: @escaping (String?, NetworkError?) -> Void) {
        network.login(user: user, password: password, completion: completion )
    }
    
    //MARK: Funcion salvar token
    func saveToken(token: String) {
        keychain.set(token, forKey: "KCToken")
    }
    
}
