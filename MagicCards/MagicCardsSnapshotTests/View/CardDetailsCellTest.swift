//
//  CardDetailsCellTest.swift
//  MagicCardsSnapshotTests
//
//  Created by c.cruz.agra.lopes on 20/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit
import Nimble
import Nimble_Snapshots
import XCTest

@testable import MagicCards

final class CardDetailsCellTest: XCTestCase {

    // MARK: - Variables

    var sut: CardDetailsCell!

    // MARK: - Methods

    // MARK: Set up

    override func setUp() {
        self.sut = CardDetailsCell(frame: CGRect(x: 0, y: 0, width: 160, height: 264))
    }

    // MARK: Tear down

    override func tearDown() {
        self.sut = nil
    }

    // MARK: Tests

    func testLookAndFeelWithImage() {
        let card = Card(id: "1669af17-d287-5094-b005-4b143441442f",
                        name: "Abundance",
                        imageUrl: "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=130483&type=card",
                        types: ["Enchantment"])
        self.sut.configure(with: CardCellViewModel(card: card))

        expect(self.sut) == snapshot("CardDetailsCell_withImage")
    }

    func testLookAndFeelWithoutImage() {
        self.sut.configure(with: CardCellViewModel(card: Card(id: "1669af17-d287-5094-b005-4b143441442f",
                                                              name: "Abundance",
                                                              imageUrl: nil,
                                                              types: ["Enchantment"])))

        expect(self.sut) == snapshot("CardDetailsCell_withoutImage")
    }
}
