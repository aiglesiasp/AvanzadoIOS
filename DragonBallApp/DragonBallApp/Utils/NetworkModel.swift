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

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}


//MARK: - CLASE -
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
        struct Body: Encodable {
            let name: String
        }
        let body = Body(name: name)
        //var urlComponents = URLComponents()
        //urlComponents.queryItems = [URLQueryItem(name: "name", value: "")]
        //Creo la REQUEST
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = try? JSONEncoder().encode(body)
        
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
            
    
    //MARK: GET LOCALIZATIONS
    func getLocalizacionHeroes(id: String, completion: @escaping ([HeroCoordenates], Error?) -> Void) {
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
        urlRequest.httpBody = urlComponents.query?.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                completion([], NetworkError.unknown)
                return
            }
            
            guard let data = data else {
                completion([], NetworkError.noData)
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

//MARK: - EXTENSION -
private extension NetworkModel {
    func performAuthenticationNetworkRequest<R: Decodable, B: Encodable>(
        _ urlString: String,
        httpMethod: HTTPMethod,
        httpBody: B?,
        requestToken: String,
        completion: @escaping(Result<R, NetworkError>) -> Void
    ) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.malformedURL))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.setValue("Beares \(requestToken)", forHTTPHeaderField: "Authorization")
        
        if let httpBody {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try? JSONEncoder().encode(httpBody)
        }
        
        //MARK: Creamos el DATATASK que usa este REQUEST
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                completion(.failure(.other))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
    
                return
            }
                        
            guard let response = try? JSONDecoder().decode(R.self, from: data) else {
                completion(.failure(.decoding))
    
                return
            }
            completion(.success(response))
            
        }
        
        task.resume()
        
        
        
    }
}


