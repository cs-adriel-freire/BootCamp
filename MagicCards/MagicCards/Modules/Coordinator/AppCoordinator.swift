//
//  AppCoordinator.swift
//  MagicCards
//
//  Created by c.cruz.agra.lopes on 16/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit

final class AppCoordinator {

    // MARK: - Variables

    // MARK: Coordinator protocol

    var rootController: UINavigationController
    var childCoordinators: [Coordinator]

    // MARK: TabBarController

    private var tabBarController: UITabBarController

    // MARK: - Methods

    // MARK: Initializers

    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
        self.rootController = UINavigationController(rootViewController: self.tabBarController)
        self.childCoordinators = []
    }
}

// MARK: - Coordinator

extension AppCoordinator: Coordinator {

    func start() {

        // All cards' tab

        let cardsNavigationController = UINavigationController()
        cardsNavigationController.tabBarItem = UITabBarItem(title: "Cards", image: nil, tag: 0)
        let cardsCoordinator = CardsCoordinator(navigationController: cardsNavigationController)

        cardsCoordinator.start()

        // Favorite cards' tab

        let favoritesNavigationController = UINavigationController()
        favoritesNavigationController.tabBarItem = UITabBarItem(title: "Favorites", image: nil, tag: 0)
        let favoritesCoordinator = FavoritesCoordinator(navigationController: favoritesNavigationController)

        favoritesCoordinator.start()

        // Tabs setup

        self.tabBarController.viewControllers = [cardsNavigationController, favoritesNavigationController]
        self.childCoordinators = [cardsCoordinator, favoritesCoordinator]
    }
}
