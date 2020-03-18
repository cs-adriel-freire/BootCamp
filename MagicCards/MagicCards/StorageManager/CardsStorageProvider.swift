//
//  CardsStorageProvider.swift
//  MagicCards
//
//  Created by Adriel de Arruda Moura Freire on 16/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import CoreData
final class CardsStorageProvider: StorageProvider {
    
    private let context: NSManagedObjectContext
    var dealWithErrors: () -> Void
    
    func save(objects: [Card]) {
        objects.forEach { (cardToSave) in
            let card = CDCard(context: context)
            card.id = cardToSave.id
            card.name = cardToSave.name
            card.imageData = cardToSave.imageData
            card.types = cardToSave.types
            saveContext()
        }
    }
    
    func fetch() -> [Card] {
        return fetchCDCards().map({ card in
            return Card(id: card.id ?? "", name: card.name ?? "", imageUrl: nil, imageData: card.imageData, types: card.types ?? [])
        })
    }
    
    func reset() {
        fetchCDCards().forEach(context.delete)
        saveContext()
    }
    
    func delete(objects: [Card]) {
        fetchCDCards().filter { (card) -> Bool in
            objects.contains { (objetc) -> Bool in
                objetc.name == card.name
            }
        }.forEach(context.delete)
        saveContext()
    }
    
    private func fetchCDCards() -> [CDCard] {
        let cardsFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "CDCard")
        guard let fetchedCards = try? context.fetch(cardsFetch) as? [CDCard] else {
            return []
        }
        return fetchedCards
    }
    
    func saveContext() {
        do {
            try context.save()
        } catch {
            dealWithErrors()
        }
    }

    init(container: NSPersistentContainer = NSPersistentContainer(name: "CardsDataModel"), onError errorTreatment: @escaping () -> Void) {
        container.loadPersistentStores(completionHandler: { (_, error) in
            if error != nil {
                errorTreatment()
            }
        })
        context = container.viewContext
        dealWithErrors = errorTreatment
        
    }
    
}
