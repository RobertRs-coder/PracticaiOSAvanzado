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
    
    private var transformations: [Transformation]? = []
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let hero = hero else {
            return
        }
        
        self.nameLabel.text = hero.name
        self.descriptionTextView.text = hero.description
        self.imageView.setImage(url: hero.photo)
        
        
        guard let token = LocalDataModel.getToken() else { return }

        let networkModel = NetworkModel(token: token)


        networkModel.getDataApi(id: hero.id, type: [Transformation].self, completion: { result in
            
            switch result {
                
            case .success(let data):
                
                self.transformations = data.sorted {
                    $0.name.localizedStandardCompare($1.name) == .orderedAscending
                }
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
                
            case .failure(let error):
                print("There is an error: \(error)")
                break
                
            }
        })
    }
    
        
    
    
    
    func set(model: Hero) {
        self.hero = model
    }
    
    
    @IBAction func onTransformationTap(_ sender: UIButton) {
        guard let transformations = transformations else {
            return
        }
        
//        if transformations == []: {
//
//
//        }
                
        
        //Now that we have the transformations at this point, we could pass the transformations array here
        let nextVC = TransformationsTableViewController()
        nextVC.set(model: transformations)
        navigationController?.pushViewController(nextVC, animated: true)
    }
}
