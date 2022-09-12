//
//  HeroModel.swift
//  PracticaFundamentosiOS
//
//  Created by Roberto Rojo Sahuquillo on 12/9/22.
//

import UIKit

struct Hero: Decodable {
    let id: String
    let name: String
    let description: String
    let phot: URL
    let favorite: Bool
}
