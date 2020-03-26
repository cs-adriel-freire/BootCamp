//
//  CardsGridFooterViewTest.swift
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

final class CardsGridFooterViewTest: XCTestCase {
    
    // MARK: - Variables

    var sut: CardsGridFooterView!

    // MARK: - Methods

    // MARK: Set up
    
    override func setUp() {
        self.sut = CardsGridFooterView(frame: CGRect(x: 0, y: 0, width: 320, height: 568))
    }
    
    // MARK: Tear down

    override func tearDown() {
        self.sut = nil
    }

    // MARK: Tests

    func testLookAndFeelLoading() {
        self.sut.state = .loading
        expect(self.sut) == snapshot("CardsGridFooterView_loading")
    }
    
    func testLookAndFeelError() {
        self.sut.state = .error
        expect(self.sut) == snapshot("CardsGridFooterView_error")
    }
}
