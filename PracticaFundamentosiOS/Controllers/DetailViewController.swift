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
    @IBOutlet weak var transformationsButton: UIButton!
    
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
        self.hero = model
    }
    
    @IBAction func onTransformationTap(_ sender: UIButton) {
        guard let hero = hero else {
            return
        }
        
        //Now that we have the transformations at this point, we could pass the transformations array here
        let nextVC = TransformationsTableViewController()
        nextVC.set(model: hero)
        navigationController?.pushViewController(nextVC, animated: true)
    }
}
