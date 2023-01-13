//
//  TransformationModel.swift
//  DragonBallApp
//
//  Created by Aitor Iglesias Pubill on 21/11/22.
//

import UIKit


// MARK: - CLASSE HEROE -
struct Transformation: Decodable {
    let id: String
    let name: String
    let description: String
    let photo: String
}
