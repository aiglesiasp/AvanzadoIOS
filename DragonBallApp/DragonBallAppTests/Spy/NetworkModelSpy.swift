//
//  NetworkModelSpy.swift
//  DragonBallAppTests
//
//  Created by Aitor Iglesias Pubill on 24/11/22.
//

import Foundation
@testable import DragonBallApp

class NetWorkModelSpy: NetworkModel {

    //FAKE DE LOGIN
    override func login(user: String, password: String, completion: @escaping (String?, NetworkError?) -> Void) {
        if(user == "Paco" && password == "123456") {
            completion("KCToken", nil)
            return
        }
        if(user == "" || password == "") {
            completion(nil, NetworkError.dataFormatting)
            return
        }
        if(user == "Paco1" || password == "12345689") {
            completion(nil, NetworkError.tokenFormatError)
            return
        }
        
        completion(nil,nil)
    }
    
    //FAKE DE GETHEROES
    override func getHeroes (name: String = "", completion: @escaping ([Hero], NetworkError?) -> Void) {
        if(name == "Paco") {
            completion([Hero(id: "", name: "Paco", description: "", photo: URL(filePath: ""), favorite: true)], nil)
            return
        }
        if(name == "") {
            completion([Hero(id: "", name: "Paco", description: "", photo: URL(filePath: ""), favorite: true),
                        Hero(id: "", name: "Raul", description: "", photo: URL(filePath: ""), favorite: true),
                        Hero(id: "", name: "Santi", description: "", photo: URL(filePath: ""), favorite: true),
                        Hero(id: "", name: "Manolo", description: "", photo: URL(filePath: ""), favorite: true)], nil)
            return
        }
        if(name == "ERROR_NETWORK") {
            completion([], NetworkError.malformedURL)
            return
        }
        
        completion([],nil)
    }
    
    //FAKE DE LOCATIONS
    override func getLocalizacionHeroes(id: String, completion: @escaping ([HeroCoordenates], NetworkError?) -> Void) {
        if(id == "Paco") {
            completion([HeroCoordenates(id: "", latitud: "1", longitud: "2", dateShow: "hoy")], nil)
            return
        }
        if(id == "") {
            completion([], NetworkError.dataFormatting)
            return
        }
        if(id == "ERROR_NETWORK") {
            completion([], NetworkError.malformedURL)
            return
        }
        
        completion([],nil)
    }
    
    //FAKE DE GET TRANSFORMATIONS
    override func getTransformation (id: String, completion: @escaping ([Transformation], NetworkError?) -> Void) {
        if(id == "Paco") {
            completion([Transformation(id: "", name: "Paco Version 1", description: "", photo: URL(filePath: ""))], nil)
            return
        }
        if(id == "") {
            completion([], NetworkError.dataFormatting)
            return
        }
        if(id == "ERROR_NETWORK") {
            completion([], NetworkError.malformedURL)
            return
        }
        
        completion([],nil)
    }
    
}

