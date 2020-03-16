//
//  CardsCoordinatorTest.swift
//  MagicCardsTests
//
//  Created by c.cruz.agra.lopes on 16/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import XCTest

@testable import MagicCards

class CardsCoordinatorTest: XCTestCase {

    // MARK: - Variables

    var sut: CardsCoordinator!
    var navigationController: UINavigationController!

    // MARK: - Methods

    // MARK: Set up

    override func setUp() {
        self.navigationController = UINavigationController()
        self.sut = CardsCoordinator(navigationController: self.navigationController)
    }

    // MARK: Tear down

    override func tearDown() {
        self.sut = nil
        self.navigationController = nil
    }

    // MARK: Tests

    func testInitialization() {
        XCTAssert(self.sut.rootController == self.navigationController!)
    }

    func testStart() {
        self.sut?.start()

        let viewControllers = self.sut.rootController.viewControllers
        guard viewControllers.count == 1 else {
            XCTFail("Expected one viewController")
            return
        }

        XCTAssert(viewControllers[0] is CardsViewController)
        XCTAssert(self.sut.childCoordinators.isEmpty)
    }
}
