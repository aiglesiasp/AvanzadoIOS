//
//  SplashViewController.swift
//  DragonBallApp
//
//  Created by Aitor Iglesias Pubill on 21/11/22.
//

import UIKit
//MARK: -PROTOCOLO -
protocol SplashViewProtocol: AnyObject {
    func showLoading(_ show: Bool)
    func navigateToHome()
}

//MARK: - CLASE-
class SplashViewController: UIViewController {

    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //Variable para comunicarme con el protocolo del viewModel
    var viewModel: SplashViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.onViewsLoaded()

        
    }
    
    //MARK: VISTA VA A DESAPARECER CTIVITY INDICATOR SE DESACTIVA
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        activityIndicator.stopAnimating()
    }

}

//MARK: - EXTENSION -
extension SplashViewController: SplashViewProtocol {
    func showLoading(_ show: Bool) {
        switch show {
        case true where !activityIndicator.isAnimating:
            activityIndicator.startAnimating()
        case false where activityIndicator.isAnimating:
            activityIndicator.stopAnimating()
        default: break
        }
    }
    
    func navigateToHome() {
        //let nextVC = HomeTableViewController()
        //nextVC.viewModel = HomeViewModel(viewDelegate: nextVC)
        //self.navigationController?.setViewControllers([nextVC], animated: true)
    }
    
    
}
