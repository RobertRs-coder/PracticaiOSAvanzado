//
//  TableViewCell.swift
//  PracticaFundamentosiOS
//
//  Created by Roberto Rojo Sahuquillo on 12/9/22.
//

import UIKit

protocol TableViewDisplayable {
  var photo: URL { get }
  var id: String { get }
  var name: String { get }
  var description: String { get }
}

final class TableViewCell: UITableViewCell {

    //MARK: IBOutlets
    @IBOutlet weak var heroName: UILabel!
    @IBOutlet weak var heroDescription: UILabel!
    @IBOutlet weak var heroImage: UIImageView!
    
    func set(model: TableViewDisplayable) {
        self.heroName.text = model.name
        self.heroDescription.text = model.description
        self.heroImage.setImage(url: model.photo)
    }
}
