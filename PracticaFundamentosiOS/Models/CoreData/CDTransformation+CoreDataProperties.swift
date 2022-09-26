//
//  CDTransformation+CoreDataProperties.swift
//  PracticaFundamentosiOS
//
//  Created by Roberto Rojo Sahuquillo on 26/9/22.
//
//

import Foundation
import CoreData


extension CDTransformation {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<CDTransformation> {
        return NSFetchRequest<CDTransformation>(entityName: "CDTransformation")
    }

    @NSManaged public var id: String
    @NSManaged public var name: String
    @NSManaged public var photoUrl: URL
    @NSManaged public var transformationDescription: String
    @NSManaged public var hero: CDHero?

}

extension CDTransformation : Identifiable {

}
