//
//  CDHero+CoreDataProperties.swift
//  PracticaiOSAvanzado
//
//  Created by Roberto Rojo Sahuquillo on 1/10/22.
//
//

import Foundation
import CoreData


extension CDHero {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<CDHero> {
        return NSFetchRequest<CDHero>(entityName: "CDHero")
    }

    @NSManaged public var favorite: Bool
    @NSManaged public var heroDescription: String
    @NSManaged public var id: String
    @NSManaged public var name: String
    @NSManaged public var photoUrl: URL
    @NSManaged public var locations: NSSet?
    @NSManaged public var transformations: NSSet?

}

// MARK: Generated accessors for locations
extension CDHero {

    @objc(addLocationsObject:)
    @NSManaged public func addToLocations(_ value: CDLocation)

    @objc(removeLocationsObject:)
    @NSManaged public func removeFromLocations(_ value: CDLocation)

    @objc(addLocations:)
    @NSManaged public func addToLocations(_ values: NSSet)

    @objc(removeLocations:)
    @NSManaged public func removeFromLocations(_ values: NSSet)

}

// MARK: Generated accessors for transformations
extension CDHero {

    @objc(addTransformationsObject:)
    @NSManaged public func addToTransformations(_ value: CDTransformation)

    @objc(removeTransformationsObject:)
    @NSManaged public func removeFromTransformations(_ value: CDTransformation)

    @objc(addTransformations:)
    @NSManaged public func addToTransformations(_ values: NSSet)

    @objc(removeTransformations:)
    @NSManaged public func removeFromTransformations(_ values: NSSet)

}

extension CDHero : Identifiable {

}
