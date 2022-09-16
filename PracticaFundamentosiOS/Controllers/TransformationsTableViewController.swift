//
//  TransformationsTableViewController.swift
//  PracticaFundamentosiOS
//
//  Created by Roberto Rojo Sahuquillo on 14/9/22.
//

import UIKit

final class TransformationsTableViewController: UITableViewController {
    

    private var transformations: [Transformation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Transformations"

        tableView?.register(
            UINib(nibName: "TableViewCell", bundle: nil),
            forCellReuseIdentifier: "cell"
            
            
                
//            guard let transformations = transformations else { return }
            
            
        )
        
//        guard let hero = hero, let token = LocalDataModel.getToken() else { return }
//
//        let networkModel = NetworkModel(token: token)
//
//        networkModel.getDataApi(id: hero.id, type: [Transformation].self, completion: { result in
//
//            switch result {
//
//            case .success(let data):
//
//                self.transformations = data.sorted {
//                    $0.name.localizedStandardCompare($1.name) == .orderedAscending
//                }
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//
//            case .failure(let error):
//                print("There is an error: \(error)")
//                break
//
//            }
//        })
        
        
//        networkModel.getTransformations(hero: hero, completion: { [weak self] transformations, error in
//            self?.transformations = transformations.sorted {
//                $0.name.localizedStandardCompare($1.name) == .orderedAscending
//            }
//            DispatchQueue.main.async {
//                self?.tableView.reloadData()
//            }
//        })
    }
    
    func set(model: [Transformation]) {
        self.transformations = model
    }
    
    
    //Navigation
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextViewController = DetailViewController ()
  
        nextViewController.setTransformation(model: transformations[indexPath.row])
        
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transformations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell else {
            let cell = UITableViewCell()
            cell.textLabel?.text = "no content"
            return cell
        }
        
        cell.set(model: transformations[indexPath.row])
        
        return cell
    }
}
