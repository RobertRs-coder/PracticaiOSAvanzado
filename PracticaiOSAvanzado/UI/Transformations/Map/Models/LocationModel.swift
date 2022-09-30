//
//  LocationModel.swift
//  PracticaiOSAvanzado
//
//  Created by Roberto Rojo Sahuquillo on 30/9/22.
//

import Foundation


struct Location: Decodable {
    let id: String
    let latitud: Double
    let longitud: Double 
}
