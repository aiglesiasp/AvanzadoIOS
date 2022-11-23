//
//  DetailViewController.swift
//  DragonBallApp
//
//  Created by Aitor Iglesias Pubill on 22/11/22.
//

import UIKit

class DetailViewController: UIViewController {

   
    @IBOutlet weak var heroeImage: UIImageView!
    @IBOutlet weak var heroeName: UILabel!
    @IBOutlet weak var heroeDescription: UITextView!
    
    //Declaro variable simple de heroe
    private var hero: Hero?
    
    
    //MARK: - CARGAR LA VISTA DE DETAIL -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "HEROE"
        
        guard let hero = hero else {return}
                
        self.heroeImage.setImage(url: hero.photo)
        self.heroeName.text = hero.name
        self.heroeDescription.text = hero.description
        }
    
    //MARK: - FUNCION PARA SETEAR UN HEROE -
    func set(model: Hero) {
        hero = model
    }
    
    
    //MARK: BOTON POSICIONES
    @IBAction func onTapButtonLocations(_ sender: Any) {
        let nextVC = MapViewController()
        guard let hero = hero else {return}
        nextVC.set(model: hero)
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
}


