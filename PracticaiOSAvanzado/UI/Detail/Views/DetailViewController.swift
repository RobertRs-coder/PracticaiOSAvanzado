//
//  DetailViewController.swift
//  PracticaFundamentosiOS
//
//  Created by Roberto Rojo Sahuquillo on 12/9/22.
//

import UIKit
import KeychainSwift

private enum DragonBall {
    static var character = ""
}

protocol DetailViewDisplayable {
  var photo: URL { get }
  var id: String { get }
  var name: String { get }
  var description: String { get }
}

class DetailViewController: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var transformationsButton: UIButton!
    
    //MARK: Variables
    private var hero: Hero?
    private var transformation: Transformation?
    
    private var transformations: [Transformation] = []
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.transformationsButton.isHidden = true
        
        
        switch DragonBall.character {
            
        case "hero":
            guard let hero = hero else { return }

            self.nameLabel.text = hero.name
            self.descriptionTextView.text = hero.description
            self.imageView.setImage(url: hero.photo)
            
            let cdTransformations = CoreDataManager.shared.fetchTransformations(for: hero.id)
            
            print("Transformations from CD")
            transformations = cdTransformations.map { $0.transformation }
                .sorted {
                    $0.name.localizedStandardCompare($1.name) == .orderedAscending
                }
//            let transformationsCount = transformations?.count
            DispatchQueue.main.async {
                let transformationsCount = self.transformations.count
                self.transformationsButton.isHidden = transformationsCount == 0
            }
                                
        case "transformation":
            guard let transformation = transformation else { return }
            self.nameLabel.text = transformation.name
            self.descriptionTextView.text = transformation.description
            self.imageView.setImage(url: transformation.photo)
            
        default:
            break
        }
    }
    
    func setHero(model: DetailViewDisplayable) {
        
        self.hero = model as? Hero
        DragonBall.character = "hero"
    }
    
    func setTransformation(model: DetailViewDisplayable) {
        
        self.transformation = model as? Transformation
        DragonBall.character = "transformation"
    }

    @IBAction func onTransformationTap(_ sender: UIButton) {
//        guard let transformations = content else {
//            return
//        }
        //Now that we have the transformations at this point, we could pass the transformations array here
        let nextVC = TransformationsTableViewController()
        nextVC.set(model: self.transformations)
        navigationController?.pushViewController(nextVC, animated: true)
    }
}
