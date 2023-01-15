//
//  LoginViewModel.swift
//  DragonBallApp
//
//  Created by Aitor Iglesias Pubill on 22/11/22.
//

import UIKit
import KeychainSwift

final class LoginViewModel {
    private var networkModel: NetworkModel
    private var keychain: KeychainSwift
    var onError: ((String) -> Void)?
    var onLogin: (() -> Void)?
    
    init(networkModel: NetworkModel = NetworkModel(),
         keychain: KeychainSwift = KeychainSwift(),
         onError: ((String) -> Void)? = nil,
         onLogin: (() -> Void)? = nil)
    {
        self.networkModel = networkModel
        self.keychain = keychain
        self.onError = onError
        self.onLogin = onLogin
    }
    
    func login(with user: String, password: String) {
        networkModel.login(user: user, password: password) { [weak self] token, error in
            if let error = error {
                self?.onError?(error.localizedDescription)
            }
            
            //Compruebo que el token no esta vacio y son iguales
            guard let token = token, !token.isEmpty else {
                self?.onError?("Wrong token")
                return
            }
            
            self?.keychain.set(token, forKey: "KCToken")
            self?.onLogin?()
    
        }
    }
}
