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
        networkSpy = nil
        try super.tearDownWithError()
    }

    //MARK: - TEST LOGIN VIEWMODEL -
    func test_ViewModel_LoginService_Token_Succes() {
        //GIVEN
        let user = "Paco"
        let password = "123456"
        //WHEN - Llamamos al LOGIN
        sut.login(with: user, password: password)
        XCTAssertTrue(networkSpy.loadingWasCalled)
        XCTAssertFalse(networkSpy.showErrorWasCalled)
        
        //THEN
        
        }
    
    func test_ViewModel_LoginService_Token_ErrorDattaFormatting() {
        //GIVEN
        let user = ""
        let password = "123456"
        
        //WHEN - Llamamos al LOGIN
        sut.login(with: user, password: password)
        
        //THEN
        XCTAssertTrue(networkSpy.loadingWasCalled)
        XCTAssertTrue(networkSpy.showErrorWasCalled)
        }
    
    func test_ViewModel_LoginService_Token_ErrorTokenFormat() {
        //GIVEN
        let user = "Paco1"
        let password = "12345689"
        
        //WHEN - Llamamos al LOGIN
        sut.login(with: user, password: password)
        
        //THEN
        XCTAssertTrue(networkSpy.loadingWasCalled)
        XCTAssertTrue(networkSpy.showErrorWasCalled)
        
        }
    
   
    
              
    }


