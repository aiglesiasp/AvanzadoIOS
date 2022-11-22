//
//  HomeTableViewCell.swift
//  DragonBallApp
//
//  Created by Aitor Iglesias Pubill on 22/11/22.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var heroeDescription: UILabel!
    @IBOutlet weak var heroeName: UILabel!
    @IBOutlet weak var heroeImage: UIImageView!
    
    
    func setHero(model:Hero) {
        self.heroeName.text = model.name
        self.heroeDescription.text = model.description
        self.heroeImage.setImage(url: model.photo)
    }
}
