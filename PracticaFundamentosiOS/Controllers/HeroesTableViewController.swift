//
//  TableViewController.swift
//  PracticaFundamentosiOS
//
//  Created by Roberto Rojo Sahuquillo on 12/9/22.
//

import UIKit

class HeroesTableViewController: UITableViewController {
    
    //MARK: Constants
    let heroes: [Hero] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Heroes"
        navigationController?.navigationBar.isHidden = false
        
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
     
    }
    
    //Insert Cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        
        // Configure the cell
        cell.heroName.text = "IndexPath: \(indexPath)"
        
        return cell
    }

    //Navigation
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let nextViewController = DetailViewController ()
  
        
        navigationController?.pushViewController(nextViewController, animated: true)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return heroes.count
    }
    
}
