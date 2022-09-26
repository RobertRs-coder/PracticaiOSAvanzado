//
//  TableViewController.swift
//  PracticaFundamentosiOS
//
//  Created by Roberto Rojo Sahuquillo on 12/9/22.
//

import UIKit
import KeychainSwift

class HeroesTableViewController: UITableViewController {
    
    //MARK: Constants
    var heroes: [Hero] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Heroes"
        navigationController?.navigationBar.isHidden = false
        
        tableView.register(UINib(nibName: "TableViewCell",
                                 bundle: nil),
                           forCellReuseIdentifier: "cell")
        
        guard let token = KeychainSwift().get("KCToken") else { return }
        //Network call
        let networkModel =  NetworkModel(token: token)
        
        networkModel.getHeroes { [weak self] heroes, _ in
            
            self?.heroes = heroes
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
//        KeychainSwift().delete("KCToken")
    }
    
    //Insert Cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        
        // Configure the cell
        cell.set(model: heroes[indexPath.row])
        
        return cell
    }

    //Navigation
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextViewController = DetailViewController ()
  
        nextViewController.setHero(model: heroes[indexPath.row])
        
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    //Cell animations
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
      cell.center.x += 50
      UIView.animate(withDuration: 0.5) {
        cell.center.x -= 50
      }
    }    
}



// MARK: - Table view data source

extension HeroesTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return heroes.count
    }
}
