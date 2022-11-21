//
//  LoginViewModel.swift
//  DragonBallApp
//
//  Created by Aitor Iglesias Pubill on 21/11/22.
//

import Foundation

final class LoginViewModel {
    
    //MARK: Constant
    private let network: NetworkModel
    //private let keyChain: KeyChainHelper
    
    init(network: NetworkModel = NetworkModel()){
    //     keyChain: KeyChainHelper = KeyChainHelper.standar) {
       self.network = network
    //    self.keyChain = keyChain
    }
    
    //MARK: Funcion que al pulsar llame al login
    func callLoginService(user: String, password: String, completion: @escaping (String?, NetworkError?) -> Void) {
        network.login(user: user, password: password, completion: completion )
    }
    
    //MARK: Funcion salvar token
    func saveToken(token: String) {
        let data = Data(token.utf8)
        //keyChain.save(data: data, service: "login", account: "Aitor")
    }
    
}
