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
    
    func fecthHeroes() -> [CDHero] {
        let request = CDHero.createFetchRequest()
        
        do {
            let result = try context.fetch(request)
            return result
        } catch {
            print("Error getting heroes")
        }
        
        return []
    }
    
    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    func saveContext() {
        context.saveContext()
    }
    
    func deleteAll() {
        //Delete objects
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
