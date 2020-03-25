//
//  CardCellViewModel.swift
//  MagicCards
//
//  Created by c.cruz.agra.lopes on 16/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit

struct CardCellViewModel {

    // MARK: - Variables

    let imageUrl: URL?
    let name: String

    // MARK: - Methods

    // MARK: Initializers

    init(card: Card) {
        let alternativeUrl = URL(string: "https://gatherer.wizards.com/Handlers/Image.ashx?name=\(card.name)&type=card")

        if let url = card.imageUrl {
            self.imageUrl = URL(string: url) ?? alternativeUrl
        } else {
            self.imageUrl = alternativeUrl
        }
        self.name = card.name
    }
}

extension CardCellViewModel: Equatable { }
