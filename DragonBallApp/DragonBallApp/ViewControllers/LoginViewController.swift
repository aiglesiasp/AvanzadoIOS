//
//  LoginViewController.swift
//  DragonBallApp
//
//  Created by Aitor Iglesias Pubill on 21/11/22.
//

import UIKit
import KeychainSwift

class LoginViewController: UIViewController {
    
    //MARK: IBOUTLETS
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loginButton: UIButton!
    
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
        let model = NetworkModel()
        let nextVC = HomeTableViewController()
        guard let user = username.text,
              let password = password.text else {
            return
        }
        if user.isEmpty || password.isEmpty {
            self.showAlert(title: "Missing fields", message: "Please complete all fields to login")
            return
        }
        
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        self.view.isUserInteractionEnabled = false
        
        //Ahora llamo a la funcion login del Model
        model.login(user: user, password: password) { [weak self] token, error in
            
            DispatchQueue.main.async {
                //Acivo boton y desactivo indicator
                self?.loginButton.isEnabled = true
                self?.activityIndicator.stopAnimating()
                
                if let error = error {
                    self?.showAlert(title: "There was an error", message: error.localizedDescription)
                    return
                }
                //Compruebo que el token no esta vacio y son iguales
                guard let token = token, !token.isEmpty else {
                    self?.showAlert(title: "There is no Token")
                    return
                    
                }
                
                //Guardamos el token
                LocalDataModel.save(token: token)

                //Llamo a la siguiente vista
                self?.navigationController?.setViewControllers([nextVC], animated: true)
            }
        }
        
        
    }
}
