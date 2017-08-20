//
//  PersistenceEngine.swift
//  Pods
//
//  Created by Timothy S Bowers on 19/8/17.
//  Copyright © 2017 Timothy Bowers. All rights reserved.
//
//

import CoreData

/**
 PersistenceEngine uses this name to store your dictionaries in Core Data.
 You have to create an **attribute** with this name for each *entity* you add to your *Data Mode*.
 */
let DictionaryAttribute = "coredictionary"

/**
 **Data Model**
 
 You have to create this file, *Data Model (Core Data)* in your application folder (Main Bundle)
 */
let CoreDataSQLiteFileName = "PersistenceEngineDB"  // Do not include the .xcdatamodeld extension

/**
 
 Manage Core Data for Dictionaries
 
 - Author:
 Timothy S Bowers
 
 **Description:**
 
 Making life easier to save and manage Dictionaries into Core Data for persistence.
 
 **Requirements:**
 
 *STEP1:*
 You have to create a file, *Data Model (Core Data)* in your application folder (Main Bundle)
 
 *STEP2:*
 You have to create an **attribute** with the name 'coredictionary' for each *entity* you add to your *Data Model*.
 
 */

public class PersistenceEngine {
    
    /// Array of Core Data Objects
    private var entityArray: [NSManagedObject] = []
    
    public init() {
        print("PersistenceEngine version 0.2.2")
        print()
        
        print("Entity list in DB: \(self.entityNames())")
        print()
        
        self.loadStores()
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        return NSPersistentContainer(name: CoreDataSQLiteFileName)
    }()
    
    private func loadCoreDataEntityTransformable(entity: NSManagedObject, field: String) -> [String: Any] {
        guard let loadedEntity = entity.value(forKeyPath: field) as? [String : Any] else {
            print("'",field, "' not found")
            return ["":"" as Any]
        }
        return loadedEntity
    }
    
    public func entityNames() -> [String] {
        let names = persistentContainer.managedObjectModel.entities.map({ (entity) -> String in
            return entity.name ?? "nil entity name"
        })
        return names
    }
    
    public func printCoreData(entity: String) {
        self.reload(entity: entity)
        print()
        print("------[ printDebug output start ]-----[ \(entity) ]----");
        print("amount of core data objects stored = ", self.entityArray.count)
        
        for (index, item) in entityArray.enumerated() {
            
            print("index = ", index)
            
            let coredictionary = self.loadCoreDataEntityTransformable(entity: item, field: DictionaryAttribute)
            
            print("coredictionary = ", coredictionary)
            
        }
        print("------[ printDebug output stop ]-----[ \(entity) ]----");
        print()
    }
    
    
    public func dictionaryFrom(entity: String) -> [[String: Any]] {
        self.reload(entity: entity)
        
        var coreDictionaryArray = [[String: Any]]()
        for item in entityArray {
            
            let coreDictionary = self.loadCoreDataEntityTransformable(entity: item, field: DictionaryAttribute)
            coreDictionaryArray.append(coreDictionary)
            
        }
        print("\(coreDictionaryArray.count) dictionaries read from entity \(entity)")
        return coreDictionaryArray
    }
    
    
    public func insert(dictionary: [String : Any], intoEntity: String) {
        guard let entity = NSEntityDescription.entity(forEntityName: intoEntity, in: self.persistentContainer.viewContext) else {
            print(#function,"failed. Could not find entity (table) named '",intoEntity,"'")
            print("Make sure you have added an entity named '\(intoEntity)' to your \(CoreDataSQLiteFileName).xcdatamodeld file")
            return
        }
        
        let newObject = NSManagedObject(entity: entity, insertInto: persistentContainer.viewContext)
        
        newObject.setValue(dictionary, forKeyPath: DictionaryAttribute)
        
        do {
            try persistentContainer.viewContext.save()
            print("inserted dictionary into \(intoEntity)")
            
        } catch let error as NSError {
            
            print("Could not save. \(error), \(error.userInfo)")
            
        }
    }
    
    
    private func reload(entity: String) {
        guard let _ = NSEntityDescription.entity(forEntityName: entity, in: self.persistentContainer.viewContext) else {
            print(#function,"failed. Could not find entity named '",entity,"'")
            print("Make sure you have added an entity named '\(entity)' to your \(CoreDataSQLiteFileName).xcdatamodeld file")
            return
        }
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entity)
        
        do {
            self.entityArray = try persistentContainer.viewContext.fetch(fetchRequest)
            
        } catch let error as NSError {
            
            print(#function,"failed. Could not fetch. \(error), \(error.userInfo)")
            
        }
    }
    
    
    public func clear(entity: String) {
        guard let _ = NSEntityDescription.entity(forEntityName: entity, in: self.persistentContainer.viewContext) else {
            print(#function,"failed. Could not find entity named '",entity,"'")
            print("Make sure you have added an entity named '\(entity)' to your \(CoreDataSQLiteFileName).xcdatamodeld file")
            return
        }
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try persistentContainer.viewContext.execute(deleteRequest)
            try persistentContainer.viewContext.save()
            self.entityArray.removeAll()
            print("cleared '\(entity)' of all data")
            
        } catch let error as NSError {
            
            print(#function,"failed. Could not clear entity. \(error), \(error.userInfo)")
            
        }
    }
    
    
    private func loadStores() {
        let container = self.persistentContainer
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                
                /*
                 Pull request will be accepted if anyone wants to do the error handling.
                 */
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
                
            } else {
                
                print("DB loaded: \(storeDescription)")
                print()
            }
            
        })
        
    }
    
}
