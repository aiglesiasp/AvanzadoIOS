//
//  HomeTableViewController.swift
//  DragonBallAppTests
//
//  Created by Aitor Iglesias Pubill on 19/1/23.
//

import XCTest
@testable import DragonBallApp

final class HomeTableViewControllerTest: XCTestCase {
    
    var vc: HomeTableViewController!

    override func setUpWithError() throws {
        vc = HomeTableViewController()
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func test_checkCell() {
        vc.viewDidLoad()
        let table = try? XCTUnwrap(vc.tableView)
        guard table is HomeTableViewCell else {
            XCTFail("No es un HomeTableViewCell")
            return
        }
    }

}
