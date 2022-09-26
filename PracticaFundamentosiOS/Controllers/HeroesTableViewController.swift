//
//  TableViewController.swift
//  PracticaFundamentosiOS
//
//  Created by Roberto Rojo Sahuquillo on 12/9/22.
//

import UIKit
import KeychainSwift

final class HeroesTableViewModel {
    private let networkModel: NetworkModel
    private var keychain: KeychainSwift
    
    private(set) var content: [Hero] = []
    
    var onError: ((String) -> Void)?
    var onSuccess: (() -> Void)?
    
    init(networkModel: NetworkModel = NetworkModel(),
         keychain: KeychainSwift = KeychainSwift(),
         onError: ((String) -> Void)? = nil,
         onSuccess: (() -> Void)? = nil) {
        self.networkModel = networkModel
        self.keychain = keychain
        self.onError = onError
        self.onSuccess = onSuccess
    }
    
    func viewDidLoad() {
        guard let token = keychain.get("KCToken") else { return }
        networkModel.token = token
        
        networkModel.getHeroes { [weak self] heroes, _ in
            self?.content = heroes
            self?.onSuccess?()
        }
    }
}

final class HeroesTableViewController: UITableViewController {
    
    let viewModel = HeroesTableViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Heroes"
        navigationController?.navigationBar.isHidden = false
        
        tableView.register(UINib(nibName: "TableViewCell",
                                 bundle: nil),
                           forCellReuseIdentifier: "cell")
        
        viewModel.onError = { message in
            print(message)
        }
            
        viewModel.onSuccess = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.viewDidLoad()
    }
    //Insert Cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        // Configure the cell
        cell.set(model: viewModel.content[indexPath.row])
        return cell
    }

    //Navigation
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextViewController = DetailViewController ()
  
        nextViewController.setHero(model: viewModel.content[indexPath.row])
        
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
        return viewModel.content.count
    }
}
