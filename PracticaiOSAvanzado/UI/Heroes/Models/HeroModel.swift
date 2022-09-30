//
//  HeroModel.swift
//  PracticaFundamentosiOS
//
//  Created by Roberto Rojo Sahuquillo on 12/9/22.
//

import UIKit

struct Hero: TableViewDisplayable, DetailViewDisplayable,  Decodable {
    let id: String
    let name: String
    let description: String
    let photo: URL
    let favorite: Bool
    var latitud: Double?
    var longitud: Double?
}
