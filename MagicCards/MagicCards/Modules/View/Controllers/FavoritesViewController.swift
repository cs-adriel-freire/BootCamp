//
//  FavoritesViewController.swift
//  MagicCards
//
//  Created by c.cruz.agra.lopes on 16/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit

final class FavoritesViewController: UIViewController {
    typealias Repository = FavoriteCardsRepositoryProtocol & FavoriteCardDetailsRepositoryProtocol

    // MARK: - Variables

    // MARK: Data

    let favoriteCardsRepository: Repository

    // MARK: - Methods

    // MARK: Initializers

    init(repository: Repository) {
        self.favoriteCardsRepository = repository
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
