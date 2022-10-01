//
//  HeroesTableViewModel.swift
//  PracticaFundamentosiOS
//
//  Created by Roberto Rojo Sahuquillo on 27/9/22.
//

import Foundation
import KeychainSwift

final class HeroesTableViewModel {
    private let networkModel: NetworkModel
    private var keychain: KeychainSwift
    private var coreDataManager: CoreDataManager
    
    private(set) var content: [Hero] = []
    
    var heroes: [Hero] = []
    
    var onError: ((String) -> Void)?
    var onSuccess: (() -> Void)?
    
    init(networkModel: NetworkModel = NetworkModel(),
         keychain: KeychainSwift = KeychainSwift(),
         coreDataManager: CoreDataManager = .shared,
         onError: ((String) -> Void)? = nil,
         onSuccess: (() -> Void)? = nil) {
        self.networkModel = networkModel
        self.keychain = keychain
        self.coreDataManager = coreDataManager
        self.onError = onError
        self.onSuccess = onSuccess
    }
    
    func viewDidLoad() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.loadHeroes()
        }
    }
    
    func loadHeroes() {
        let cdHeroes = coreDataManager.fetchHeroes()
        
        //Check date of the coreData
        guard let date = LocalDataModel.getSyncDate(),
              date.addingTimeInterval(1) > Date(),
              !cdHeroes.isEmpty else {
//            print("Heroes from networkCall")
            guard let token = keychain.get("KCToken") else { return }
            networkModel.token = token
            
            networkModel.getHeroes { [weak self] heroes, error in
                if let error = error {
                    self?.onError?("Heroes error\(error.localizedDescription)")
                }   else {
                    // Problem?¿

                   

//                    for (index, hero) in heroes.enumerated() {
//                        self?.networkModel.getLocationHeroes(id: hero.id) { [weak self] coordinateArray, error in
//                            if coordinateArray.count > 0 {
//                                let coordinate = coordinateArray.first
//                                self?.heroes[index].latitud = coordinate?.latitud
//                                self?.heroes[index].longitud = coordinate?.longitud
//                                
//                            }
//            
//                            //notification to finish getCoordinates?
////                                print(self?.heroes ?? [])
//                        }
//                    }
                    
                    self?.save(heroes: heroes)
    
                    
                    let group = DispatchGroup()
//
                    //Como podrias hacerlo asi todo junto 
//                    heroes.forEach { hero in
//                        group.enter()
//                        self?.downloadLocations(for: hero) {
//                            self?.downloadTransformations(for: hero) {
//                                group.leave()
//                            }
//                        }
//                    }
                    
                    heroes.forEach { hero in
                        group.enter()
                        self?.downloadLocations(for: hero) {
                            group.leave()
                        }
                    }


                    heroes.forEach { hero in
                        group.enter()
                        self?.downloadTransformations(for: hero) {
                            group.leave()
                        }
                    }
                    group.notify(queue: DispatchQueue.global()) {
                        LocalDataModel.saveSyncDate()
                        if let cdHeroes = self?.coreDataManager.fetchHeroes() {
                            self?.content = cdHeroes.map { $0.hero }
                        }
                        self?.onSuccess?()
                    }
                }
            }
            return
        }
        
        print("Heroes from Core Data")
        content = cdHeroes.map { $0.hero }
//        print(content)
        onSuccess?()
    }
    
    func downloadTransformations(for hero: Hero, completion: @escaping () -> Void) {
        let cdTransformations = coreDataManager.fetchTransformations(for: hero.id)
        if cdTransformations.isEmpty {
            print("Tranformtaions Network Call")
            guard let token = keychain.get("KCToken") else {
                completion()
                return
            }
            
            networkModel.token = token
            networkModel.getTransformations(id: hero.id) { [weak self] transformations, error in
                if let error {
                    self?.onError?("Error: \(error.localizedDescription)")
                } else {
                    print(transformations)
                    self?.save(transformations: transformations, for: hero)
                }
                completion()
            }
        } else {
            completion()
        }
    }
    
    func downloadLocations(for hero: Hero, completion: @escaping () -> Void) {
        let cdLocations = coreDataManager.fetchLocations(for: hero.id)
        if cdLocations.isEmpty {
            print("Locations Network Call")
            guard let token = keychain.get("KCToken") else {
                completion()
                return
            }
            
            networkModel.token = token
            networkModel.getLocations(id: hero.id) { [weak self] locations, error in
                if let error {
                    self?.onError?("Error: \(error.localizedDescription)")
                } else {
                    print(locations)
                    self?.save(locations: locations, for: hero)
                }
                completion()
            }
        } else {
            completion()
        }
    }
}

                                            
private extension HeroesTableViewModel {
    func save(heroes: [Hero]) {
        _ = heroes.map { CDHero.create(from: $0, context: coreDataManager.context) }
        coreDataManager.saveContext()
    }
    
    func save(transformations: [Transformation], for hero: Hero) {
        guard let cdHero = coreDataManager.fetchHero(id: hero.id) else { return }
        _ = transformations.map { CDTransformation.create(from: $0, for: cdHero, context: coreDataManager.context) }
        coreDataManager.saveContext()
    }
    
    func save(locations: [Location], for hero: Hero) {
        guard let cdHero = coreDataManager.fetchHero(id: hero.id) else { return }
        _ = locations.map { CDLocation.create(from: $0, for: cdHero, context: coreDataManager.context) }
        coreDataManager.saveContext()
    }
}
