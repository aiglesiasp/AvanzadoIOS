//
//  NetworkModel.swift
//  DragonBallApp
//
//  Created by Aitor Iglesias Pubill on 21/11/22.
//

import Foundation


//CREMOA NUESTROS ERROR
enum NetworkError: Error, Equatable {
    case malformedURL
    case dataFormatting
    case other
    case noData
    case errorCode(code: Int?)
    case tokenFormatError
    case decoding
    case unknown
    case decodingFailed
}

class NetworkModel {
    //Creo variable session
    let session : URLSession
    //Creo variable para guardarme el token
    var token: String?
    
    //MARK: Inicializando el token
    init(urlSession: URLSession = .shared, token: String? = nil) {
        self.session = urlSession
        self.token = token
    }
    
    //Creo instancia de objeto singelton
    //static let shared = NetworkModel()
    //private init () {
    //}
    
    // MARK: - CREO LA FUNCION PARA HACER EL LOGIN Y COMPROBARLO
    //Le paso el escaping porque a lo mejor el completion tarda mas ue la vida de la funcion
    func login(user: String, password: String, completion: @escaping (String?, NetworkError?) -> Void) {
        //CREO LA URL HACIA LA API DE LOGIN y SI FALLA QUE ME DEVUELVA UN ERROR
        guard let url = URL (string: "https://vapor2022.herokuapp.com/api/auth/login") else {
            completion(nil, NetworkError.malformedURL)
            return
        }
        //CODIFICACION DE LA URL
        //let loginString = user + ":" + password
        let loginString = String(format: "%@:%@", user, password)
        guard let loginData = loginString.data(using: .utf8) else {
            completion(nil, NetworkError.dataFormatting)
            return
        }
        let base64LoginString = loginData.base64EncodedString()
        //Creo la REQUEST
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        //MARK: Creamos el DATATASK que usa este REQUEST
        let task = session.dataTask(with: urlRequest) { data, response, error in
            //Compruebo que el error es nil para seguir, sino salta el error
            guard error == nil
            else {
                completion(nil, NetworkError.other)
                return
            }
            //Miramos que la data tenga contenido
            guard let data = data
            else {
                completion(nil, NetworkError.noData)
                return
            }
            //Miramos e tipo de respuesta recibido
            guard let httpResponse = (response as? HTTPURLResponse),
                  httpResponse.statusCode == 200
            else {
                completion(nil, NetworkError.errorCode(code: (response as? HTTPURLResponse)?.statusCode))
                return
            }
            //Miramos el token
            guard let token = String(data: data, encoding: .utf8)
            else {
                completion(nil, NetworkError.tokenFormatError)
                return
            }
            //Paso el token
            completion(token, nil)
        }
        task.resume()
    }
    
    
    //MARK: - CREO FUNCION PARA LISTA DE HEROES -
    func getHeroes (name: String = "", completion: @escaping ([Hero], NetworkError?) -> Void) {
        //LLAMADA A RED
        guard let url = URL (string: "https://vapor2022.herokuapp.com/api/heros/all") else {
            completion([], NetworkError.malformedURL)
            return
        }
        //CHEQUEO TOKEN
        guard let token = self.token else {
            completion([], NetworkError.other)
            return
        }
        //Creo el BODY
        var urlComponents = URLComponents()
        urlComponents.queryItems = [URLQueryItem(name: "name", value: "")]
        //Creo la REQUEST
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = urlComponents.query?.data(using: .utf8)
        
        //Vuelvo a crear la tarea para verificar todo
        //MARK: Creamos el DATATASK que usa este REQUEST
        let task = session.dataTask(with: urlRequest) { data, response, error in
            //Compruebo que el error es nil para seguir, sino salta el error
            guard error == nil
            else {
                completion([], NetworkError.other)
                return
            }
            //Miramos que la data tenga contenido
            guard let data = data
            else {
                completion([], NetworkError.noData)
                return
            }
            //Miramos e tipo de respuesta recibido
            guard let httpResponse = (response as? HTTPURLResponse),
                  httpResponse.statusCode == 200
            else {
                completion([], NetworkError.errorCode(code: (response as? HTTPURLResponse)?.statusCode))
                return
            }
            
            guard let heroesResponse = try? JSONDecoder().decode([Hero].self, from: data) else {
                completion([], NetworkError.decoding)
                return
            }
            
            //Paso el token
            completion(heroesResponse, nil)
        }
        task.resume()
    }
    
    //MARK: - CREO FUNCION PARA LISTA DE HEROES -
    func getTransformation (id: String, completion: @escaping ([Transformation], NetworkError?) -> Void) {
        //LLAMADA A RED
        guard let url = URL (string: "https://vapor2022.herokuapp.com/api/heros/tranformations") else {
            completion([], NetworkError.malformedURL)
            return
        }
        //CHEQUEO TOKEN
        guard let token = self.token else {
            completion([], NetworkError.tokenFormatError)
            return
        }
        //Creo el BODY
        var urlComponents = URLComponents()
        urlComponents.queryItems = [URLQueryItem(name: "id", value: id)]
        //Creo la REQUEST
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = urlComponents.query?.data(using: .utf8)
        //Necesitamos pasarle un BODY a la request
        struct Body: Encodable {
            let id: String
        }
        let body = Body(id: id)
        
        //Le pasamos el body a la request
        urlRequest.httpBody = try? JSONEncoder().encode(body)
        
        
        //MARK: Creamos el DATATASK que usa este REQUEST
        let task = session.dataTask(with: urlRequest) { data, response, error in
            //Compruebo que el error es nil para seguir, sino salta el error
            guard error == nil
            else {
                completion([], NetworkError.other)
                return
            }
            //Miramos que la data tenga contenido
            guard let data = data
            else {
                completion([], NetworkError.noData)
                return
            }
            //Miramos e tipo de respuesta recibido
            guard let httpResponse = (response as? HTTPURLResponse),
                  httpResponse.statusCode == 200
            else {
                completion([], NetworkError.errorCode(code: (response as? HTTPURLResponse)?.statusCode))
                return
            }
            
            guard let transformationResponse = try? JSONDecoder().decode([Transformation].self, from: data) else {
                completion([], NetworkError.decoding)
                return
            }
            
            //Paso el token
            completion(transformationResponse, nil)
        }
        task.resume()
    }
    
    
    //MARK: GET LOCALIZATIONS
    func getLocalizacionHeroes(id: String, completion: @escaping ([HeroCoordenates], NetworkError?) -> Void) {
        guard let url = URL(string: "https://vapor2022.herokuapp.com/api/heros/locations"),
              let token = self.token else {
            completion([], NetworkError.malformedURL)
            return
        }
        
        var urlComponents = URLComponents()
        urlComponents.queryItems = [URLQueryItem(name: "id", value: id)]
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = urlComponents.query?.data(using: .utf8)
        
        //MARK: Creamos el DATATASK que usa este REQUEST
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                completion([], NetworkError.unknown)
                return
            }
            
            guard let data = data else {
                completion([], NetworkError.noData)
                return
            }
            
            //Miramos e tipo de respuesta recibido
            guard let httpResponse = (response as? HTTPURLResponse),
                  httpResponse.statusCode == 200
            else {
                completion([], NetworkError.errorCode(code: (response as? HTTPURLResponse)?.statusCode))
                return
            }
            
            guard let response = try? JSONDecoder().decode([HeroCoordenates].self, from: data) else {
                completion([], NetworkError.decodingFailed)
                return
            }
            completion(response, nil)
        }
        
        task.resume()
    }
}


extension NetworkModel {
    
}


