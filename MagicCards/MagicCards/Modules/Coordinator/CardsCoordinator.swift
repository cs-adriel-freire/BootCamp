//
//  CardsCoordinator.swift
//  MagicCards
//
//  Created by c.cruz.agra.lopes on 16/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit

final class CardsCoordinator {
    typealias Repository = CardsRepositoryProtocol & CardDetailsRepositoryProtocol

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

extension CardsCoordinator: Coordinator {

    func start() {
        let cardsViewController = CardsViewController(repository: self.repository)
        self.rootController.pushViewController(cardsViewController, animated: true)
    }
}
