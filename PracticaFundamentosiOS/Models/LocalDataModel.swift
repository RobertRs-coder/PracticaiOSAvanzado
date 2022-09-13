//
//  LocalDataModel.swift
//  PracticaFundamentosiOS
//
//  Created by Roberto Rojo Sahuquillo on 13/9/22.
//

import Foundation


private enum Constant {
    static let tokenKey = "KCToken"
}

class LocalDataModel {
    private let userDefaults = UserDefaults.standard
    
    func getToken() -> String? {
        userDefaults.string(forKey: Constant.tokenKey)
    }
    
    func saveToken() {
        userDefaults.set(token, forKey: Constant.tokenKey)
    }
}
