//
//  CardsGridViewModel.swift
//  MagicCards
//
//  Created by c.cruz.agra.lopes on 17/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

struct CardsGridViewModel {

    // MARK: - Variables

    let numberOfSections: Int
    let numberOfItemsBySection: [Int]
    let headerTitleBySection: [String]
    let viewModelBySection: [[CardCellViewModel]]

    // MARK: - Methods

    // MARK: Initializers

    init(cardsBySet: [CardSet: [Card]]) {
        let sortedKeysAndValues = cardsBySet.sorted { (lhs, rhs) -> Bool in
            lhs.key.releaseDate > rhs.key.releaseDate
        }
        let cardSets = sortedKeysAndValues.map { (arg) -> CardSet in
            arg.key
        }
        let cardsGroups = sortedKeysAndValues.map { (arg) -> [Card] in
            arg.value
        }

        self.numberOfSections = cardSets.count
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
    }
}
