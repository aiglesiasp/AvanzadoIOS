//
//  LoginViewController.swift
//  DragonBallApp
//
//  Created by Aitor Iglesias Pubill on 21/11/22.
//

import UIKit
import KeychainSwift

final class LoginViewController: UIViewController {
    
    //MARK: IBOUTLETS
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loginButton: UIButton!
    
    var viewModel=LoginViewModel()
    
    //MARK: Cicle of live
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.onError = { [weak self] message in
            DispatchQueue.main.async {
                self?.loginButton.isEnabled = true
                self?.activityIndicator.stopAnimating()
            }
            print(message)
        }
        
        viewModel.onLogin = { [weak self] in
            DispatchQueue.main.async {
                self?.loginButton.isEnabled = true
                self?.activityIndicator.stopAnimating()
               
                let nextVC = HomeTableViewController()
                self?.navigationController?.setViewControllers([nextVC], animated: true)
            }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        activityIndicator.isHidden = true
    }
    
    
    //MARK: ACTIONS
    
    @IBAction func loginPress(_ sender: Any) {
        
        guard let user = username.text,
              let password = password.text else {
            return
        }
        if user.isEmpty || password.isEmpty {
            self.showAlert(title: "Missing fields", message: "Please complete all fields to login")
            return
        }
        
        viewModel.login(with: user, password: password)

    }
}
