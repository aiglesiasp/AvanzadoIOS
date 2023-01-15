//
//  DetailViewControllerTests.swift
//  DragonBallAppTests
//
//  Created by Aitor Iglesias Pubill on 13/1/23.
//

import XCTest
@testable import DragonBallApp

final class DetailViewControllerTests: XCTestCase {
    
    var sut: DetailViewController!
    
    override func setUpWithError() throws {
        sut = DetailViewController()
        sut.loadViewIfNeeded()
        
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testDetailViewCOntroller_CheckIBOutlets_Name () throws {
        let name = try XCTUnwrap(sut.heroeName, "vista cargada")
        let description = try XCTUnwrap(sut.heroeDescription, "vista cargada")
        let photo = try XCTUnwrap(sut.heroeImage, "vista cargada")
        
        let expLoadingData = expectation(description: "loading")
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            expLoadingData.fulfill()
        }
        waitForExpectations(timeout: 1.0)
        
        XCTAssertNotNil(name.text)
        XCTAssertNotNil(description.text)
        XCTAssertNotNil(photo.self)
    }
    
    func testDetailViewCOntroller_CheckClickButtonLocations () throws {
        let buttonLocation = try XCTUnwrap(sut.buttonLocations, "boton obtenido")
        
        let expLoadingData = expectation(description: "loading")
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            expLoadingData.fulfill()
        }
        waitForExpectations(timeout: 1.0)
        
        let action = buttonLocation.actions(forTarget: sut, forControlEvent: .touchUpInside)
        XCTAssertEqual(action?.count, 1)
        
        let navigationSpy = NavigationControllerSpy(rootViewController: sut)
        sut.onTapButtonLocations("")
        guard let vc = navigationSpy.pushVC as? MapViewController else {
            XCTFail("Fallo navegacion de Detail a Map")
            return
            
        }
        XCTAssertTrue(vc.isKind(of: MapViewController.self))
        
        
    }
}
    
    
    
    

