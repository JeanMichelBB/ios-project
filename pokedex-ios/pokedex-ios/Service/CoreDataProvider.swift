//
//  CoreDataProvider.swift
//  pokedex-ios
//
//  Created by Jean-Michel Beaulieu Bérubé on 2023-04-04.
//

import Foundation
import CoreData

protocol CoreDataProviderProtocol {
    func save(context : NSManagedObjectContext) -> UUID?
}
class CoreDataProvider {
    
    static func all(context: NSManagedObjectContext, entityName : String) -> [Any?]{
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        do{
            let allObjects = try context.fetch(request)
            return allObjects
        }catch{
            print("EXCEPTION AT FETCH: \(error.localizedDescription)")
            return []
        }
    }
    static func save(context: NSManagedObjectContext) throws {
        do{
            try context.save()
        }catch{
            print ("EXCEPTION AT SAVE: \(error.localizedDescription)")
            throw error
        }
    }
}

