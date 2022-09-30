//
//  CoreDataManager.swift
//  PracticaFundamentosiOS
//
//  Created by Roberto Rojo Sahuquillo on 26/9/22.
//

import Foundation
import CoreData

final class CoreDataManager {
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DBZ")
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return container
    }()
    
    static let shared = CoreDataManager()
    
    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    func saveContext() {
        context.saveContext()
    }
    
    func fetchHeroes() -> [CDHero] {
        let request = CDHero.createFetchRequest()
        
        do {
            let result = try context.fetch(request)
            return result
        } catch {
            print("Error getting heroes")
        }
        
        return []
    }
    
    func fetchHero(id heroId: String) -> CDHero? {
        let request = CDHero.createFetchRequest()
        let predicate = NSPredicate(format:"id == %@", heroId)
        request.predicate = predicate
        request.fetchBatchSize = 1
        
        do {
            let result = try context.fetch(request)
            return result.first
        } catch {
            print("Error getting heroes")
        }
        
        return nil
    }

    func fetchTransformations(for heroId: String) -> [CDTransformation] {
        let fetchRequest = CDTransformation.createFetchRequest()
        let predicate = NSPredicate(format: "hero.id == %@", heroId)
        let sort = NSSortDescriptor(key: "name", ascending: true, selector: #selector(NSString.localizedStandardCompare))
        fetchRequest.sortDescriptors = [sort]
        fetchRequest.predicate = predicate
        
        do {
            let result = try context.fetch(fetchRequest)
            return result
        } catch {
            print("El error obteniendo Transformations \(error)")
        }
        return []
    }
    
    func fetchLocations(for heroId: String) -> [CDLocation] {
        let fetchRequest = CDLocation.createFetchRequest()
        let predicate = NSPredicate(format: "hero.id == %@", heroId)
        let sort = NSSortDescriptor(key: "name", ascending: true, selector: #selector(NSString.localizedStandardCompare))
        fetchRequest.sortDescriptors = [sort]
        fetchRequest.predicate = predicate
        
        do {
            let result = try context.fetch(fetchRequest)
            return result
        } catch {
            print("El error obteniendo Locations \(error)")
        }
        return []
    }

    
    func deleteAll() {
        let cdHeros = fetchHeroes()
        cdHeros.forEach { context.delete($0)}
        saveContext()
    }
    
    
}

extension NSManagedObjectContext {
    func saveContext() {
        //Check if there are changes
        guard hasChanges else { return }
        do {
            try save()
        } catch {
            fatalError("error: \(error.localizedDescription)")
        }
    }
}
