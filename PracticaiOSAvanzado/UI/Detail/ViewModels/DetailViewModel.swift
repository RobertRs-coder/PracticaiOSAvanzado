//
//  DetailViewModel.swift
//  PracticaFundamentosiOS
//
//  Created by Roberto Rojo Sahuquillo on 27/9/22.
//

import Foundation
import KeychainSwift


final class DetailViewModel {
    
    private (set) var tranformationsContent: [Transformation]?
    private (set) var locationsContent: [Location]?
    var hero: Hero?
    private var coreDataManager: CoreDataManager
    var onSuccess: (() -> Void)?
    
    init(hero: Hero? = nil,
         tranformationsContent: [Transformation]? = nil,
         locationsContent: [Location]? = nil,
         coreDataManager: CoreDataManager = .shared,
         onSuccess: ( () -> Void)? = nil) {
        self.hero = hero
        self.tranformationsContent = tranformationsContent
        self.locationsContent = locationsContent
        self.coreDataManager = coreDataManager
        self.onSuccess = onSuccess
    }
        
    func loadTransformations() {
        
        guard let hero = hero else { return }
        let cdTransformations = coreDataManager.fetchTransformations(for: hero.id)
        
        print("Transformations from CD")
        
        tranformationsContent = cdTransformations.map { $0.transformation }
            .sorted {
                $0.name.localizedStandardCompare($1.name) == .orderedAscending
            }
        
    }
    
    func loadLocations() {
        guard let hero = hero else { return }
        let cdLocations = coreDataManager.fetchLocations(for: hero.id)
        
        print("Locations from CD")
        
        locationsContent = cdLocations.map { $0.location }
    }
        
    func viewDidLoad() {
        loadLocations()
        loadTransformations()
        onSuccess?()
    }
}
