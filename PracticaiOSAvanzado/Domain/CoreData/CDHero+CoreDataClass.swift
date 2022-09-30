//
//  CDHero+CoreDataClass.swift
//  PracticaiOSAvanzado
//
//  Created by Roberto Rojo Sahuquillo on 30/9/22.
//
//

import Foundation
import CoreData

@objc(CDHero)
public class CDHero: NSManagedObject {

}

extension CDHero {
    static func create(from hero: Hero, context: NSManagedObjectContext) -> CDHero {
        
        let cdHero = CDHero(context: context)
        
        cdHero.id = hero.id
        cdHero.name = hero.name
        cdHero.favorite = hero.favorite
        cdHero.heroDescription = hero.description
        cdHero.photoUrl = hero.photo
        
        return cdHero
    }
    
    var hero: Hero {
        Hero(id: self.id,
             name: self.name,
             description: self.heroDescription,
             photo: self.photoUrl,
             favorite: self.favorite)
    }
    
}
