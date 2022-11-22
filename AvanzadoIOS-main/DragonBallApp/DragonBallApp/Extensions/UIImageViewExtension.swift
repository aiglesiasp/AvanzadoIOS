//
//  UIImageViewExtension.swift
//  DragonBallApp
//
//  Created by Aitor Iglesias Pubill on 22/11/22.
//

import UIKit

//Creo TYPEALIAS para no escribir tanto
typealias ImageCompletion = (UIImage?) -> Void

extension UIImageView {
    
    //Funcion para setear la Imagen
    func setImage(url: URL) {
        
        //Llamamos a la funcion descargar Imagen
        downloadImageWithUrlSession(url: url) { [weak self] image in
            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }
    
    
    //FUNCION para descargar imagen
    private func downloadImageWithUrlSession (url: URL, completion: ImageCompletion?) {
        
        //Compruebo datos
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data,
                  let image = UIImage(data: data)
            else {
                completion?(nil)
                return
            }
            completion?(image)
        }.resume()
    }
}

