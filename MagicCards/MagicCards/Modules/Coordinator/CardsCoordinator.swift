//
//  CardsCoordinator.swift
//  MagicCards
//
//  Created by c.cruz.agra.lopes on 16/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit

final class CardsCoordinator {

    // MARK: - Variables

    // MARK: Coordinator protocol

    var rootController: UINavigationController
    var childCoordinators: [Coordinator]
    let repository: CardsRepository

    // MARK: - Methods

    // MARK: Initializers

    init(navigationController: UINavigationController, repository: CardsRepository) {
        self.rootController = navigationController
        self.childCoordinators = []
        self.repository = repository
    }
}

// MARK: - Coordinator

extension CardsCoordinator: Coordinator {

    func start() {
        let cardsViewController = CardsViewController()
        self.rootController.pushViewController(cardsViewController, animated: true)
    }
}
