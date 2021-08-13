//
//  DatabaseHandler.swift
//  FreshWorksAssignment
//
//  Created by Happy on 2021-08-09.
//


import Foundation
import UIKit
import CoreData

// MARK:- Core Data methods
class DatabaseHandler {
    private let viewContext = CoreDataStack.sharedInstance.persistentContainer.viewContext
    
    func add<T: NSManagedObject>(_ type: T.Type) -> T? {
        guard let entityName = T.entity().name else { return nil }
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: viewContext) else { return nil }
        let object = T(entity: entity, insertInto: viewContext)
        return object
    }
    func clearData<T: NSManagedObject>(_ type: T.Type) {
            do {
                guard let entityName = T.entity().name else { return }
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
                do {
                    let objects  = try viewContext.fetch(fetchRequest) as? [NSManagedObject]
                    _ = objects.map{$0.map{viewContext.delete($0)}}
                   save()
                } catch let error {
                    print("ERROR DELETING : \(error)")
                }
            }
            
        }
    
    func fetch<T: NSManagedObject>(_ type: T.Type) -> [T] {
        let request = T.fetchRequest()
        do {
            let result =  try viewContext.fetch(request)
        return result as! [T]
        } catch  {
            print(error.localizedDescription)
            return []
        }
    }

    
    func save(){
        do {
            try viewContext.save()
            
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func delete<T: NSManagedObject>(object: T) {
        viewContext.delete(object)
        save()
    }
}
