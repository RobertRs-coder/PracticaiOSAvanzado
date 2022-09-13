//
//  TableViewCell.swift
//  PracticaFundamentosiOS
//
//  Created by Roberto Rojo Sahuquillo on 12/9/22.
//

import UIKit

class TableViewCell: UITableViewCell {

    //MARK: IBOutlets
    @IBOutlet weak var heroName: UILabel!
    @IBOutlet weak var heroDescription: UILabel!
    @IBOutlet weak var heroImage: UIImageView!
    
    func set(model: Hero) {
        
        self.heroName.text = model.name
        self.heroDescription.text = model.description
        self.heroImage.setImage(url: model.photo)
    }
}
