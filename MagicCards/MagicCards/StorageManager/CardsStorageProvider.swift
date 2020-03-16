//
//  CardsStorageProvider.swift
//  MagicCards
//
//  Created by Adriel de Arruda Moura Freire on 16/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import CoreData
final class CardsStorageProvide: StorageProvider {
    func save(objects: [Card]) {
        objects.forEach({
            let card = CDCard(context: context)
            card.id = $0.id
            card.name = $0.name
            saveContext()
        })
    }
    
    func fetch() -> [Card] {
        var cards = [Card]()
        let fetchedCards = fetchCDCards()
        fetchedCards.forEach({
            let card = Card(id: $0.id ?? "", name: $0.name ?? "", imageUrl: "", types: [""])
            cards.append(card)
        })
        return cards
    }
    
    func reset() {
        let cards = fetchCDCards()
        cards.forEach({context.delete($0)})
        saveContext()
    }
    
    func delete(objects: [Card]) {
        let cards = fetchCDCards()
        cards.forEach { (card) in
            if objects.contains(where: {$0.name == card.name}) {
                context.delete(card)
                saveContext()
            }
        }
        
    }
    
    let context: NSManagedObjectContext
    
    private func fetchCDCards() -> [CDCard] {
        let cardsFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "CDCard")
        if let fetchedCards = try? context.fetch(cardsFetch) as? [CDCard] {
            return fetchedCards
        }
        return []
    }

    init(container: NSPersistentContainer = NSPersistentContainer(name: "CardsDataModel")) {
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        context = container.viewContext
        
    }
    
}
