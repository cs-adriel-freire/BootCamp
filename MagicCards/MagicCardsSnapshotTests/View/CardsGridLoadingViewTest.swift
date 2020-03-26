//
//  CardsGridLoadingViewTest.swift
//  MagicCardsSnapshotTests
//
//  Created by lucca.f.ferreira on 25/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import Foundation

import UIKit
import Nimble
import Nimble_Snapshots
import XCTest

@testable import MagicCards

final class CardsGridLoadingViewTest: XCTestCase {
    
    // MARK: - Variables

    var sut: CardsGridLoadingView!

    // MARK: - Methods

    // MARK: Set up
    
    override func setUp() {
        self.sut = CardsGridLoadingView(frame: CGRect(x: 0, y: 0, width: 320, height: 568))
    }
    
    // MARK: Tear down

    override func tearDown() {
        self.sut = nil
    }

    // MARK: Tests

    func testLookAndFeel() {
        expect(self.sut) == snapshot("CardsGridLoadingView")
    }
    
}
