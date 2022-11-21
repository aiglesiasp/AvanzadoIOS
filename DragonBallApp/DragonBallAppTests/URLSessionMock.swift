//
//  URLSessionMock.swift
//  DragonBallAppTests
//
//  Created by Aitor Iglesias Pubill on 21/11/22.
//

import Foundation

//MARK: - MOCK de URLSession -
class URLSessionMock: URLSession {
    
    //Sobrescribit el init en vacio para que no haga nada
    override init () {}
    
    var data: Data?
    var error: Error?
    var response: URLResponse?
    
    //Sobreescribimos la funcion dataTask
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return URLSessionDataTaskMock {
            completionHandler(self.data, self.response, self.error)
        }
    }
}

//MARK: - MOCK DEL DATATASK -
class URLSessionDataTaskMock: URLSessionDataTask {
    
    //Creamos el clousure que le pasaremos al resume
    private let clousure: () -> Void
    
    init(clousure: @escaping () -> Void) {
        self.clousure = clousure
    }
    //Sobreescribimos el RESUME
    override func resume() {
        clousure()
    }
}

