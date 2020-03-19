//
//  FavoritesCoordinator.swift
//  MagicCards
//
//  Created by c.cruz.agra.lopes on 16/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit

final class FavoritesCoordinator {
    typealias Repository = FavoriteCardsRepositoryProtocol & FavoriteCardDetailsRepositoryProtocol

    // MARK: - Variables

    // MARK: Coordinator protocol

    var rootController: UINavigationController
    var childCoordinators: [Coordinator]

    // MARK: Repository

    let repository: Repository

    // MARK: - Methods

    // MARK: Initializers

    init(navigationController: UINavigationController, repository: Repository) {
        self.rootController = navigationController
        self.repository = repository
        self.childCoordinators = []
    }
}

// MARK: - Coordinator

extension FavoritesCoordinator: Coordinator {

    func start() {
        let favoritesViewController = FavoritesViewController(repository: self.repository)
        self.rootController.pushViewController(favoritesViewController, animated: true)
    }
}
