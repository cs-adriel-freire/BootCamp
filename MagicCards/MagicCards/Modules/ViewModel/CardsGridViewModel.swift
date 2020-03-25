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
    let nextSectionIndex: Int
    let lastSectionCount: Int

    private let cardsBySet: [CardSet: [Card]]

    // MARK: Initializers

    init(cardsBySet: [CardSet: [Card]]) {
        self.cardsBySet = cardsBySet
        let sortedKeysAndValues = cardsBySet.sorted { (lhs, rhs) -> Bool in
            lhs.key.releaseDate > rhs.key.releaseDate
        }

        let cardsGroups = sortedKeysAndValues.map { (arg) -> [Card] in
            arg.value
        }
        
        self.numberOfItemsBySection = cardsGroups.map { cards in
            cards.count
        }

        self.nextSectionIndex = cardsBySet.keys.count
        self.lastSectionCount = self.numberOfItemsBySection.last ?? 0
    }
    
    // MARK: - Methods
    
    func getGroups(forSet set: CardSet) -> [String: [Card]] {
        guard let cards = cardsBySet[set] else {
            return [:]
        }
        
        var dict: [String: [Card]] = [:]
        for card in cards {
            for type in card.types {
                if dict[type] == nil {
                    dict[type] = [card]
                } else {
                    dict[type]?.append(card)
                }
            }
        }

        return dict
    }
    
    func getHeader(forSection section: Int) -> String {
        let heads: [String] = getAllHeaders()
        return heads[section]
    }
    
    func getAllHeaders() -> [String] {
        let sortedKeysAndValues = cardsBySet.sorted { (lhs, rhs) -> Bool in
            lhs.key.releaseDate > rhs.key.releaseDate
        }
        var heads: [String] = []
        for obj in sortedKeysAndValues {
            let set = obj.key
            heads.append(set.name)
            let groups = getGroups(forSet: set)
            let orederedGroups = groups.sorted { (lhs, rhs) -> Bool in
                lhs.key < rhs.key
            }
            let keys: [String] = orederedGroups.map({ $0.key })
            heads.append(contentsOf: keys)
            
        }
        return heads
    }
    
    func checkIfSet(section: Int) -> Bool {
        let headers = getAllHeaders()
        if cardsBySet.keys.contains(where: { (set) -> Bool in set.name == headers[section] }) {
            return true
            
        }
        return false
    }
    
    func getAllItens() -> [[Card]] {
        var itens: [[Card]] = []
        let headers = getAllHeaders()
        var lastSet = ""
        
        for header in headers {
            if cardsBySet.keys.contains(where: { (set) -> Bool in set.name == header }) {
                itens.append([])
                lastSet = header
                continue
            }
            let cards = cardsBySet.filter { (arg) -> Bool in
                arg.key.name == lastSet
            }.map { (arg) -> [Card] in arg.value }.reduce([], +)
            let cardsOfGroup = cards.filter {(card) -> Bool in card.types.contains(header)}

            itens.append(cardsOfGroup)
        }
        return itens
    }
    
    func getItens(forSection section: Int, row: Int) -> Card {
        let itens = getAllItens()
        return itens[section][row]
    }
    
}
