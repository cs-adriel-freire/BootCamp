//
//  CardsStorageProvider.swift
//  MagicCards
//
//  Created by Adriel de Arruda Moura Freire on 16/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import CoreData
final class CardsStorageProvide: StorageProvider {
    func save() {
        
    }
    
    func fetch() {
        
    }
    
    func reset() {
        
    }
    
    let context: NSManagedObjectContext

    init(container: NSPersistentContainer = NSPersistentContainer(name: "CardsStorageProvider")) {
        let container = NSPersistentContainer(name: "ios_recruiting_brazil")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        context = container.viewContext
        
    }
    
    
    
}
