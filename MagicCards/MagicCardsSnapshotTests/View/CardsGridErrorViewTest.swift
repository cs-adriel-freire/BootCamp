//
//  CardGridErrorViewTest.swift
//  MagicCardsSnapshotTests
//
//  Created by lucca.f.ferreira on 20/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import Foundation

import UIKit
import Nimble
import Nimble_Snapshots
import XCTest

@testable import MagicCards

final class CardsGridErrorViewTest: XCTestCase {
    
    // MARK: - Variables

    var sut: CardsGridErrorView!

    // MARK: - Methods

    // MARK: Set up
    
    override func setUp() {
        self.sut = CardsGridErrorView(frame: CGRect(x: 0, y: 0, width: 320, height: 568), delegate: nil)
    }
    
    // MARK: Tear down

    override func tearDown() {
        self.sut = nil
    }

    // MARK: Tests

    func testLookAndFeel() {
        expect(self.sut) == snapshot("CardsGridErrorView")
    }
    
}
