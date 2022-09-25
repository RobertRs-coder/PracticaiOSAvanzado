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
    let server = "https://vapor2022.herokuapp.com/api"
    let urlSession: URLSession
    var token: String?
    
    init(urlSession: URLSession = .shared, token: String? = nil) {
        self.token = token
        self.urlSession = urlSession
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
        
        let task = urlSession.dataTask(with: urlRequest) { data, response, error in
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
        
        let task = urlSession.dataTask(with: urlRequest) { data, response, error in
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
    
    func getTransformations(id: String, completion: @escaping ([Transformation], NetworkError?) -> Void) {
        guard let url = URL(string: "\(server)/heros/tranformations") else {
            completion([], .malformedURL)
            return
        }
        guard let token = self.token else {
            completion([], .otherError)
            return
            
        }

        //urlRequet body with urlComponents
        var urlComponents = URLComponents()
        urlComponents.queryItems = [URLQueryItem(name: "id", value: id)]

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.httpBody = urlComponents.query?.data(using: .utf8)
        
        let task = urlSession.dataTask(with: urlRequest) { data, response, error in
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
        requesToken: String,
    completion: @escaping (Result<R, NetworkError>) -> Void
    ){
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.malformedURL))
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        if let httpBody {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try? JSONEncoder().encode(httpBody)
        }
        
        
    }







    func getDataApi<T: Decodable>(id: String, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {

        guard let url = URL(string: "\(server)/heros/tranformations") else {
            completion(.failure(NetworkError.malformedURL))
            return
        }

        guard let token = self.token else {
            completion(.failure(NetworkError.otherError))
            return
        }

        let session = URLSession.shared
        
        var urlComponents = URLComponents()
        urlComponents.queryItems = [URLQueryItem(name: "id", value: id)]
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.httpBody = urlComponents.query?.data(using: .utf8)

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

            guard let response = try? JSONDecoder().decode(T.self, from: data) else {
                completion(.failure(NetworkError.decodingError))
                return
            }
            completion(.success(response))
        }
        task.resume()
    }

}
