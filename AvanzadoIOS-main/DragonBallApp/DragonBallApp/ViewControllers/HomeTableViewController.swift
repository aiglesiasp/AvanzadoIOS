//
//  HomeTableViewController.swift
//  DragonBallApp
//
//  Created by Aitor Iglesias Pubill on 22/11/22.
//

import UIKit
//import KeychainSwift

class HomeTableViewController: UITableViewController {
        
    //DECLARAMOS UN ARRAY DE HEROES
    var heroesArray: [Hero] = []
       
    //MARK: - FUNCION VISUAL
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "LISTA DE HEROES"
        
        //MARK: - REGISTRAR NUESTRA CELDA -
        tableView?.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "viewCell")
        
        //MARK: CONSEGUIMOS EL TOKEN
        //guard let token = KeychainSwift().get("KCToken") else {return}
        guard let token = LocalDataModel.getToken() else {return}
        //MARK: - LLAMADA A RED -
        let networkModel = NetworkModel(token: token)
                                        
        networkModel.getHeroes { [weak self] heroes, _ in
            guard let self = self else { return }
                self.heroesArray = heroes
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
        
    }

    // MARK: - Table view data source -
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return heroesArray.count
    }

    
    // MARK: - AQUI LE PASO EL TIPO DE CELDA -
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // MARK: - Casting de la celda
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "viewCell", for: indexPath) as? HomeTableViewCell else {
            //Si no lo encuentra devuelve una table view normal
            return UITableViewCell()
        }

        // TODO: - Aqui he pasado variables
        cell.setHero(model: heroesArray[indexPath.row])
        // Configure the cell...
        return cell
    }
    
    
    // MARK: - FUNCION PARA PASAR A LA PANTALLA DETAILS -
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //Creo el Detail ViewConroller
        let nextVC = DetailViewController()
        //Le paso la lista de heroes
        nextVC.set(model: heroesArray[indexPath.row])
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
