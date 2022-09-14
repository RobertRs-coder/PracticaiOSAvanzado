//
//  TransformationsTableViewController.swift
//  PracticaFundamentosiOS
//
//  Created by Roberto Rojo Sahuquillo on 14/9/22.
//

import UIKit

final class TransformationsTableViewController: UITableViewController {
    
    private var transformations: [Transformation] = []
    
    private var hero: Hero?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.register(
            UINib(nibName: "TableViewCell", bundle: nil),
            forCellReuseIdentifier: "cell"
        )
        guard let hero = hero, let token = LocalDataModel.getToken() else { return }
        
        let networkModel = NetworkModel(token: token)
        
        networkModel.getTransformations(heroId: hero.id, completion: { [weak self] transformations, error in
            self?.transformations = transformations.sorted {
                $0.name.localizedStandardCompare($1.name) == .orderedAscending
            }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        })
    }
    
    func set(model: Hero) {
        self.hero = model
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
