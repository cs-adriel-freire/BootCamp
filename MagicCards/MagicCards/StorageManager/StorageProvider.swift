//
//  StoreManager.swift
//  MagicCards
//
//  Created by Adriel de Arruda Moura Freire on 16/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import Foundation
import CoreData
protocol StorageProvider {
    associatedtype Object
    func save(objects: [Object])
    func fetch() -> [Object]
    func reset()
    func delete(objects: [Object])
    init(container: NSPersistentContainer)
    var context: NSManagedObjectContext {get}
}

extension StorageProvider {
    func saveContext() {
        do {
            try context.save()
        } catch {
            fatalError("Failure to get context\(error)")
        }
    }
}
