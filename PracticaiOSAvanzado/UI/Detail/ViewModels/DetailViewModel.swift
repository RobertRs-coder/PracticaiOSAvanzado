//
//  DetailViewModel.swift
//  PracticaFundamentosiOS
//
//  Created by Roberto Rojo Sahuquillo on 27/9/22.
//

import Foundation
import KeychainSwift


final class DetailViewModel {
    
    private (set) var content: [Transformation]?
    var hero: Hero?
    private var coreDataManager: CoreDataManager
    var onSuccess: (() -> Void)?
    
    init(hero: Hero? = nil,
         content: [Transformation]? = nil,
         coreDataManager: CoreDataManager = .shared,
         onSuccess: ( () -> Void)? = nil) {
        self.hero = hero
        self.content = content
        self.coreDataManager = coreDataManager
        self.onSuccess = onSuccess
    }
        
    func loadTransformations() {
        
        guard let hero = hero else { return }
        let cdTransformations = coreDataManager.fetchTransformations(for: hero.id)
        
        print("Transformations from CD")
        
        content = cdTransformations.map { $0.transformation }
            .sorted {
                $0.name.localizedStandardCompare($1.name) == .orderedAscending
            }
        onSuccess?()
    }
        
    func viewDidLoad() {
        loadTransformations()
    }
}
