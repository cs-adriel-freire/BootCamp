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
    func save()
    func fetch()
    func reset()
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
