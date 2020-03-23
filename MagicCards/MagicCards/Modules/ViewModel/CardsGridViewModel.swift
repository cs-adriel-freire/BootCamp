//
//  CardsGridViewModel.swift
//  MagicCards
//
//  Created by c.cruz.agra.lopes on 17/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

struct CardsGridViewModel {

    // MARK: - Variables

    let numberOfItemsBySection: [Int]
    let headerTitleBySection: [String]
    let viewModelBySection: [[CardCellViewModel]]
    let nextSectionIndex: Int
    let lastSectionCount: Int
    
    var currentGroup = ""

    let cardsBySet: [CardSet: [Card]]
    

    var currentSet = 0
    // MARK: - Methods

    // MARK: Initializers

    init(cardsBySet: [CardSet: [Card]]) {
        self.cardsBySet = cardsBySet
        let sortedKeysAndValues = cardsBySet.sorted { (lhs, rhs) -> Bool in
            lhs.key.releaseDate > rhs.key.releaseDate
        }
        let cardSets = sortedKeysAndValues.map { (arg) -> CardSet in
            arg.key
        }
        let cardsGroups = sortedKeysAndValues.map { (arg) -> [Card] in
            arg.value
        }
        
        self.numberOfItemsBySection = cardsGroups.map { cards in
            cards.count
        }
        self.headerTitleBySection = cardSets.map { cardSet in
            cardSet.name
        }
        self.viewModelBySection = cardsGroups.map { cards in
            cards.map { card in
                CardCellViewModel(card: card)
            }
        }

        self.nextSectionIndex = cardsBySet.keys.count
        self.lastSectionCount = self.numberOfItemsBySection.last ?? 0
    }
    
    func getCardsGroups() -> [String] {
        if cardsBySet.keys.isEmpty {
            return []
        }
        var groups: [String] = []
        
        let sortedKeysAndValues = cardsBySet.sorted { (lhs, rhs) -> Bool in
            lhs.key.releaseDate > rhs.key.releaseDate
        }
        let cardsGroups = sortedKeysAndValues.map { (arg) -> [Card] in
            arg.value
        }
        
        for index in 0 ... cardsBySet.keys.count - 1 {
            let cards = cardsGroups[index]
            
            let groupsDictionary = Dictionary.init(grouping: cards, by: {$0.types[0]})
            let keys: [String] = groupsDictionary.map({ $0.key })
            groups.append(contentsOf: keys)
            
        }
        return groups
    }
    
    func getGroups(forSet set: CardSet) -> [String: [Card]] {
        guard let cards = cardsBySet[set] else {
            return [:]
        }
        let groupsDictionary = Dictionary.init(grouping: cards, by: {$0.types[0]})

        return groupsDictionary
    }
    func getHeader(idp: Int) -> String {
        var heads: [String] = []
        for set in cardsBySet.keys {
            heads.append(set.name)
            let groups = getGroups(forSet: set)
            let orederedGroups = groups.sorted { (lhs, rhs) -> Bool in
                lhs.key < rhs.key
            }
            let keys: [String] = orederedGroups.map({ $0.key })
            heads.append(contentsOf: keys)
            
        }
        return heads[idp]
    }
    func getHeaders() -> [String] {
        var heads: [String] = []
        for set in cardsBySet.keys {
            heads.append(set.name)
            let groups = getGroups(forSet: set)
            let keys: [String] = groups.map({ $0.key })
            heads.append(contentsOf: keys)
            
        }
        return heads
    }
    
    func itens(forSet set: CardSet, andGroup group: String) -> [Card] {
        let groups = getGroups(forSet: set)
        guard let cards = groups[group] else { return []}
        return cards
    }
    func getNumberOfSections() -> Int {
        var totalGroups = 0
        for set in cardsBySet.keys {
            let groups = getGroups(forSet: set)
            totalGroups += groups.keys.count
        }
        return cardsBySet.keys.count + totalGroups
    }
    
    func getHeaderTitle(forSection section: Int) -> String {
        let sortedKeysAndValues = cardsBySet.sorted { (lhs, rhs) -> Bool in
            lhs.key.releaseDate > rhs.key.releaseDate
        }
        let cardSets = sortedKeysAndValues.map { (arg) -> CardSet in
            arg.key
        }
        for set in cardSets {
            
        }
        return getCardsGroups()[section]
        
    }
}
