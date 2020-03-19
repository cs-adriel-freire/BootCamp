//
//  AppCoordinatorTest.swift
//  MagicCardsTests
//
//  Created by c.cruz.agra.lopes on 16/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import XCTest

@testable import MagicCards

final class AppCoordinatorTest: XCTestCase {

    // MARK: - Variables

    var sut: AppCoordinator!
    var tabBarController: UITabBarController!

    // MARK: - Methods

    // MARK: Set up

    override func setUp() {
        self.tabBarController = UITabBarController()
        self.sut = AppCoordinator(tabBarController: self.tabBarController)
    }

    // MARK: Tear down

    override func tearDown() {
        self.sut = nil
        self.tabBarController = nil
    }

    // MARK: Tests

    func testInitialization() {
        XCTAssert(self.sut.rootController.viewControllers == [self.tabBarController!])
    }

    func testStart() {
        self.sut?.start()

        XCTAssert(self.tabBarController.viewControllers?.count == 2)
        XCTAssert(self.sut.childCoordinators.count == 2)
    }
}
