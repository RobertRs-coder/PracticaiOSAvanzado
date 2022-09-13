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
    private static let userDefaults = UserDefaults.standard
    
    static func getToken() -> String? {
        userDefaults.string(forKey: Constant.tokenKey)
    }
    
    static func saveToken(token: String) {
        userDefaults.set(token, forKey: Constant.tokenKey)
    }
}
