//
//  NetworkModelSpy.swift
//  DragonBallAppTests
//
//  Created by Aitor Iglesias Pubill on 24/11/22.
//

import Foundation
@testable import DragonBallApp

class NetWorkModelSpy: NetworkModel {

    override func login(user: String, password: String, completion: @escaping (String?, NetworkError?) -> Void) {
        if(user == "Paco" && password == "123456") {
            completion("KCToken", nil)
            return
        }
        completion(nil,nil)
    }
}
