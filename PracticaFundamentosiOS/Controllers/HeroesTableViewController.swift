//
//  TableViewController.swift
//  PracticaFundamentosiOS
//
//  Created by Roberto Rojo Sahuquillo on 12/9/22.
//

import UIKit

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
        
        //Network call
        let networkModel =  NetworkModel.shared
        
        networkModel.getHeroes { heroes, _ in
            self.heroes = heroes
            tableView.reloadData()
        }
     
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
        let hero = Hero(id: "1985A353-157F-4C0B-A789-FD5B4F8DABDB",
                        name: "Mr. Satán",
                        description: "Mr. Satán es un charlatán fanfarrón, capaz de manipular a las masas. Pero en realidad es cobarde cuando se da cuenta que no puede contra su adversario como ocurrió con Androide 18 o Célula. Siempre habla más de la cuenta, pero en algún momento del combate empieza a suplicar. Androide 18 le ayuda a fingir su victoria a cambio de mucho dinero. Él acepta el trato porque no podría soportar que todo el mundo le diera la espalda por ser un fraude.",
                        photo: URL(string: "https://cdn.alfabetajuega.com/alfabetajuega/2020/06/dragon-ball-satan.jpg?width=300")!,
                        favorite: false)
        let nextViewController = DetailViewController ()
  
        nextViewController.set(model: hero)
        
        navigationController?.pushViewController(nextViewController, animated: true)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5 //heroes.count
    }
    
}
