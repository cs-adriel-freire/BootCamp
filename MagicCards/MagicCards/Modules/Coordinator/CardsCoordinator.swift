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

    // MARK: Image fetcher

    private var imageFetcher: ImageFetcher

    // MARK: - Methods

    // MARK: Initializers

    init(navigationController: UINavigationController = UINavigationController(),
         repository: Repository = CardsRepository(),
         imageFetcher: ImageFetcher = KFImageFetcher()) {
        self.rootController = navigationController
        self.repository = repository
        self.imageFetcher = imageFetcher
        self.childCoordinators = []
    }
}

// MARK: - Coordinator

extension CardsCoordinator: Coordinator {

    func start() {
        let cardsViewController = CardsViewController(repository: self.repository, imageFetcher: self.imageFetcher)
        cardsViewController.delegate = self
        self.rootController.pushViewController(cardsViewController, animated: true)
    }
}

// MARK: - CardsViewControllerDelegate

extension CardsCoordinator: CardsViewControllerDelegate {

    func showDetails(forCard card: Card) {
        let cardDetailsViewController = CardDetailsViewController(card: card, imageFetcher: self.imageFetcher)
        cardDetailsViewController.delegate = self
        self.rootController.pushViewController(cardDetailsViewController, animated: true)
    }
}

// MARK: - CardDetailsViewControllerDelegate

extension CardsCoordinator: CardDetailsViewControllerDelegate {
    func closeDetails() {
        self.rootController.popViewController(animated: true)
    }
}
