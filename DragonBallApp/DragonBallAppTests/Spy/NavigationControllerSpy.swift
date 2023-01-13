//
//  HomeTableViewModelSpy.swift
//  DragonBallAppTests
//
//  Created by Aitor Iglesias Pubill on 13/1/23.
//

@testable import DragonBallApp
import XCTest

class NavigationControllerSpy: UINavigationController {
    
    var pushVC: UIViewController!
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        pushVC = viewController
    }

    
 
}
