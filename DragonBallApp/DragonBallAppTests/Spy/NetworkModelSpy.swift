//
//  NetworkModelSpy.swift
//  DragonBallAppTests
//
//  Created by Aitor Iglesias Pubill on 24/11/22.
//

@testable import DragonBallApp
import XCTest

class NetWorkModelSpy: NetworkModel {
    var showErrorWasCalled: Bool = false
    var loadingWasCalled: Bool = false
    var getHeroesCalled: Bool = false
    var getHeroesExpectation: XCTestExpectation?
    var getLocalizacionHeroesWasCalled: Bool = false
    var getTransformationWasCalled: Bool = false

    //FAKE DE LOGIN
    override func login(user: String, password: String, completion: @escaping (String?, NetworkError?) -> Void) {
        if(user == "Paco" && password == "123456") {
            loadingWasCalled = true
            showErrorWasCalled = false
            completion("KCToken", nil)
            return
        }
        if(user == "" || password == "") {
            loadingWasCalled = true
            showErrorWasCalled = true
            completion(nil, NetworkError.dataFormatting)
            return
        }
        if(user == "Paco1" || password == "12345689") {
            loadingWasCalled = true
            showErrorWasCalled = true
            completion(nil, NetworkError.tokenFormatError)
            return
        }
        completion(nil,nil)
    }
    
    //FAKE DE GETHEROES
    override func getHeroes (name: String = "", completion: @escaping ([Hero], NetworkError?) -> Void) {
        if(name == "Paco") {
            getHeroesCalled = true
            showErrorWasCalled = false
            completion([Hero(id: "", name: "Paco", description: "", photo: "", favorite: true)], nil)
            getHeroesExpectation?.fulfill()
            return
        }
        if(name == "") {
            getHeroesCalled = true
            showErrorWasCalled = false
            completion([Hero(id: "", name: "Paco", description: "", photo: "", favorite: true),
                        Hero(id: "", name: "Raul", description: "", photo: "", favorite: true),
                        Hero(id: "", name: "Santi", description: "", photo: "", favorite: true),
                        Hero(id: "", name: "Manolo", description: "", photo: "", favorite: true)], nil)
            getHeroesExpectation?.fulfill()
            return
        }
        if(name == "ERROR_NETWORK") {
            getHeroesCalled = true
            showErrorWasCalled = true
            completion([], NetworkError.malformedURL)
            getHeroesExpectation?.fulfill()
            return
        }
        getHeroesExpectation?.fulfill()
        completion([],nil)
    }
    
    //FAKE DE LOCATIONS
    override func getLocalizacionHeroes(id: String, completion: @escaping ([HeroCoordenates], NetworkError?) -> Void) {
        if(id == "Paco") {
            showErrorWasCalled = false
            getLocalizacionHeroesWasCalled = true
            completion([HeroCoordenates(id: "", latitud: "1", longitud: "2", dateShow: "hoy")], nil)
            return
        }
        if(id == "") {
            showErrorWasCalled = true
            getLocalizacionHeroesWasCalled = true
            completion([], NetworkError.dataFormatting)
            return
        }
        if(id == "ERROR_NETWORK") {
            showErrorWasCalled = true
            getLocalizacionHeroesWasCalled = true
            completion([], NetworkError.malformedURL)
            return
        }
        getLocalizacionHeroesWasCalled = true
        completion([],nil)
    }
    
    //FAKE DE GET TRANSFORMATIONS
    override func getTransformation (id: String, completion: @escaping ([Transformation], NetworkError?) -> Void) {
        if(id == "Paco") {
            showErrorWasCalled = false
            getTransformationWasCalled = true
            completion([Transformation(id: "", name: "Paco Version 1", description: "", photo: "")], nil)
            return
        }
        if(id == "") {
            showErrorWasCalled = true
            getTransformationWasCalled = true
            completion([], NetworkError.dataFormatting)
            return
        }
        if(id == "ERROR_NETWORK") {
            showErrorWasCalled = true
            getTransformationWasCalled = true
            completion([], NetworkError.malformedURL)
            return
        }
        
        completion([],nil)
    }
    
}

