//
//  CDLocations+CoreDataProperties.swift
//  DragonBallApp
//
//  Created by Aitor Iglesias Pubill on 23/11/22.
//
//

import Foundation
import CoreData


extension CDLocations {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<CDLocations> {
        return NSFetchRequest<CDLocations>(entityName: "CDLocations")
    }

    @NSManaged public var id: String
    @NSManaged public var latitud: String
    @NSManaged public var longitud: String
    @NSManaged public var dateShow: String
    @NSManaged public var hero: CDHero

}

extension CDLocations : Identifiable {

}
