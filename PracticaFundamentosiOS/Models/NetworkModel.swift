//
//  NetworkModel.swift
//  PracticaFundamentosiOS
//
//  Created by Roberto Rojo Sahuquillo on 12/9/22.
//

import Foundation

enum NetworkError: Error {
    case malformedURL
    case dataFormat
    case otherError
    case noData
    case errorCode(Int?)
    case tokenFormatError
    case decodingError
}

class NetworkModel {
    let server = "https://vapor2022.herokuapp.com/api"
    var token: String?
    
    init(token: String? = nil) {
        self.token = token
    }
    
    
    func login(user: String, password: String, completion: @escaping (String?, NetworkError?) -> Void) {
        guard let url = URL(string: "\(server)/auth/login") else {
            completion(nil, .malformedURL)
            return
        }
        
        let loginString = String(format: "%@:%@", user, password)
        guard let loginData = loginString.data(using: .utf8) else {
            completion(nil, .dataFormat)
            return
        }
        
        let base64LoginString = loginData.base64EncodedString()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                completion(nil, .otherError)
                return
            }
            
            guard let data = data else {
                completion(nil, .noData)
                return
            }
            
            guard let httpResponse = (response as? HTTPURLResponse),
                  httpResponse.statusCode == 200 else {
                completion(nil, .errorCode((response as? HTTPURLResponse)?.statusCode ))
                return
            }
            
            guard let token = String(data: data, encoding: .utf8) else {
                completion(nil, .tokenFormatError)
                return
            }
            
            completion(token, nil)
        }
        task.resume()
    }
    
    func getHeroes(name: String = "", completion: @escaping ([Hero], NetworkError?) -> Void) {
        guard let url = URL(string: "\(server)/heros/all") else {
            completion([], .malformedURL)
            return
        }
        guard let token = self.token else {
            completion([], .otherError)
            return
            
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        struct Body: Encodable {
            let name: String
        }
        let body = Body(name: name)
        
        urlRequest.httpBody = try? JSONEncoder().encode(body)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                completion([], .otherError)
                return
            }
            
            guard let data = data else {
                completion([], .noData)
                return
            }
            
            guard let httpResponse = (response as? HTTPURLResponse),
                  httpResponse.statusCode == 200 else {
                completion([], .errorCode((response as? HTTPURLResponse)?.statusCode ))
                return
            }
            
            guard let heroesResponse = try? JSONDecoder().decode([Hero].self, from: data) else {
                completion([], .decodingError)
                return
            }
            
            completion(heroesResponse, nil)
        }
        task.resume()
        
    }
    
    func getTransformations(heroId: String, completion: @escaping ([Transformation], NetworkError?) -> Void) {
        guard let url = URL(string: "\(server)/api/heros/tranformations") else {
            completion([], .malformedURL)
            return
        }
        guard let token = self.token else {
            completion([], .otherError)
            return
            
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        struct Body: Encodable {
            let id: String
        }
        let body = Body(id: heroId)
        
        urlRequest.httpBody = try? JSONEncoder().encode(body)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                completion([], .otherError)
                return
            }
            
            guard let data = data else {
                completion([], .noData)
                return
            }
            
            guard let httpResponse = (response as? HTTPURLResponse),
                  httpResponse.statusCode == 200 else {
                completion([], .errorCode((response as? HTTPURLResponse)?.statusCode ))
                return
            }
            
            guard let transformationsResponse = try? JSONDecoder().decode([Transformation].self, from: data) else {
                completion([], .decodingError)
                return
            }
            
            completion(transformationsResponse, nil)
        }
        task.resume()
        
    }
    
    //?No es posible hacerlo generico
    
    //    func getFromApi<T: Codable> (id: String, completion: @escaping ([T], NetworkError?) -> Void) {
    //        guard let url = URL(string: "\(server)/api/heros/tranformations") else {
    //            completion([], .malformedURL)
    //            return
    //        }
    //        guard let token = self.token else {
    //            completion([], .otherError)
    //            return
    //
    //        }
    //        var urlRequest = URLRequest(url: url)
    //        urlRequest.httpMethod = "POST"
    //        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    //        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
    //
    //        struct Body: Encodable {
    //            let id: String
    //        }
    //        let body = Body(id: id)
    //
    //        urlRequest.httpBody = try? JSONEncoder().encode(body)
    //
    //        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
    //            guard error == nil else {
    //                completion([], .otherError)
    //                return
    //            }
    //
    //            guard let data = data else {
    //                completion([], .noData)
    //                return
    //            }
    //
    //            guard let httpResponse = (response as? HTTPURLResponse),
    //                  httpResponse.statusCode == 200 else {
    //                completion([], .errorCode((response as? HTTPURLResponse)?.statusCode ))
    //                return
    //            }
    //
    //            guard let response = try? JSONDecoder().decode([Transformation].self, from: data) else {
    //                completion([], .decodingError)
    //                return
    //            }
    //
    //            completion(response, nil)
    //        }
    //        task.resume()
    //
    //        }
}
