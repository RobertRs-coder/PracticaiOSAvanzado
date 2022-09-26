//
//  CDHero+CoreDataProperties.swift
//  PracticaFundamentosiOS
//
//  Created by Roberto Rojo Sahuquillo on 26/9/22.
//
//

import Foundation
import CoreData


extension CDHero {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDHero> {
        return NSFetchRequest<CDHero>(entityName: "CDHero")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: String?
    @NSManaged public var heroDescription: String?
    @NSManaged public var photoUrl: URL?
    @NSManaged public var favorite: Bool

}

extension CDHero : Identifiable {

}
