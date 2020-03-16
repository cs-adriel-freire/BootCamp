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

    let image: UIImage

    // MARK: - Methods

    // MARK: Initializers

    init(card: Card) {
        if let data = card.imageData {
            self.image = UIImage(data: data) ?? UIImage()
        } else {
            self.image = UIImage()
        }
    }
}
