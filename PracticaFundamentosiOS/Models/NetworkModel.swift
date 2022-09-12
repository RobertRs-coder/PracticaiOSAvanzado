//
//  NetworkModel.swift
//  PracticaFundamentosiOS
//
//  Created by Roberto Rojo Sahuquillo on 12/9/22.
//

import Foundation

enum NetworkError: Error {
    case malformedURL
}

class NetworkModel {
    let server = "https://vapor2022.herokuapp.com"
    func login(user: String, pasword: String, completion: @escaping (String?, Error?) -> Void) {
        guard let url = URL(string: "\(server)/api/auth/login") else {
            completion(nil, NetworkError.malformedURL)
            return
        }
        
        
    }
}
