//
//  NetworkModel.swift
//  PracticaFundamentosiOS
//
//  Created by Roberto Rojo Sahuquillo on 12/9/22.
//

import Foundation

enum NetworkError: Error, Equatable {
    case malformedURL
    case dataFormat
    case otherError
    case noData
    case errorCode(Int?)
    case tokenFormatError
    case decodingError
    case httpResponse
}

class NetworkModel {
//    let server = "https://vapor2022.herokuapp.com/api"
    let server = "https://dragonball.keepcoding.education/api"
    let session: URLSession
    var token: String?
    
    init(urlSession: URLSession = .shared, token: String? = nil) {
        self.token = token
        self.session = urlSession
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
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
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
        
        let urlString = "\(server)/heros/all"
        
        struct Body: Encodable {
            let name: String
        }
        
        guard let token else {
            fatalError("No token")
        }
        
        performAuthenticatedNetworkRequest(urlString,
                                           httpMethod: .post,
                                           httpBody: Body(name: ""),
                                           requestToken: token) { (result: Result<[Hero], NetworkError>)  in
            switch result {
            case .success(let success):
                completion(success, nil)
            case .failure(let failure):
                completion([], failure)
            }
        }
    }
    
    func getTransformations(id: String, completion: @escaping ([Transformation], NetworkError?) -> Void) {
        
        let urlString = "\(server)/heros/tranformations"
        
        struct Body: Encodable {
            let  id: String
        }
        
        guard let token else {
            fatalError("No token")
        }
        
        performAuthenticatedNetworkRequest(urlString,
                                           httpMethod: .post,
                                           httpBody: Body(id: id),
                                           requestToken: token) { (result: Result<[Transformation], NetworkError>)  in
            switch result {
            case .success(let success):
                completion(success, nil)
            case .failure(let failure):
                completion([], failure)
            }
        }
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

private extension NetworkModel {
    
    func performAuthenticatedNetworkRequest<R: Decodable, B: Encodable>(
        _ urlString: String,
        httpMethod: HTTPMethod,
        httpBody: B?,
        requestToken: String,
    completion: @escaping (Result<R, NetworkError>) -> Void){
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.malformedURL))
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.setValue("Bearer \(String(describing: requestToken))", forHTTPHeaderField: "Authorization")
        
        if let httpBody {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try? JSONEncoder().encode(httpBody)
        }

        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                completion(.failure(NetworkError.malformedURL))
                return
            }

            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }

            guard let httpResponse = (response as? HTTPURLResponse),
                  httpResponse.statusCode == 200 else {
                completion(.failure(NetworkError.httpResponse))
                return
            }

            guard let response = try? JSONDecoder().decode(R.self, from: data) else {
                completion(.failure(NetworkError.decodingError))
                return
            }
            completion(.success(response))
        }
        task.resume()
    }
}
