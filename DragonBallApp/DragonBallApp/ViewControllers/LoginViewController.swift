//
//  LoginViewController.swift
//  DragonBallApp
//
//  Created by Aitor Iglesias Pubill on 21/11/22.
//

import UIKit

class LoginViewController: UIViewController {

    //MARK: IBOUTLETS
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    //MARK: Constant
    let viewModel = LoginViewModel()
    
    
    //MARK: Cicle of live
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        activityIndicator.isHidden = true
    }
    
    //MARK: ACTIONS
    
    @IBAction func loginPress(_ sender: Any) {
        guard let user = username.text,
              let password = password.text else {
            //Show error validation textFields
            return
        }
        if user.isEmpty || password.isEmpty {
            //Show empty validations
            return
        }
        
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        self.view.isUserInteractionEnabled = false
        
        viewModel.callLoginService(
            user: user,
            password: password,
            completion: { token, error in
                if error != nil {
                    //show the correct error
                }
                
                if let token = token {
                    self.viewModel.saveToken(token: token) //TODO: 
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                        self.view.isUserInteractionEnabled = true
                        let nextVC = HomeViewController()
                        self.navigationController?.setViewControllers([nextVC], animated: true)
                    }
                }
    })
        
        
    }

}
