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
        )
        
    }
    
    func set(model: [Transformation]) {
        self.transformations = model
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
    
    
    //Navigation
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextViewController = DetailViewController ()
        
        nextViewController.setTransformation(model: transformations[indexPath.row])
        
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.center.x += 50
        UIView.animate(withDuration: 0.5) {
            cell.center.x -= 50
        }
    }
}

// MARK: - Table view data source
    
extension TransformationsTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transformations.count
    }
}
