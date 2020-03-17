//
//  CardsStorageProviderTest.swift
//  MagicCardsTests
//
//  Created by Adriel de Arruda Moura Freire on 16/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

// swiftlint:disable all

@testable import MagicCards
import XCTest
import Foundation
import CoreData

class CardsStorageProvideTest: XCTestCase {
    
    var sut: CardsStorageProvider!
    
    lazy var mockPersistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CardsDataModel", managedObjectModel: mockManagedObject)
        return container
    }()
    
    lazy var mockManagedObject: NSManagedObjectModel = {
        let managedObject = NSManagedObjectModel.mergedModel(from: [Bundle(for: type(of: self))])!
        return managedObject
    }()
    
    override func setUp() {
        super.setUp()
        sut = CardsStorageProvider(container: mockPersistentContainer)
        insertInitialItens()
    }
    
    override func tearDown() {
        removeAllItens()
        super.tearDown()
    }
    
    func testSave() {
        let oldItensCount = numberOfItemsInPersistentStore()
        sut.save(objects: [Card(id: "b", name: "test", imageUrl: "", types: [""])])
        let newItensCount = numberOfItemsInPersistentStore()
        
        assert(oldItensCount == (newItensCount - 1))
    }
    
    func testFetch() {
        let itens = sut.fetch()
        assert(itens.count == 2)
    }
    
    func testfetchedObjectValue() {
        let card = Card(id: "01", name: "First Object", imageUrl: "imageurl.com.br", types: ["agua", "fogo", "terra", "ar"])
        let fetchedCards = sut.fetch()
        assert(fetchedCards.contains(where: {$0.name == card.name})) 
    }
    
    func testReset() {
        sut.reset()
        let countItens = numberOfItemsInPersistentStore()
        assert(countItens == 0)
    }
    
    func testDelete() {
        let oldItensCount = numberOfItemsInPersistentStore()
        let card = Card(id: "01", name: "First Object", imageUrl: "imageurl.com.br", types: ["agua", "fogo", "terra", "ar"])
        sut.delete(objects: [card])
        let newItensCount = numberOfItemsInPersistentStore()
        
        assert(oldItensCount - 1 == newItensCount)
    }
    
    private func insertInitialItens() {
        let obj1 = NSEntityDescription.insertNewObject(forEntityName: "CDCard", into: mockPersistentContainer.viewContext)
        obj1.setValue("First Object", forKey: "name")
        obj1.setValue("01", forKey: "id")
        obj1.setValue("imageurl.com.br", forKey: "imageUrl")
        obj1.setValue(["agua", "fogo", "terra", "ar"], forKey: "types")
        
        let obj2 = NSEntityDescription.insertNewObject(forEntityName: "CDCard", into: mockPersistentContainer.viewContext)
        obj2.setValue("second Object", forKey: "name")
        
        do {
            try mockPersistentContainer.viewContext.save()
        }  catch {
            print("Create initial itens failed: \(error)")
        }
    }
    
    private func removeAllItens() {
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "CDCard")
        let objs = try! mockPersistentContainer.viewContext.fetch(fetchRequest)
        for case let obj as NSManagedObject in objs {
            mockPersistentContainer.viewContext.delete(obj)
        }
        
        try! mockPersistentContainer.viewContext.save()
    }
    
    func numberOfItemsInPersistentStore() -> Int {
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "CDCard")
        let results = try! mockPersistentContainer.viewContext.fetch(request)
        return results.count
    }
}
