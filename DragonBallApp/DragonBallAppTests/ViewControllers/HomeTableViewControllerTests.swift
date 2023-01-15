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
        sut.viewDidLoad()
        sut.loadViewIfNeeded()
        
    }

    override func tearDownWithError() throws {
        sut = nil
    }
       
    
    //CHECK DEL CLICK DE LA CELDA
    func testHomeTableViewCOntroller_CheckCell() throws {
       let view = try XCTUnwrap(sut.viewDidLoad, "vista guardada")
        
       let expLoadingData = expectation(description: "loading")
        DispatchQueue.main.asyncAfter(deadline: .now()+1.0) {
            expLoadingData.fulfill()
       }
        waitForExpectations(timeout: 2.0)
       let tableView = try XCTUnwrap(sut.tableView, "vista guardada")
        guard let cell = tableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? HomeTableViewCell
        //guard let cell = cell as? HomeTableViewCell
       else {
          XCTFail("This is not a HomeTableViewCell")
            return
       }
        
    }
    
    //CHECK DEL CLICK DE LA CELDA
    //func testHomeTableViewCOntroller_CheckCell1() throws {
    //    let tableView = try XCTUnwrap(sut.tableView, "vista guardada")
        
    //    let expLoadingData = expectation(description: "loading")
    //    DispatchQueue.main.asyncAfter(deadline: .now()+1.0) {
    //        expLoadingData.fulfill()
    //    }
    //     waitForExpectations(timeout: 2.0)
        
    //     let cell = tableView.cellForRow(at: IndexPath(item: 1, section: 0))
    //     guard let cell = cell as? HomeTableViewCell
    //    else {
            //        XCTFail("This is not a HomeTableViewCell")
            //        return
    //   }
        
    // }

}

