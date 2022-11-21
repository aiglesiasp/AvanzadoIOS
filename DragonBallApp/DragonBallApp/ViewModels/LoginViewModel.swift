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
    
    init(network: NetworkModel = NetworkModel()) {
       self.network = network
    }
    
    //MARK: Funcion que al pulsar llame al login
    func callLoginService(user: String, password: String, completion: @escaping (String?, NetworkError?) -> Void) {
        network.login(user: user, password: password, completion: completion )
    }
    
    //MARK: Funcion salvar token
    func saveToken(token: String) { //TODO:
        //let data = Data(token.utf8)
        KeychainSwift().set(token, forKey: "KCToken")
    }
    
}
