//
//  CDHero+CoreDataProperties.swift
//  DragonBallApp
//
//  Created by Aitor Iglesias Pubill on 23/11/22.
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

}

// MARK: Generated accessors for locations
extension CDHero {

    @objc(addLocationsObject:)
    @NSManaged public func addToLocations(_ value: CDLocations)

    @objc(removeLocationsObject:)
    @NSManaged public func removeFromLocations(_ value: CDLocations)

    @objc(addLocations:)
    @NSManaged public func addToLocations(_ values: NSSet)

    @objc(removeLocations:)
    @NSManaged public func removeFromLocations(_ values: NSSet)

}

extension CDHero : Identifiable {

}
