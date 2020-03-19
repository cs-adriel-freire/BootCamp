//
//  FavoritesCoordinator.swift
//  MagicCards
//
//  Created by c.cruz.agra.lopes on 16/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit

final class FavoritesCoordinator {

    // MARK: - Variables

    // MARK: Coordinator protocol

    var rootController: UINavigationController
    var childCoordinators: [Coordinator]
    let repository: FavoriteCardsRepositoryProtocol
    
    // MARK: - Methods

    // MARK: Initializers

    init(navigationController: UINavigationController, repository: FavoriteCardsRepositoryProtocol) {
        self.rootController = navigationController
        self.childCoordinators = []
        self.repository = repository
    }
}

// MARK: - Coordinator

extension FavoritesCoordinator: Coordinator {

    func start() {
        let favoritesViewController = FavoritesViewController()
        self.rootController.pushViewController(favoritesViewController, animated: true)
    }
}
