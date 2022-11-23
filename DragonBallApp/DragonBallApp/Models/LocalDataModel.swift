//
//  LocalDataModel.swift
//  DragonBallApp
//
//  Created by Aitor Iglesias Pubill on 23/11/22.
//

import Foundation

private enum Constants {
   static let tokenKey = "KCToken"
}

final class LocalDataModel {
    
    private static let userDefaults = UserDefaults.standard
    
    static func saveSyncDate() {
        userDefaults.set(Date(), forKey: "KCLastSyncDate")
    }
    
    static func getSyncDate() -> Date? {
        userDefaults.object(forKey: "KCLastSyncDate") as? Date
    }
    
    
    static func getToken() -> String? {
        userDefaults.string(forKey: Constants.tokenKey)
    }
    
    static func save(token: String) {
        userDefaults.set(token ,forKey: Constants.tokenKey)
    }
    
    static func deleteToken() {
        userDefaults.removeObject(forKey: Constants.tokenKey)
    }
    
    
    
    
    
}

