//
//  LoginViewControllerTests.swift
//  DragonBallAppTests
//
//  Created by Aitor Iglesias Pubill on 13/1/23.
//

import XCTest
@testable import DragonBallApp

final class LoginViewControllerTests: XCTestCase {
    
    var sut: LoginViewController!
    
    override func setUpWithError() throws {
        sut = LoginViewController()
        sut.loadViewIfNeeded()
        
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testLoginViewCOntroller_CheckClickButtonLogin () throws {
        let buttonlogin = try XCTUnwrap(sut.loginButton)
        
        let expLoadingData = expectation(description: "loading")
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            expLoadingData.fulfill()
        }
        waitForExpectations(timeout: 1.0)
        
        let navigationSpy = NavigationControllerSpy(rootViewController: sut)
        sut.loginPress(Any.self)
        guard let vc = navigationSpy.pushVC as? HomeTableViewController else {
            XCTFail("Fallo navegacion de Login a Home")
            return
            
        }
        XCTAssertTrue(vc.isKind(of: HomeTableViewController.self))
        
        
        
    }
}
