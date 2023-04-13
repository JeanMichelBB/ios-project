//
//  User.swift
//  pokedex-ios
//
//  Created by Jean-Michel Beaulieu Bérubé on 2023-04-04.
//

import Foundation
import CoreData

extension User : CoreDataProviderProtocol {
    
    static let entityName = "User"
    
    static func all(context: NSManagedObjectContext) -> [User] {
        return CoreDataProvider.all(context: context, entityName: User.entityName) as! [User]
    }
    
    func save(context: NSManagedObjectContext) -> UUID? {
        if self.uuid == nil {
            self.uuid = UUID()
        }
        do{
            try CoreDataProvider.save(context: context)
            return self.uuid
        }catch{
            return nil
        }
    }
    
    
    static func findByUsername( context: NSManagedObjectContext, username : String ) -> User? {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: User.entityName)
        fetchRequest.predicate = NSPredicate(format: "username == %@", username)
        
        do {
            let result = try context.fetch(fetchRequest)
            if result.count > 0 {
                return result[0] as? User
            }
        } catch {
            print("Failed")
        }
        return nil
    }    
}

