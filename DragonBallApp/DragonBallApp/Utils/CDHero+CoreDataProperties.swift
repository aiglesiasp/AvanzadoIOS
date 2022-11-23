//
//  CDHero+CoreDataProperties.swift
//  DragonBallApp
//
//  Created by Aitor Iglesias Pubill on 22/11/22.
//
//

import Foundation
import CoreData


extension CDHero {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<CDHero> {
        return NSFetchRequest<CDHero>(entityName: "CDHero")
    }

    @NSManaged public var name: String
    @NSManaged public var id: String
    @NSManaged public var heroDescription: String
    @NSManaged public var favorite: Bool
    @NSManaged public var photoUrl: URL

}

extension CDHero : Identifiable {

}
