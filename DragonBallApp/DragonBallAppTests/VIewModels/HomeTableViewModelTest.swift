//
//  HomaTableViewModelTest.swift
//  DragonBallAppTests
//
//  Created by Aitor Iglesias Pubill on 13/1/23.
//

import XCTest
@testable import DragonBallApp

final class HomeTableViewModelTest: XCTestCase {
    
    var sut: HomeTableViewModel!
    private var networkSpy: NetWorkModelSpy!
    
    
    //MARK: - ANTES -
    override func setUpWithError() throws {
        networkSpy = NetWorkModelSpy()
        sut = HomeTableViewModel(networkModel: networkSpy)
    }
    
    //MARK: - DESPUES -
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    //MARK: - TEST LOGIN VIEWMODEL -
    func test_ViewModel_LocationService_listLocation_Succes() {
        let hero = Hero(id: "Paco", name: "", description: "", photo: "", favorite: true)
        
        //WHEN -
        sut.donwloadLocations(for: hero) {}
        
        
        //THEN
        //THEN
        
        XCTAssertTrue(networkSpy.getLocalizacionHeroesWasCalled)
        XCTAssertFalse(networkSpy.showErrorWasCalled)
        
    }
    
    func test_ViewModel_LocationService_Error_DataFormatting() {
        
        let hero = Hero(id: "", name: "", description: "", photo: "", favorite: true)
        
        //WHEN -
        sut.donwloadLocations(for: hero) {}
        
        //THEN
        //THEN
        XCTAssertTrue(networkSpy.getLocalizacionHeroesWasCalled)
        XCTAssertTrue(networkSpy.showErrorWasCalled)
        
    }
    
    func test_ViewModel_LocationService_Error_NetworkError() {
        
        let hero = Hero(id: "ERROR_NETWORK", name: "", description: "", photo: "", favorite: true)
        
        //WHEN -
        sut.donwloadLocations(for: hero) {}
        
        //THEN
        //THEN
        XCTAssertTrue(networkSpy.getLocalizacionHeroesWasCalled)
        XCTAssertTrue(networkSpy.showErrorWasCalled)
        
    }
}
          


