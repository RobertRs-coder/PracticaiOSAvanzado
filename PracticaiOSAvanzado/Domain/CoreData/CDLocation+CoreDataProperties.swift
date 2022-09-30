//
//  CDLocation+CoreDataProperties.swift
//  PracticaiOSAvanzado
//
//  Created by Roberto Rojo Sahuquillo on 30/9/22.
//
//

import Foundation
import CoreData


extension CDLocation {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<CDLocation> {
        return NSFetchRequest<CDLocation>(entityName: "CDLocation")
    }

    @NSManaged public var id: String
    @NSManaged public var latitud: Double
    @NSManaged public var longitud: Double
    @NSManaged public var hero: CDHero?

}

extension CDLocation : Identifiable {

}
