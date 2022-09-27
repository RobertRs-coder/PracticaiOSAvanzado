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

final class LocalDataModel {
    
    private static let userDefaults = UserDefaults.standard
    
    static func getSyncDate() -> Date? {
        userDefaults.object(forKey: "KCLastSyncDate") as? Date
    }
    
    static func saveSyncDate() {
        userDefaults.set(Date(), forKey: "KCLastSyncDate")
    }
    
    static func getToken() -> String? {
        userDefaults.string(forKey: Constant.tokenKey)
    }
    
    static func saveToken(token: String) {
        userDefaults.set(token, forKey: Constant.tokenKey)
    }
    
    static func deleteToken() {
        userDefaults.removeObject(forKey: Constant.tokenKey)
    }
}
