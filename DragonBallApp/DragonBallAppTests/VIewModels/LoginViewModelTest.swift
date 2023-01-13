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
    func test_ViewModel_LoginService_Token_Succes() {
        var retrievedToken: String?
        var error: NetworkError?
        
        let user = "Paco"
        let password = "123456"
        //WHEN - Llamamos al LOGIN
        sut.login(with: user, password: password)
            
        
        //THEN
        
        }
    
    func test_ViewModel_LoginService_Token_ErrorDattaFormatting() {
        var retrievedToken: String?
        var error: NetworkError?
        
        let user = ""
        let password = "123456"
        //WHEN - Llamamos al LOGIN
        sut.login(with: user, password: password)
            
        
        //THEN
        
        }
    
    func test_ViewModel_LoginService_Token_ErrorTokenFormat() {
        var retrievedToken: String?
        var error: NetworkError?
        
        let user = "Paco1"
        let password = "12345689"
        //WHEN - Llamamos al LOGIN
        var actual = sut.login(with: user, password: password)
        
        
            
        
        //THEN
        
        }
              
    }


