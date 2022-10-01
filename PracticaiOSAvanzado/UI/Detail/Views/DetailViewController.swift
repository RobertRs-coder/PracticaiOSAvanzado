//
//  DetailViewController.swift
//  PracticaFundamentosiOS
//
//  Created by Roberto Rojo Sahuquillo on 12/9/22.
//

import UIKit

enum DragonBall {
    case hero
    case transformation
}

protocol DetailViewDisplayable {
  var photo: URL { get }
  var id: String { get }
  var name: String { get }
  var description: String { get }
}

final class DetailViewController: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var transformationsButton: UIButton!
    @IBOutlet weak var locationsButton: UIButton!
    
    //MARK: Variables
    private var hero: Hero?
    private var transformation: Transformation?
    //init enum
    var character: DragonBall = DragonBall.hero
    
    //MARK: Constants
    let viewModel = DetailViewModel()
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.transformationsButton.isHidden = true
        
        switch character {
            
            case .hero:
                guard let hero = hero else { return }

                self.nameLabel.text = hero.name
                self.descriptionTextView.text = hero.description
                self.imageView.setImage(url: hero.photo)
                viewModel.hero = hero
            
                viewModel.onSuccess = { [weak self] in
                    DispatchQueue.main.async {
                        let transformationsCount = self?.viewModel.tranformationsContent?.count
                        self?.transformationsButton.isHidden = transformationsCount == 0
                        
                        let locationsCount = self?.viewModel.locationsContent?.count
                        self?.locationsButton.isHidden = locationsCount == 0
                    }
                }
                viewModel.viewDidLoad()
                                    
            case .transformation:
                guard let transformation = transformation else { return }
                self.nameLabel.text = transformation.name
                self.descriptionTextView.text = transformation.description
                self.imageView.setImage(url: transformation.photo)
        }
    }
    
    func setHero(model: DetailViewDisplayable) {
        
        self.hero = model as? Hero
        self.character = .hero
    }
    
    func setTransformation(model: DetailViewDisplayable) {
        
        self.transformation = model as? Transformation
        self.character = .transformation
    }

    @IBAction func onTransformationTap(_ sender: UIButton) {
        guard let transformations = viewModel.tranformationsContent else {
            return
        }
        //Now that we have the transformations at this point, we could pass the transformations array here
        let nextVC = TransformationsTableViewController()
        nextVC.set(model: transformations)
        navigationController?.pushViewController(nextVC, animated: true)
    }
    @IBAction func onLocationsTap(_ sender: Any) {
        guard let locations = viewModel.locationsContent else {
            return
        }
        let nextVC = MapViewController()
        nextVC.set(model: locations)
        navigationController?.pushViewController(nextVC, animated: true)
    }
}
