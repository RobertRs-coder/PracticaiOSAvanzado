//
//  CDLocation+CoreDataClass.swift
//  PracticaiOSAvanzado
//
//  Created by Roberto Rojo Sahuquillo on 30/9/22.
//
//

import Foundation
import CoreData

@objc(CDLocation)
public class CDLocation: NSManagedObject {

}

extension CDLocation {
    static func create(from location: Location, for hero: CDHero, context: NSManagedObjectContext) -> CDLocation {
        let cdLocation = CDLocation(context: context)
        
        cdLocation.id = location.id
        cdLocation.latitud = location.latitud
        cdLocation.longitud = location.longitud
        cdLocation.hero = hero
        
        return cdLocation
    }
    
    var location: Location {
        Location(id: self.id,
                 latitud: self.latitud,
                 longitud: self.longitud)
    }
}
