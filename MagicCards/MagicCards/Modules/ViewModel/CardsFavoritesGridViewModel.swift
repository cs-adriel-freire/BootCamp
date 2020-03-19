//
//  CardsFavoritesGridViewModel.swift
//  MagicCards
//
//  Created by lucca.f.ferreira on 19/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import Foundation

struct CardsFavoritesGridViewModel {

    // MARK: - Variables

    let numberOfItems: Int
    let cardCellsViewModel: [CardCellViewModel]

    // MARK: - Methods

    // MARK: Initializers

    init(cards: [Card]) {
        self.numberOfItems = cards.count
        self.cardCellsViewModel = cards.map({ card in
            CardCellViewModel(card: card)
        })
    }
}
