//
//  LoginViewModelTest.swift
//  DragonBallAppTests
//
//  Created by Aitor Iglesias Pubill on 24/11/22.
//

import XCTest
@testable import DragonBallApp

final class LoginViewModelTest: XCTestCase {
    
    var sut: LoginViewModel!
    private var networkSpy: NetWorkModelSpy!
    
    
    //MARK: - ANTES -
    override func setUpWithError() throws {
        networkSpy = NetWorkModelSpy()
        sut = LoginViewModel(networkModel: networkSpy)
    }
    
    //MARK: - DESPUES -
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    //MARK: - TEST LOGIN VIEWMODEL -
    func testViewModelLoginServiceTokenSucces() {
        var retrievedToken: String
        var error: NetworkError?
        
        let user = "Paco"
        let password = "123456"
        //WHEN - Llamamos al LOGIN
        //sut.login(with: user, password: password)
        
        //THEN
        
        }
              
    }


