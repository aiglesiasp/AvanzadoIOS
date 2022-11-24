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
    
    
    
    override func setUpWithError() throws {
        networkSpy = NetWorkModelSpy()
        sut = LoginViewModel(networkModel: networkSpy)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testViewModelLoginServiceTokenSucces() {
        
        let user = "Paco"
        let password = ""
        sut.login(with: user, password: password)
        
        
        }
              
    }


