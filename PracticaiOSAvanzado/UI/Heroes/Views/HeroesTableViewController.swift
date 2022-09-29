//
//  TableViewController.swift
//  PracticaFundamentosiOS
//
//  Created by Roberto Rojo Sahuquillo on 12/9/22.
//

import UIKit
import KeychainSwift

final class HeroesTableViewController: UITableViewController {
    var hero: Hero?
    var heroes: [Hero] = []
    //you’re telling the search controller that you want to use the same view you’re searching to display the results.
    let searchController = UISearchController(searchResultsController: nil)
    var filteredHeroes: [Hero] = []
    
    let viewModel = HeroesTableViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Heroes"
        navigationController?.navigationBar.isHidden = false
        
        tableView.register(UINib(nibName: "TableViewCell",
                                 bundle: nil),
                           forCellReuseIdentifier: "cell")
        
        // 1 searchResultsUpdater is a property on UISearchController that conforms to the new protocol, UISearchResultsUpdating. With this protocol, UISearchResultsUpdating will inform your class of any text changes within the UISearchBar.
        searchController.searchResultsUpdater = self
        // 2 By default, UISearchController obscures the view controller containing the information you’re searching. This is useful if you’re using another view controller for your searchResultsController. In this instance, you’ve set the current view to show the results, so you don’t want to obscure your view.
        searchController.obscuresBackgroundDuringPresentation = false
        // 3 Here, you set the placeholder to something that’s specific to this app.
        searchController.searchBar.placeholder = "Search heroes"
        // 4 New for iOS 11, you add the searchBar to the navigationItem. This is necessary because Interface Builder is not yet compatible with UISearchController.
        navigationItem.searchController = searchController
        // 5 Finally, by setting definesPresentationContext on your view controller to true, you ensure that the search bar doesn’t remain on the screen if the user navigates to another view controller while the UISearchController is active.
        definesPresentationContext = true
        
        
        viewModel.onError = { message in
            print(message)
        }
        
        viewModel.onSuccess = { [weak self] in
            DispatchQueue.main.async {
                self?.heroes = self?.viewModel.content ?? []
                self?.tableView.reloadData()
            }
        }
        
        viewModel.viewDidLoad()
    }
    
    //MARK: Navigation
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextViewController = DetailViewController()
        
        if isFiltering {
            hero = filteredHeroes[indexPath.row]
        } else {
            hero = heroes[indexPath.row]
        }
        
        guard let hero = hero else { return }
        
        nextViewController.setHero(model: hero)
        
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    
    //MARK: SearchBAr Configuration
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!isSearchBarEmpty || searchBarScopeIsFiltering)
    }
    
    func filterContentForSearchText(_ searchText: String,
                                    name: String? = nil) {
        filteredHeroes = heroes.filter { (hero: Hero) -> Bool in
            return hero.name.lowercased().contains(searchText.lowercased())
        }
            
        tableView.reloadData()
    }
    
    //MARK: Cell animations
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
        if isFiltering {
            return filteredHeroes.count
        }
        return heroes.count
    }
    
    //MARK: Cell configuration
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        
        if isFiltering {
            hero = filteredHeroes[indexPath.row]
        } else {
            hero = heroes[indexPath.row]
        }
        
        // Configure the cell
        cell.set(model: hero!)
        return cell
    }
}


// This protocol defines methods to update search results based on information the user enters into the search bar
extension HeroesTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        // TODO
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
        
    }
}
