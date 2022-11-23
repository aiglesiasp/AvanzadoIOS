//
//  CoreDataManager.swift
//  DragonBallApp
//
//  Created by Aitor Iglesias Pubill on 22/11/22.
//

import Foundation
import CoreData

final class CoreDataManager {
    
    //Variable computada del persistentContainer
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DBZ")
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return container
    }()
    
    
    //Creamos SIngleton de CoreDataManager para poder llamarlo desde donde queramos
    static let shared = CoreDataManager()
    
    //Agregamos el context
    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    //Funcion SAVE Context
    func saveContext() {
        context.saveContext()
    }
    
    //Borrar
    func deleteAll() {
        //TODO: Delete object
        saveContext()
    }
    
    //MARK: - Obtener heroes
    func fetchHeros() -> [CDHero] {
        let request = CDHero.createFetchRequest()
        
        do {
            let result = try context.fetch(request)
            return result
        }catch {
            print("error getting heroes")
        }
        return []
    }
    
    //MARK: - Obtener Localizaciones
    func fetchLocations(for heroId: String) -> [CDLocations] {
        let request = CDLocations.createFetchRequest()
        let predicate = NSPredicate(format: "hero.id == %@", heroId)
        request.predicate = predicate
        
        do {
            let result = try context.fetch(request)
            return result
        }catch {
            print("error getting locations")
        }
        return []
    }
    
}



//MARK: - EXTENSION -
extension NSManagedObjectContext {
    func saveContext() {
        //Mirar si ha habido cambios
        guard hasChanges else {return}
        do {
            try save()
        }catch {
            fatalError("Error: \(error.localizedDescription)")
        }
    }
}
