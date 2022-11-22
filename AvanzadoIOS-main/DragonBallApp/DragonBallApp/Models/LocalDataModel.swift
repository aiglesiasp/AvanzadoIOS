//
//  LocalDataModel.swift
//  DragonBallApp
//
//  Created by Aitor Iglesias Pubill on 22/11/22.
//

import Foundation

//Creamos una variable Constante
private enum Constant {
    static let tokenKey = "KCToken"
}

class LocalDataModel {
    //Creo una variable de tipo UserDefaults
    private static let userDefaults = UserDefaults.standard
    //Creo funcion para obtener el GET del TOKEN
    static func getToken() -> String? {
        userDefaults.string(forKey: Constant.tokenKey)
    }
    //Creo funcion para GUARDAR ese TOKEN
    static func save(token: String) {
        userDefaults.set(token, forKey: Constant.tokenKey)
    }
    static func deleteToken() {
      userDefaults.removeObject(forKey: Constant.tokenKey)
    }
}
