//
//  LoginViewModel.swift
//  PracticaFundamentosiOS
//
//  Created by Roberto Rojo Sahuquillo on 27/9/22.
//

import Foundation
import KeychainSwift

final class LoginViewModel {
    private let networkModel: NetworkModel
    private var keychain: KeychainSwift
    
    var onError: ((String) -> Void)?
    var onLogin: (() -> Void)?
    
    init(network: NetworkModel = NetworkModel(),
         keychain: KeychainSwift = KeychainSwift(),
         onError: ((String) -> Void)? = nil,
         onLogin: (() -> Void)? = nil) {
        self.networkModel = network
        self.keychain = keychain
        self.onError = onError
        self.onLogin = onLogin
    }
    
    func login(with user: String, password: String) {
        networkModel.login(user: user, password: password) { [weak self] token, error in
            
            if error != nil {
                self?.onError?(error?.localizedDescription ?? "Error")
            }
            
            guard let token = token, !token.isEmpty else {
                self?.onError?("Wrong token")
                return
            }
            self?.keychain.set(token, forKey: "KCToken")
            self?.onLogin?()
        }
    }
}
