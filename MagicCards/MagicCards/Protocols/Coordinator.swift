//
//  Coordinator.swift
//  MagicCards
//
//  Created by lucca.f.ferreira on 13/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit

protocol Coordinator {
    var rootController: UINavigationController { get set }
    var childCoordinators: [Coordinator] { get set }

    func start()
}
