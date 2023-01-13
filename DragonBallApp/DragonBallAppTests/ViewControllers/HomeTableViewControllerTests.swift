//
//  HomeTableViewControllerTests.swift
//  DragonBallAppTests
//
//  Created by Aitor Iglesias Pubill on 13/1/23.
//

import XCTest
@testable import DragonBallApp

final class HomeTableViewControllerTests: XCTestCase {
    
    var sut: HomeTableViewController!

    override func setUpWithError() throws {
        sut = HomeTableViewController()
        sut.loadViewIfNeeded()
        
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testLoadViewCOntroller() throws {
        let tableView = try XCTUnwrap(sut.tableView, "-")
    }
    
    
    //CHECK DE LA CELDA
    func testHomeTableViewController_CheckCell() throws {
        let tableView = try XCTUnwrap(sut.tableView, "vista guardada")
        
        let expLoadingData = expectation(description: "loading")
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            expLoadingData.fulfill()
        }
        waitForExpectations(timeout: 1.0)
        
        let cell = tableView.cellForRow(at: IndexPath(item: 1, section: 0))
        guard let cell = cell as? HomeTableViewCell
        else {
            XCTFail("This is not a HomeTableViewCell")
            return
        }
        
        let name = try XCTUnwrap(cell.heroeName, "nombre del heroe")
        
        XCTAssertNotNil(name.text)
        XCTAssertNotNil(cell.heroeDescription.text)
        XCTAssertNotNil(cell.heroeImage.self)
    }
    
    //CHECK DEL CLICK DE LA CELDA
    func testHomeTableViewCOntroller_CheckClickCell() throws {
        let tableView = try XCTUnwrap(sut.tableView, "vista guardada")
        
        let expLoadingData = expectation(description: "loading")
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            expLoadingData.fulfill()
        }
        waitForExpectations(timeout: 1.0)
        
        let cell = tableView.cellForRow(at: IndexPath(item: 1, section: 0))
        guard let cell = cell as? HomeTableViewCell
        else {
            XCTFail("This is not a HomeTableViewCell")
            return
        }
        
    }

}

