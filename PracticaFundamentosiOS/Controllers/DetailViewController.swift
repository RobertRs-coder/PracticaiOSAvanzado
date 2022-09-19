//
//  DetailViewController.swift
//  PracticaFundamentosiOS
//
//  Created by Roberto Rojo Sahuquillo on 12/9/22.
//

import UIKit

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
    
    private var transformations: [Transformation]? = []
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.transformationsButton.isHidden = true
        
        if DragonBall.character == "hero" {
            
            guard let hero = hero else { return }
            
            self.nameLabel.text = hero.name
            self.descriptionTextView.text = hero.description
            self.imageView.setImage(url: hero.photo)
            
            guard let token = LocalDataModel.getToken() else { return }
            
            let networkModel = NetworkModel(token: token)
            networkModel.getDataApi(id: hero.id, type: [Transformation].self, completion: { [weak self] result in
                
                switch result {
                    
                case .success(let data):
                    //Main thread to get data ASAP at first time
                    DispatchQueue.main.sync {
                        self?.transformations = data
                        let transformationsCount = self?.transformations?.count
                        self?.transformationsButton.isHidden = transformationsCount == 0
                    }
                    
                    self?.transformations = self?.transformations?.sorted {
                        $0.name.localizedStandardCompare($1.name) == .orderedAscending
                    }
                    
                case .failure(let error):
                    print("There is an error: \(error)")
                    break
                }
            })
        } else {
            guard let transformation = transformation else { return }
            self.nameLabel.text = transformation.name
            self.descriptionTextView.text = transformation.description
            self.imageView.setImage(url: transformation.photo)
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
        guard let transformations = transformations else {
            return
        }
        //Now that we have the transformations at this point, we could pass the transformations array here
        let nextVC = TransformationsTableViewController()
        nextVC.set(model: transformations)
        navigationController?.pushViewController(nextVC, animated: true)
    }
}
