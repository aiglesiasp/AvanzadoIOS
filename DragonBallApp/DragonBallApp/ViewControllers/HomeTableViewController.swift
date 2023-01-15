//
//  HomeTableViewController.swift
//  DragonBallApp
//
//  Created by Aitor Iglesias Pubill on 22/11/22.
//

import UIKit
import KeychainSwift

final class HomeTableViewController: UITableViewController {
        
   let viewModel = HomeTableViewModel()
       
    //MARK: - FUNCION VISUAL
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "LISTA DE HEROES"
        
        //MARK: - REGISTRAR NUESTRA CELDA -
        tableView?.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "viewCell")
        
        
        viewModel.onError = { message in
            DispatchQueue.main.async {
                print(message)
            }
        }
        
        viewModel.onSuccess = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.viewDidLoad()
    }
    

    // MARK: - Table view data source -
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.heroesArray.count
    }

    
    // MARK: - AQUI LE PASO EL TIPO DE CELDA -
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // MARK: - Casting de la celda
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "viewCell", for: indexPath) as? HomeTableViewCell else {
            //Si no lo encuentra devuelve una table view normal
            return UITableViewCell()
        }

        // TODO: - Aqui he pasado variables
        cell.setHero(model: viewModel.heroesArray[indexPath.row])
        // Configure the cell...
        return cell
    }
    
    
    // MARK: - FUNCION PARA PASAR A LA PANTALLA DETAILS -
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //Creo el Detail ViewConroller
        let nextVC = DetailViewController()
        //Le paso la lista de heroes
        let hero = viewModel.heroesArray[indexPath.row]
        nextVC.set(model: hero)
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
