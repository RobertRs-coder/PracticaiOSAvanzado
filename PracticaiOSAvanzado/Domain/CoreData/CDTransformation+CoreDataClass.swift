//
//  CDTransformation+CoreDataClass.swift
//  PracticaFundamentosiOS
//
//  Created by Roberto Rojo Sahuquillo on 26/9/22.
//
//

import Foundation
import CoreData

@objc(CDTransformation)
public class CDTransformation: NSManagedObject {

}

extension CDTransformation {
    static func create(from transformation: Transformation, for hero: CDHero, context: NSManagedObjectContext) -> CDTransformation {
        let cdTransformation = CDTransformation(context: context)
        
        cdTransformation.id = transformation.id
        cdTransformation.name = transformation.name
        cdTransformation.transformationDescription = transformation.description
        cdTransformation.photoUrl = transformation.photo
        cdTransformation.hero = hero
        
        return cdTransformation
    }
    
    var transformation: Transformation {
        Transformation(photo: self.photoUrl,
                       id: self.id,
                       name: self.name,
                       description: self.transformationDescription)
    }
}
