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
}

class NetworkModel {
    let server = "https://vapor2022.herokuapp.com"
    func login(user: String, password: String, completion: @escaping (String?, Error?) -> Void) {
        guard let url = URL(string: "\(server)/api/auth/login") else {
            completion(nil, NetworkError.malformedURL)
            return
        }
        
        let loginString = String(format: "%@:%@", user, password)
        guard let loginData = loginString.data(using: .utf8) else {
            completion(nil, NetworkError.dataFormat)
            return
        }
        
        let base64LoginString = loginData.base64EncodedString()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        
    }
}
