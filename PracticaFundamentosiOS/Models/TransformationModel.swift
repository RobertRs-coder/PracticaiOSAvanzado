//
//  TransformationModel.swift
//  PracticaFundamentosiOS
//
//  Created by Roberto Rojo Sahuquillo on 14/9/22.
//

import UIKit

struct Transformation: TableViewDisplayable, Decodable {
    let photo: URL
    let id: String
    let name: String
    let description: String
}
