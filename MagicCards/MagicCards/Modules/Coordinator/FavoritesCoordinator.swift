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

    // MARK: - Methods

    // MARK: Initializers

    init(navigationController: UINavigationController) {
        self.rootController = navigationController
        self.childCoordinators = []
    }
}

// MARK: - Coordinator

extension FavoritesCoordinator: Coordinator {

    func start() {
        let favoritesViewController = FavoritesViewController()
        self.rootController.pushViewController(favoritesViewController, animated: true)
    }
}
