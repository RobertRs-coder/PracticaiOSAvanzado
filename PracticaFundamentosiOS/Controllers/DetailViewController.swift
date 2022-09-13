//
//  DetailViewController.swift
//  PracticaFundamentosiOS
//
//  Created by Roberto Rojo Sahuquillo on 12/9/22.
//

import UIKit

class DetailViewController: UIViewController {

    //MARK: IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    //MARK: Variables
    private var hero: Hero?
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let hero = hero else {
            return
        }
        
        self.nameLabel.text = hero.name
        self.descriptionTextView.text = hero.description
        self.imageView.setImage(url: hero.photo)
    }
    
    func set(model: Hero) {
        hero = model
    }
}
